---
name: targeted-prospecting
description: Build a prospect list of companies with decision makers, verified contact info, and hiring/intent signals. Use when asked to find leads by industry, build an account list with specific titles, prospect companies that are actively hiring, or create a targeted outreach list filtered by company size, location, and hiring activity.
---

# Targeted Prospecting — Lean

Build a prioritized prospect list for any industry. Finds decision makers at companies matching your ICP, reveals verified contact info, and layers on hiring signals to prioritize who's ready to buy now.

This skill orchestrates **4 APIs**: **Apollo** (people search + reveal + job postings), **Hunter** (email verification), **Sixtyfour** (phone discovery). Expected runtime: **~3–5 min for 25 prospects without phones**, **~10–15 min with phones** (Sixtyfour's tail latency dominates). Phone discovery is opt-in by default for this reason — see Step 6.

## Concurrency rules

These rules are load-bearing — without them the skill takes 2–3× longer.

- **Issue all parallel-safe calls in a single tool-call batch**, not sequentially. When the workflow says "for each prospect, fire N calls in parallel," issue them as N tool calls in **one assistant message** — do not sequence them.
- **Real data dependencies (must sequence):**
  - Step 2 → Step 3: Step 3 needs the `id` field from each person in the Step 2 response.
  - Step 3 → Steps 4/5/6: Step 4 needs the `email` revealed in Step 3; Step 5 needs the `organization.id` revealed in Step 3 (the search response in Step 2 does NOT include org IDs); Step 6 needs the real `last_name` + `linkedin_url` from Step 3.
- **Parallel-safe within each step:**
  - Step 3 fans out N parallel calls (one per person from Step 2).
  - Steps 4 + 5 + 6 each fan out N parallel calls AND can run concurrently with each other (no dependency between verifying email, fetching job postings, and finding phone).
- The optimal cadence is therefore: **1 call (Step 2) → N parallel calls (Step 3) → 3N parallel calls (Steps 4 + 5 + 6 simultaneously)**. Three round trips total, regardless of N.

## Workflow

### 1. Parse the request

Extract from the user's query:
- **Industry/vertical** (required) — e.g., staffing, fintech, healthcare IT
- **Decision maker titles** (required) — e.g., COO, VP Engineering, Head of Operations
- **Location** (default: US) — country, state, region; map to Apollo location strings
- **Company size** (optional) — translate to Apollo `organization_num_employees_ranges` (e.g., 100+ FTE → `["100,500", "500,1000", "1000,5000", "5000,10000", "10000,1000000"]`)
- **Seniority** (optional) — Apollo accepts: `owner`, `founder`, `c_suite`, `partner`, `vp`, `head`, `director`, `manager`
- **Hiring signal roles** (optional) — job titles that indicate buying intent (e.g., "Recruiting Coordinator", "DevOps Engineer")
- **Max results** (default 25)

### 2. Find decision makers

**One call.** Apollo's people search filters by title + seniority + industry-keyword + location + company-size in a single request. Returns up to 100 people with their organization data attached.

```bash
orth run apollo /api/v1/mixed_people/api_search --body '{
  "person_titles": ["{title_1}", "{title_2}", "{title_3}"],
  "person_seniorities": ["{seniority_1}", "{seniority_2}"],
  "organization_locations": ["{location}"],
  "organization_num_employees_ranges": ["{size_range_1}", "{size_range_2}"],
  "q_keywords": "{industry_phrase}",
  "per_page": 100,
  "page": 1
}'
```

**Critical sizing note — over-fetch.** Apollo's `organization_num_employees_ranges` filter is loose; in testing, ~80% of returned companies fell BELOW the requested range. **Always request `per_page: 100` even when the user asked for 25 results** — you'll discard most after the post-hoc filter in Step 3. If the user asks for a strict size threshold and the per-page-100 yield still under-delivers, paginate (`page: 2`).

**Response shape:**
- `people[]` with `id`, `first_name`, `last_name_obfuscated` (real last name masked — only revealed by Step 3), `title`, `has_email`, `has_direct_phone`.
- `organization` in the search response is a **flag dictionary only** (`has_industry`, `has_phone`, `has_employee_count`, etc.) — it does NOT include `id`, `name`, `website_url`, or `estimated_num_employees`. **Org IDs come from Step 3's `/people/match` response, not from this call.**

**Keyword tips:**
- `q_keywords` uses AND-match across whitespace tokens. Multi-word keywords like `"staffing recruiting"` often return 0 results because Apollo requires both terms to match. **Use a single phrase**: `"staffing agency"` or `"fintech"`.
- If `q_keywords` returns 0, drop `person_seniorities` first, then `organization_num_employees_ranges`, then try a broader single keyword.

Take the returned `people[]` and pull each person's `id` for Step 3.

### 3. Reveal contact info (parallel per person)

**Fire all N calls in parallel.** Apollo's `/people/match` reveals full name, work email, LinkedIn URL, and complete company data — including verified employee count.

```bash
# Fire in parallel for every person from Step 2
orth run apollo /api/v1/people/match --body '{
  "id": "{apollo_person_id}",
  "reveal_personal_emails": true
}'
```

**Notes:**
- Do NOT pass `reveal_phone_number: true` — Apollo requires a webhook for that. Phones come from Step 6.
- Each response returns `person.first_name`, `person.last_name`, `person.email`, `person.personal_emails[]`, `person.linkedin_url`, `person.title`, `person.organization.name`, `person.organization.website_url`, `person.organization.estimated_num_employees`, `person.organization.industry`, `person.organization.primary_phone`.
- Apply user's company-size filter post-hoc using `organization.estimated_num_employees` — Apollo's people search filter is best-effort; verify here.

### 4. Verify emails (parallel per email)

**Fire all N calls in parallel.** Hunter's verifier returns deliverable / undeliverable / accept_all / unknown for each email.

```bash
orth run hunter /v2/email-verifier -q email={person_email}
```

**Output mapping for the result table** — read the `status` field (Hunter v2 deprecated `result` in favor of `status`):
- Hunter `status: "valid"` AND `score >= 80` → `Verified ({score})`
- Hunter `status: "valid"` AND `score < 80` → `Verified low ({score})`
- Hunter `status: "accept_all"` → `Accept-all (mailbox not provable)`
- Hunter `status: "invalid"` → drop or label `Unverified`
- Hunter `status: "unknown"` / `disposable` / `webmail` → label `Unverified`

For accept-all responses, note the email but flag it — catch-all domains accept everything, so deliverability ≠ this person actually reads it.

### 5. Hiring signals (parallel per company)

**Fire all N calls in parallel.** Apollo's per-company job-postings endpoint is the cleanest source — no scraping, no Cloudflare blocks, returns titles and locations directly.

```bash
orth run apollo /api/v1/organizations/{organization_id}/job_postings -q organization_id={org_id}
```

**Match logic — be flexible.** Match against the user's signal roles using **any of**: exact substring, common synonyms, or related-role keywords. For example, "Recruiting Coordinator" should match "Recruiting Coordinator", "Recruitment Coordinator", "Talent Acquisition Coordinator", "Talent Coordinator", "TA Coordinator" — and reasonably any title containing both `recruit*` and `coord*`. Strict literal substring match drops too many real signals.

- Companies with ≥1 matching posting → **High Priority**.
- Count matches and surface as a `Quant Signal` column when the user asked for thresholds (e.g., "10+ open postings").
- Apollo's `/job_postings` response can be large (200KB+ for enterprise companies). Don't paste raw responses into the result; just extract titles + locations and discard.

If the user did NOT specify hiring signal roles, skip this step.

### 6. Phone discovery (opt-in, parallel per person)

**This step is optional.** Sixtyfour's find-phone has 100% hit rate but is the wall-clock killer — 25 parallel calls take ~10 minutes due to tail latency. Skip it by default. Run it only when:
- The user explicitly asked for phone numbers, OR
- The user explicitly said "complete" / "include everything" / "don't skip phones"

When you do run it, **fire all N calls in parallel**. Apollo phones require a webhook URL we don't have — Sixtyfour is the only option.

```bash
orth run sixtyfour /find-phone --body '{
  "lead": {
    "first_name": "{first}",
    "last_name": "{last}",
    "company": "{org_name}",
    "linkedin_url": "{linkedin_url}"
  }
}'
```

**Notes:**
- This is the slowest call in the workflow (~10–30s per individual call). Always fire concurrently with Steps 4 and 5 — don't sequence them.
- Sixtyfour returns raw 10-digit phone strings (e.g., `"2077837000"`). Format to `(207) 783-7000` for the output table.
- If the person's `linkedin_url` is missing from Step 3's response, omit it from the request body — Sixtyfour will fall back to name + company matching with lower hit rate.

### 7. Person-level location check

If the user specified a location filter, verify each prospect actually lives/works in that region. Apollo's response includes `person.city`, `person.state`, `person.country` — drop or downgrade prospects whose location doesn't match.

Multinationals (Randstad, Manpower) sometimes surface global execs whose `country` is the user's region but whose actual scope is `EMEA` or `Global` — flag those in Notes rather than silently include them.

### 8. Present results

Output a prioritized table with **full URLs** (not markdown links — users need to copy-paste):

```
## Prospect List: {Title} at {Industry} Companies in {Location}

Found {N} decision makers across {M} companies in ~{T} seconds.

### High Priority — Hiring Signal Detected
| # | Company | Website | Employees | Decision Maker | Title | Email | Email Status | Phone | LinkedIn | Hiring | Quant Signal |
|---|---------|---------|-----------|----------------|-------|-------|-------------|-------|----------|--------|--------------|
| 1 | Acme Staffing | https://acmestaffing.com | 250 | Jane Smith | COO | jane@acme.com | Verified (94) | (555) 123-4567 | https://linkedin.com/in/janesmith | Recruiting Coordinator (×3) | 12 postings |

### Medium Priority — Matches ICP, No Signal Detected
| # | Company | Website | Employees | Decision Maker | Title | Email | Email Status | Phone | LinkedIn |
|---|---------|---------|-----------|----------------|-------|-------|-------------|-------|----------|
| 5 | Beta Corp | https://betacorp.com | 180 | John Doe | VP Ops | john@beta.com | Verified (88) | (555) 987-6543 | https://linkedin.com/in/johndoe |

### Lower Priority — Below Threshold or Limited Data
| # | Company | Decision Maker | Title | Notes |
|---|---------|----------------|-------|-------|
| 12 | Globex | Maria Schmidt | COO, EMEA | LinkedIn location: Germany — likely not the US-specific decision maker |

### Summary
- Decision makers identified: {N}
- Verified emails: {count} (incl. {accept_all_count} accept-all)
- Phones found: {count}
- High priority: {count} | Medium: {count} | Lower: {count}
- Wall clock: ~{T}s
```

## APIs used

| API | Endpoint | Purpose |
|-----|----------|---------|
| **Apollo** | `/api/v1/mixed_people/api_search` | Find decision makers by title + industry + size + location |
| **Apollo** | `/api/v1/people/match` | Reveal full name + email + LinkedIn + company data |
| **Apollo** | `/api/v1/organizations/{id}/job_postings` | Per-company hiring-signal detection |
| **Hunter** | `/v2/email-verifier` | Email deliverability verification |
| **Sixtyfour** | `/find-phone` | Direct phone numbers (proven 100% hit rate) |

Five endpoints across four providers. All run in parallel within each step.

## Examples

**Example 1 — Staffing/recruiting (the canonical use case):**

> "Find COOs at US staffing firms with 100+ employees that are hiring Scheduling Coordinators or Recruiting Coordinators"

Step 2:
```bash
orth run apollo /api/v1/mixed_people/api_search --body '{
  "person_titles": ["Chief Operating Officer", "Head of Operations", "COO"],
  "organization_locations": ["United States"],
  "organization_num_employees_ranges": ["100,500", "500,1000", "1000,5000", "5000,10000"],
  "q_keywords": "staffing",
  "per_page": 100
}'
```

**Note for staffing/recruiting vertical specifically:** Apollo's `/job_postings` for staffing agencies returns the *client requisitions they are filling*, not the agency's own internal hires. So a staffing firm with 990 listed postings might have 0 in-house Recruiting Coordinator openings. For this vertical, expect strict in-house hiring signals to be sparse — most prospects land in Medium Priority.

Step 5 (per company, parallel):
```bash
orth run apollo /api/v1/organizations/{organization_id}/job_postings -q organization_id={id}
```

**Example 2 — SaaS sales (fintech):**

> "Find VP Engineering or CTO at fintech startups with 50–200 employees in the US that are hiring DevOps engineers"

```bash
orth run apollo /api/v1/mixed_people/api_search --body '{
  "person_titles": ["VP Engineering", "Vice President of Engineering", "CTO", "Chief Technology Officer"],
  "organization_locations": ["United States"],
  "organization_num_employees_ranges": ["51,200"],
  "q_keywords": "fintech",
  "per_page": 25
}'
```

**Example 3 — Healthcare HR (Texas):**

> "Find HR Directors at healthcare companies in Texas with 500+ employees"

```bash
orth run apollo /api/v1/mixed_people/api_search --body '{
  "person_titles": ["HR Director", "VP Human Resources", "Head of HR"],
  "organization_locations": ["Texas, US"],
  "organization_num_employees_ranges": ["500,1000", "1000,5000", "5000,10000"],
  "q_keywords": "healthcare",
  "per_page": 25
}'
```

## Error handling

- **Apollo people search returns 0 results.** Most likely the filter combination is too tight. Drop `person_seniorities` first (the title list already encodes seniority), then `organization_num_employees_ranges`, then simplify `q_keywords` to a single word.
- **Apollo `/people/match` doesn't return revenue data.** The `organization` payload has `estimated_num_employees` but no revenue field. Treat user's revenue floors as best-effort using employee count as a proxy (100+ FTE staffing firms typically gross $10M+).
- **Hunter verifier returns null `data`.** Treat as `Unverified` and continue.
- **Apollo `/people/match` requires `webhook_url` for `reveal_phone_number`.** Don't pass that flag — Sixtyfour handles phones.
- **Apollo `/organizations/{id}/job_postings` returns empty `job_postings: []`.** Means the company isn't hiring or Apollo's index is stale. Treat as "no signal detected" — still a valid Medium Priority lead.
- **Hunter verifier returns `accept_all`.** Catch-all domain — flag the email but don't claim verified.
- **Sixtyfour `/find-phone` returns `{}`.** Phone discovery missed this person. Skill should not retry — accept the gap.

## Tips

- **Apollo is the primary unlock.** It collapses what used to be 4 separate steps (find companies, find decision makers, get email, get title) into 2 calls. Don't add other people-search providers unless Apollo misses entirely.
- **Industry keyword > tag IDs.** Apollo exposes industry tag IDs, but in practice `q_keywords` like "staffing agency" or "fintech" works fine and avoids the lookup-table problem.
- **Last names are obfuscated in `/mixed_people/api_search`.** Always call `/people/match` to get the real name. Don't try to deobfuscate.
- **Filter company size post-hoc.** Apollo's `organization_num_employees_ranges` is best-effort; sometimes surfaces below-range orgs. Re-filter using `organization.estimated_num_employees` from `/people/match`.
- **Hunter verifier is fast and cheap.** Run for every email even when Apollo's data is high-quality — adds ~10s, gives the user a confidence signal.
- **Sixtyfour is the slowest call.** Always launch it concurrently with Steps 3 + 4, never after them. The wall clock is determined by Sixtyfour's tail latency.
- **For 50+ results, paginate Step 2.** Apollo caps at 100 per page; for larger lists, page 1 + page 2 in parallel.
- **Skip Step 5 (job postings) when no hiring signal role specified.** It saves N calls and adds nothing — every prospect just becomes Medium Priority.
- **Don't add scraping fallbacks.** ScrapeGraphAI/Olostep/etc. are blocked by Cloudflare on careers pages and produce 0 useful job-posting data. Apollo's structured job_postings endpoint replaces them.
