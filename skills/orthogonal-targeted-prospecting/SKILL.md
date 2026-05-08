---
name: targeted-prospecting
description: Build a prospect list of companies with decision makers, verified contact info, and hiring/intent signals. Use when asked to find leads by industry, build an account list with specific titles, prospect companies that are actively hiring, or create a targeted outreach list filtered by company size, location, and hiring activity.
---

# Targeted Prospecting — Industry + Decision Makers + Hiring Signals

Build a prioritized prospect list for any industry. Finds companies matching your ICP, identifies decision makers by title, enriches with verified contact info, and layers on hiring/intent signals to prioritize who's ready to buy now.

## Workflow

### 1. Parse the Request

Extract from the user's query:
- **Industry/vertical** (required) — e.g., staffing, fintech, healthcare IT, construction
- **Decision maker titles** (required) — e.g., COO, VP Engineering, Head of Marketing
- **Location** (optional, default: US) — country, state, city, or region
- **Company size** (optional) — employee count min/max, revenue floor
- **Hiring signal roles** (optional) — job postings that indicate buying intent (e.g., "Scheduling Coordinator" = ops pain, "DevOps Engineer" = infra investment)
- **Quantitative thresholds** (optional) — counts the user wants to filter on. Triggers Step 6b. Examples:
  - "≥10 job postings" / "10+ openings" / "actively hiring at scale"
  - "fewer than 10 recruiters" / "<5 engineers" / "small TA team"
- **Max results** (optional, default 25 — bump higher when the user asks for "as many as possible" or specifies a count)
- **Company/product** (optional) — if user mentions what they're selling, triggers competitive intel in Step 7

### 2. Find Target Companies

Run 2-3 search strategies **in parallel**:

**Strategy A — Scrapegraph searchscraper** (primary — most targeted results):

```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "top {industry} companies in {location} with company name, website, employee count, and headquarters",
  "num_results": 15
}'
```

Best source for industry-specific company lists. Returns targeted results from industry directories, Inc 5000 lists, and trade publications. In testing, returned 28 staffing companies in a single call vs Fiber's noisy mix of tech giants and staffing firms.

**Strategy B — Fiber NL company search** (co-primary — best structured data):

```bash
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "{industry} companies in {location} with {employee_min}+ employees",
  "pageSize": 20
}'
```

Returns structured company data with employee counts, domains, LinkedIn URLs, and descriptions. **Caveat:** For niche industries (staffing, construction, etc.), Fiber NL search often returns broad/noisy results mixed with unrelated companies. Filter results by industry keywords from the description, `li_industries`, and `crunchbase_categories` fields. Use company `names` field (not `name_consensus`) for the company name.

**Strategy C — Nyne company search** (supplemental — attempt, may return errors):

```bash
# Step 1: POST to start search
orth run nyne /company/search -d '{"query": "{industry} companies {location} {size_qualifier}"}'
# Step 2: Poll with GET using request_id
orth run nyne /company/search -q request_id=REQUEST_ID
```

Nyne is async — POST returns a `request_id`, poll with GET until complete (5-20s). **Note:** Nyne company search can return 400 errors depending on query format. If it fails, proceed with Scrapegraph + Fiber results — don't block on Nyne.

#### Scaling Up

**Default behavior at higher counts.** When `Max results ≥ 20` (the new default of 25 lands here), run parallel searches by sub-region or sub-vertical *automatically* rather than treating it as opt-in. A single Fiber/Scrapegraph call caps at ~15–20 high-quality results before noise increases; splitting the query roughly doubles yield without a runtime penalty since the calls run in parallel.

Example:

```bash
# Parallel searches for different sub-regions
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "{industry} companies in New York with {size}+ employees",
  "pageSize": 15
}'

orth run fiber /v1/natural-language-search/companies --body '{
  "query": "{industry} companies in California with {size}+ employees",
  "pageSize": 15
}'
```

### 3. Extract & Deduplicate

Merge results from all strategies. For each company, extract:
- **Company name**
- **Domain / website URL**
- **Employee count** (primary size proxy — revenue data is often unavailable)
- **Headcount source** — track which API the count came from. One of:
  - `Fiber` — from `/v1/natural-language-search/companies` structured `employee_count`
  - `Context.dev` — from `/v1/brand/retrieve`
  - `Scrapegraph (web estimate)` — from `searchscraper` prose; least authoritative
  - `LinkedIn (kitchen-sink)` — from Fiber `/v1/kitchen-sink/company` if available
  - `Multiple` — when ≥2 sources agree within 20%
- **Headquarters / location**
- **LinkedIn company URL** (if returned by Fiber/Nyne)
- **Description / industry tags**

Deduplicate by domain first, then by normalized company name. Apply user's size filters — use employee count as revenue proxy when revenue is unavailable (100+ employees ≈ $10M+ revenue as rough heuristic). When two sources disagree on headcount, prefer Fiber > LinkedIn > Context.dev > Scrapegraph and label `headcount_source` accordingly. Surface the source in the final output (Step 8) so the user can judge confidence.

Enrich top companies with Context.dev for industry context:

```bash
orth run context-dev /v1/brand/retrieve --query 'domain={company_domain}'
```

### 4. Find Decision Makers

**Best approach: one broad industry-wide search, then per-company fallbacks.**

In testing, a single broad query like "COO at staffing companies in the US" returned 15 relevant profiles, while per-company queries (e.g., "COO at Robert Half") often returned 0 results. Start broad, then fill gaps.

**Primary — Fiber NL profile search (broad industry query):**

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{title_1} or {title_2} at a {industry} company in {location}",
  "pageSize": 15
}'
```

This is the highest-yield approach. Returns decision makers across the industry with LinkedIn URLs, current titles, and company names.

**Per-company fallback — Fiber NL profile search** (for companies not covered by the broad search):

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{title_1} or {title_2} at {company_name}",
  "pageSize": 5
}'
```

Per-company queries often return empty results, especially for large enterprises where C-suite profiles may not be indexed. Use this only for high-priority companies missing from the broad search.

**Supplemental — Nyne person search** (async, may return errors):

```bash
orth run nyne /person/search -d '{"query": "{title} at {company_name} {location}"}'
# Poll: orth run nyne /person/search -q request_id=REQUEST_ID
```

**Fallback — Scrapegraph website scrape** (scrape the company's leadership page):

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{company_domain}/about",
  "user_prompt": "Extract names, titles, and any contact info for the leadership team. Identify anyone with these titles: {target_titles}"
}'
```

If `/about` returns 422, fall back to the homepage URL.

**Enterprise fallback** — only when the per-company Fiber profile search AND the `/about` + homepage scrapes all return empty. Common at large public companies (ManpowerGroup, ASGN, etc.) where C-suite info lives in press releases, annual reports, and proxy filings rather than indexable LinkedIn profiles or `/about` pages.

Run both in parallel:

```bash
# 1. Web search for the named exec (pulls from press releases, 10-Ks, news)
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Who is the {title} at {company_name}? Return name, title, and LinkedIn URL.",
  "num_results": 5
}'

# 2. Fiber NL profile search resolved by domain instead of name
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{title} at the company with website {company_domain}",
  "pageSize": 5
}'
```

If both still return empty, the company belongs in **Lower Priority** with `Decision Maker: — (enterprise — research manually via investor-relations page)`. Don't fabricate a decision maker.

### 5. Enrich Contacts

For each decision maker found, run **all** of these in parallel:

**Email discovery — Sixtyfour first** (highest hit rate for small/mid-market domains):

```bash
# Sixtyfour AI email finder (PRIMARY — found 9/12 emails in testing)
orth run sixtyfour /find-email --body '{
  "lead": {"first_name": "{first}", "last_name": "{last}", "domain": "{company_domain}"}
}'

# Hunter email-finder (supplemental — often returns null for small company domains)
orth run hunter /v2/email-finder --query 'domain={company_domain}&first_name={first}&last_name={last}'

# Tomba email-finder (supplemental — similar limitations to Hunter on small domains)
orth run tomba /v1/email-finder --query 'domain={company_domain}&company={company_name}&first_name={first}&last_name={last}'

# Tomba LinkedIn-to-email (if LinkedIn URL found in Step 4)
orth run tomba /v1/linkedin --query 'url={linkedin_url}'
```

In testing, Sixtyfour found emails for 9 out of 12 prospects where Hunter and Tomba returned null. Sixtyfour is the most reliable source for small/mid-market company domains. Still run all sources in parallel — each occasionally finds emails the others miss.

**Phone discovery:**

```bash
orth run sixtyfour /find-phone --body '{
  "lead": {"first_name": "{first}", "last_name": "{last}", "company": "{company_name}"}
}'
```

Sixtyfour find-phone had a 100% hit rate in testing (10/10 prospects).

**Deep enrichment** (fire early, don't block — takes 30-60s):

```bash
orth run sixtyfour /enrich-lead --body '{
  "lead_info": {
    "first_name": "{first}", "last_name": "{last}",
    "company": "{company_name}", "linkedin_url": "{linkedin_url}"
  },
  "struct": {
    "work_email": "Work email",
    "personal_email": "Personal email",
    "phone": "Phone number",
    "title": "Current job title",
    "bio": "Short professional bio"
  }
}'
```

**Fiber kitchen-sink enrichment** (if LinkedIn URL available — may return 400):

```bash
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "{linkedin_url}"
}'
```

Kitchen-sink can intermittently return 400 errors regardless of parameter format. If it fails, proceed with Sixtyfour + Hunter + Tomba results — don't block on kitchen-sink.

**Triple email verification** — verify ALL found emails with 3 services:

```bash
orth run hunter /v2/email-verifier --query 'email={email}'
orth run tomba /v1/email-verifier --query 'email={email}'
orth run fiber /v1/validate-email/single --body '{"email": "{email}"}'
```

**Consensus rules** — count each service's positive/negative vote, then label:

- `Verified (3/3)` — all three return positive (deliverable / valid).
- `Verified (2/3)` — two of three positive. Safe to use; the third often disagrees on catch-all domains.
- `Risky (1/3)` — only one positive. Show the email but flag it; do not call it verified.
- `Unverified` — zero positive. Drop the email or label clearly.
- `Accept-all` — when any service returns "accept_all" / "catch_all", record it as a separate flag rather than a positive vote (catch-all domains accept anything, so the result tells you nothing about the specific mailbox). A row with 1 positive + 1 accept-all + 1 negative is `Risky (1/3)`, not `Verified (2/3)`.

Collect both work and personal emails. When both exist, prefer the work email for the primary contact field and surface the personal one in `Notes:`.

**Person-level location check** — only when the user specified a location filter. Without this step, global execs at multinationals (e.g. a "COO, Randstad Enterprise" with a `@randstad.de` mailbox) slip into US-only lists.

For each decision maker, downgrade to **Lower Priority** with an explanatory note when **any** of these are true:

- LinkedIn `location` (returned by Fiber profile search) is outside the user's region.
- Verified email's domain ccTLD doesn't match the user's region (`.de`, `.uk`, `.in`, `.com.au`, etc. for a US-only query) **AND** the person's title contains a global/regional scope keyword (`Global`, `International`, `EMEA`, `APAC`, `LATAM`, `EU`, `UK`, `Worldwide`).
- Sixtyfour `enrich-lead` returns a `location` field outside the region.

Don't silently drop them — surface in Lower Priority with `Notes: LinkedIn location: {country}; verified email is {.cctld} domain — may not be the {region}-specific decision maker.` The user may still want global execs at multinationals; let them decide.

When the email ccTLD is foreign but the title shows no global scope (e.g. "COO" not "Global COO"), it's almost certainly the wrong entity at a smaller firm — drop the email but keep the LinkedIn URL with a flag.

### 6. Hiring / Intent Signals

**Only run this step if the user specified hiring signal roles.** This is the key differentiator for prioritization.

**Primary — Scrapegraph searchscraper for hiring signals:**

```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "{industry} companies hiring {signal_role} in {location}, list company name, job title, and location",
  "num_results": 15
}'
```

**Supplemental — Tavily for job board coverage:**

```bash
orth run tavily /search --body '{
  "query": "{industry} {signal_role} job opening {location}",
  "max_results": 10,
  "include_answer": false
}'
```

Then scrape top job board results for company names:

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "{job_board_url}",
  "user_prompt": "Extract all company names hiring for {signal_role}, with job title and location"
}'
```

**Optional — Fiber job search** (attempt, may be unreliable):

```bash
orth run fiber /v1/job-search --body '{
  "searchParams": {
    "job_titles": ["{signal_role}"],
    "industries": ["{industry}"]
  },
  "pageSize": 20
}'
```

Note: Fiber job-search with searchParams filters can return 400 errors. Attempt it but don't rely on it — Scrapegraph is the primary method for hiring signals.

**Cross-reference:** Match companies found hiring signal roles against the company list from Step 2. Matches become **High Priority** prospects. Companies hiring for signal roles that weren't in your original list are bonus leads — add them.

**Growth signals:** Check Fiber company data (from Step 4 kitchen-sink results) for headcount growth percentage. Companies growing >20% YoY are additional high-priority signals.

### 6b. Quantitative Signals (when user asks for counts)

**Trigger this mode** when the request includes thresholds on counts: `≥N job postings`, `more than N {role}`, `fewer than N {role}`, `at least N openings`, `<10 recruiters`, `10+ openings`, etc. Step 6's boolean "is this company hiring?" check isn't enough — the user wants the actual count to filter on.

Two primitives, run per company in parallel:

**(a) Job-posting count per company:**

```bash
# Scrapegraph searchscraper to enumerate open postings
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "List every open job posting at {company_name} with title and location. Include all roles.",
  "num_results": 25
}'

# Tavily to find the careers page, then smartscraper to count listings
orth run tavily /search --body '{
  "query": "{company_name} careers open positions",
  "max_results": 5
}'

orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "{careers_page_url}",
  "user_prompt": "List every open job posting on this page with title and location. Return as a JSON array."
}'

# Optional supplemental — Fiber job-search filtered by company
orth run fiber /v1/job-search --body '{
  "searchParams": {"company_id": "{fiber_company_id}"},
  "pageSize": 50
}'
```

Take `count(distinct postings)` from the union (dedup by title + location). Apply the user's threshold (e.g. `≥10`).

**(b) Employees-by-title count per company:**

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{title_keyword_1} or {title_keyword_2} at {company_name}",
  "pageSize": 30
}'
```

For the perfectly.so case, `title_keyword_1` = "Recruiter", `title_keyword_2` = "Talent Acquisition". Count returned profiles. Apply the user's threshold (e.g. `<10`).

**Critical caveat:** Fiber profile counts are a *floor*, not exact — only public LinkedIn profiles are indexed. A company showing "4 recruiters" via Fiber may have 7 in reality (some with private profiles, some not on LinkedIn). Always describe results as "≥4 recruiters found on LinkedIn" rather than "exactly 4." For thresholds like `<10`, this is usually fine; for tight thresholds (`<3`), warn the user that floor counts are unreliable.

**Output:** add a "Quant Signal" column in the High Priority table populated with `{posting_count} postings, ≥{recruiter_count} recruiters` so the threshold logic is auditable on the result.

### 7. Competitive Intel (Optional)

**Only run if the user mentioned their product/company.** Research what the user sells and check prospects for competing solutions.

```bash
# Research user's product
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{user_company_domain}",
  "user_prompt": "What does this company sell? Describe the product in one sentence."
}'

# Find competitors
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "competitors and alternatives to {user_product} for {industry}",
  "num_results": 5
}'

# Check each prospect's website for competing products (parallel)
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{prospect_domain}",
  "user_prompt": "Does this company use or mention: {competitor_1}, {competitor_2}, {competitor_3}? Check page content, footer, and embedded widgets."
}'
```

Flag prospects: **Greenfield** (no competitor detected) > **Competitive displacement** (uses a competitor — note which one) > **Unknown**.

### 8. Present Results

Output a prioritized table with **full URLs** (not markdown links — users need to copy-paste):

```
## Prospect List: {Title} at {Industry} Companies in {Location}

Found {N} companies with {M} decision makers identified.

### High Priority — Hiring Signal Detected
| # | Company | Website | Employees (source) | Decision Maker | Title | Email | Email Status | Phone | Signal | Quant Signal |
|---|---------|---------|--------------------|---------------|-------|-------|-------------|-------|--------|--------------|
| 1 | Acme Staffing | https://acmestaffing.com | 250 (Fiber) | Jane Smith | COO | jane@acme.com | Verified (3/3) | (555) 123-4567 | Hiring Scheduling Coordinator | 12 postings, ≥4 recruiters |

### Medium Priority — Matches ICP, No Signal Detected
| # | Company | Website | Employees (source) | Decision Maker | Title | Email | Email Status | Phone | Notes |
|---|---------|---------|--------------------|---------------|-------|-------|-------------|-------|-------|
| 5 | Beta Corp | https://betacorp.com | 180 (Multiple) | John Doe | VP Ops | john@beta.com | Verified (2/3) | — | Growing 25% YoY |

### Lower Priority — Limited Data or Below Target Size
| # | Company | Website | Employees (source) | Decision Maker | Title | Email | Phone | Notes |
|---|---------|---------|--------------------|---------------|-------|-------|-------|-------|
| 10 | Small Co | https://smallco.com | 85 (Scrapegraph) | — | — | — | — | Below 100 employee threshold |
| 11 | Globex | https://globex.com | 5,000 (Fiber) | Maria Schmidt | COO, EMEA | maria.schmidt@globex.de | Risky (1/3) | — | LinkedIn location: Germany; .de domain — may not be the US decision maker |
| 12 | MegaCorp | https://megacorp.com | 28,000 (Fiber) | — | — | — | — | Enterprise — research manually via investor-relations page |

### Summary
- **Companies found**: {N}
- **Decision makers identified**: {count}/{N}
- **With verified email**: {count}
- **With phone**: {count}
- **High priority (hiring signal)**: {count}
- **Medium priority (right profile)**: {count}
- **Lower priority (limited data)**: {count}
```

## APIs Used

| API | Endpoint | Purpose |
|-----|----------|---------|
| **Fiber** | `/v1/natural-language-search/companies` | Find companies by industry + size |
| **Fiber** | `/v1/natural-language-search/profiles` | Find decision makers by title + company |
| **Fiber** | `/v1/kitchen-sink/person` | Enrich person by LinkedIn URL or name+company |
| **Fiber** | `/v1/kitchen-sink/company` | Enrich company data |
| **Fiber** | `/v1/job-search` | Job postings (unreliable, attempt only) |
| **Fiber** | `/v1/validate-email/single` | Email verification |
| **Nyne** | `/company/search` | Async company search by industry |
| **Nyne** | `/person/search` | Async person search by company + role |
| **Scrapegraph** | `/v1/searchscraper` | Web search for companies + hiring signals |
| **Scrapegraph** | `/v1/smartscraper` | Scrape websites for leadership/competitive intel |
| **Tavily** | `/search` | Supplemental web search for job boards |
| **Hunter** | `/v2/email-finder` | Find email by name + domain |
| **Hunter** | `/v2/email-verifier` | Email verification |
| **Tomba** | `/v1/email-finder` | Find email by name + domain |
| **Tomba** | `/v1/linkedin` | Email from LinkedIn URL |
| **Tomba** | `/v1/email-verifier` | Email verification |
| **Sixtyfour** | `/find-email` | AI email finder |
| **Sixtyfour** | `/find-phone` | AI phone finder |
| **Sixtyfour** | `/enrich-lead` | AI deep enrichment |
| **Context.dev** | `/v1/brand/retrieve` | Company overview/context |

## Examples

**Example 1 — Staffing/recruiting (the Clay use case):**

"Find COOs at US staffing firms with 100+ employees that are hiring Scheduling Coordinators"

```bash
# Step 2: Find staffing companies (parallel)
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "staffing and recruiting companies in the United States with 100 or more employees",
  "pageSize": 20
}'

orth run nyne /company/search -d '{"query": "staffing recruiting firms US 100+ employees"}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "top staffing and recruiting companies in the US with company name, website, employee count, and headquarters",
  "num_results": 15
}'

# Step 4: Find COOs (parallel, per company)
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "COO or Chief Operating Officer or Head of Operations at {company_name}",
  "pageSize": 3
}'

# Step 5: Enrich (parallel, per person)
orth run hunter /v2/email-finder --query 'domain={domain}&first_name={first}&last_name={last}'
orth run sixtyfour /find-email --body '{"lead": {"first_name": "{first}", "last_name": "{last}", "domain": "{domain}"}}'
orth run sixtyfour /find-phone --body '{"lead": {"first_name": "{first}", "last_name": "{last}", "company": "{company}"}}'

# Step 6: Hiring signals
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "staffing companies hiring Scheduling Coordinator or Recruiting Coordinator in the US, list company name, job title, and location",
  "num_results": 15
}'
```

**Example 2 — SaaS sales (fintech):**

"Find VP Engineering or CTO at fintech startups with 50-200 employees in the US that are hiring DevOps engineers"

```bash
# Companies
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "fintech startups in the United States with 50 to 200 employees",
  "pageSize": 20
}'

# Decision makers (per company)
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "VP Engineering or CTO at {company_name}",
  "pageSize": 3
}'

# Hiring signal
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "fintech companies hiring DevOps Engineer or Site Reliability Engineer in the US, list company name and job title",
  "num_results": 15
}'
```

**Example 3 — Recruiting (healthcare in Texas):**

"Find HR Directors at healthcare companies in Texas with 500+ employees"

```bash
# Companies
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "healthcare companies in Texas with 500 or more employees",
  "pageSize": 20
}'

# Decision makers
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "HR Director or VP Human Resources at {company_name}",
  "pageSize": 3
}'
```

**Example 4 — Simple, no hiring signals (construction):**

"Build a prospect list of construction companies in California with Head of Safety as decision maker"

```bash
# Companies
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "construction companies in California",
  "pageSize": 15
}'

# Decision makers
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "Head of Safety or Safety Director or VP Safety at {company_name}",
  "pageSize": 3
}'
```

## Error Handling

- **Fiber NL company search returns noisy results** — For niche industries, Fiber often returns unrelated companies mixed in (e.g., tech giants alongside staffing firms). Filter results by `li_industries`, `crunchbase_categories`, or keywords in `short_description`. If too noisy, use Scrapegraph searchscraper as primary source instead
- **Fiber NL profile search returns empty per-company** — Per-company queries often return 0 results, especially for large enterprises. Use a broad industry-wide query instead (e.g., "COO at a staffing company in the US") which yields 10-15x more results
- **Fiber kitchen-sink returns 400** — Can fail intermittently regardless of parameter format (`profileIdentifier`, slug, or full URL all tested). This appears to be an API reliability issue, not a format issue. Proceed with Sixtyfour + Hunter + Tomba for enrichment
- **Nyne returns 400** — Nyne company and person search can return 400 errors. Query format sensitivity is unclear. Don't block on Nyne — proceed with Scrapegraph + Fiber results
- **Fiber job-search returns 400** — Known issue with searchParams filters. Use Scrapegraph searchscraper for hiring signals instead
- **Smartscraper 422 on /about path** — Fall back to scraping the homepage URL (no path appended)
- **Hunter/Tomba return null for email** — Expected for small/mid-market company domains. In testing, Hunter and Tomba returned null for most staffing firms while Sixtyfour found 9/12. Always run Sixtyfour as primary email source
- **No hiring signal found** — Not every industry/location has active job postings for specific roles. Mark as "No signal detected" — these are still valid medium-priority prospects

## Tips

- **Scrapegraph is the best company finder for niche industries** — In testing, Scrapegraph returned 28 targeted staffing companies vs Fiber's noisy mix. Use Scrapegraph as primary for industry-specific lists, Fiber as co-primary for structured data (employee counts, domains)
- **Broad profile search beats per-company search** — One query for "COO at staffing companies in the US" returned 15 profiles. The same search run per-company (8 companies) returned only 2 profiles total. Always start with a broad industry-wide NL profile search
- **Sixtyfour is the #1 email finder** — Found 9/12 emails in testing where Hunter and Tomba returned null. For small/mid-market company domains, Sixtyfour's AI approach dramatically outperforms pattern-based tools. Still run all sources in parallel for maximum coverage
- **Sixtyfour find-phone is highly reliable** — 100% hit rate in testing (10/10 prospects). Always include phone discovery
- **Hiring signals are the #1 prioritization tool** — A company actively hiring for a role your product replaces/supports is 3-5x more likely to buy. Scrapegraph searchscraper is the best source — found Randstad and Robert Half hiring for Scheduling Coordinators in a single call
- **Employee count is the best size proxy** — Revenue data is rarely available from APIs. Use employee count: 50+ ≈ established, 100+ ≈ mid-market, 500+ ≈ enterprise
- **Fiber kitchen-sink may be unreliable** — Can return 400 errors intermittently. Don't depend on it as the sole enrichment source — always have Sixtyfour running in parallel as fallback
- **LinkedIn URLs dramatically improve enrichment** — When Fiber NL profile search returns LinkedIn URLs, feed them into Tomba-LinkedIn for email and Sixtyfour enrich-lead for deep context
- **Deduplicate aggressively** — Multiple search strategies will return overlapping results. Dedup by domain first (most reliable), then by normalized company name
- **Hunter email-verifier is fast and reliable** — Even when Hunter email-finder returns null, Hunter email-verifier is excellent for verifying emails found by Sixtyfour. Every email verified came back with score 89-100
- **Include title variations** — Search for "COO OR Chief Operating Officer OR Head of Operations" to catch different title formats at the same level
- **Filter Fiber company results by industry** — Use `li_industries`, `crunchbase_categories`, or keywords in `short_description` to filter out irrelevant companies from Fiber NL results
- **Quantitative profile counts are a floor, not exact** — When using Step 6b to count employees by title (e.g. "fewer than 10 recruiters"), Fiber only sees public LinkedIn profiles. Real headcount is usually higher. Describe results as "≥N found on LinkedIn" and warn the user when their threshold is tight (`<3`)
- **Surface headcount source on every row** — Show employee count alongside its source: `8,000+ (Fiber)`, `Est. 100+ (Scrapegraph)`. Without source attribution, "Est. 100+" looks like a guess and undermines the whole result
- **Verify person-level location, not just company location** — A multinational like Randstad has US presence but a global exec may have a `.de` mailbox. Always check LinkedIn location, email ccTLD, and Sixtyfour location against the user's region filter — surface mismatches in Lower Priority with a note rather than silently including or dropping them
