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
- **Max results** (optional, default 15)
- **Company/product** (optional) — if user mentions what they're selling, triggers competitive intel in Step 7

### 2. Find Target Companies

Run 3 search strategies **in parallel**:

**Strategy A — Fiber NL company search** (primary — best structured data):

```bash
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "{industry} companies in {location} with {employee_min}+ employees",
  "pageSize": 20
}'
```

Returns structured company data with employee counts, domains, LinkedIn URLs, and descriptions. The NL endpoint handles complex queries well — include revenue/size qualifiers directly in the query string.

**Strategy B — Nyne company search** (supplemental — async, deep results):

```bash
# Step 1: POST to start search
orth run nyne /company/search -d '{"query": "{industry} companies {location} {size_qualifier}"}'
# Step 2: Poll with GET using request_id
orth run nyne /company/search -q request_id=REQUEST_ID
```

Nyne is async — POST returns a `request_id`, poll with GET until complete (5-20s). Often returns companies Fiber misses.

**Strategy C — Scrapegraph searchscraper** (supplemental — web directories and rankings):

```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "top {industry} companies in {location} with company name, website, employee count, and headquarters",
  "num_results": 15
}'
```

Good for finding companies from industry directories, Inc 5000 lists, and trade publications.

#### Scaling Up

For 20+ results, run parallel searches by sub-region or sub-vertical:

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
- **Headquarters / location**
- **LinkedIn company URL** (if returned by Fiber/Nyne)
- **Description / industry tags**

Deduplicate by domain first, then by normalized company name. Apply user's size filters — use employee count as revenue proxy when revenue is unavailable (100+ employees ≈ $10M+ revenue as rough heuristic).

Enrich top companies with Brand.dev for industry context:

```bash
orth run brand-dev /v1/brand/retrieve --query 'domain={company_domain}'
```

### 4. Find Decision Makers

For each company, run in parallel:

**Primary — Fiber NL profile search** (best for title-based search):

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{title_1} or {title_2} at {company_name}",
  "pageSize": 5
}'
```

**Supplemental — Nyne person search** (async, finds people Fiber misses):

```bash
orth run nyne /person/search -d '{"query": "{title} at {company_name} {location}"}'
# Poll: orth run nyne /person/search -q request_id=REQUEST_ID
```

**Fallback — Fiber kitchen-sink** (if NL search returns no results for a company):

```bash
orth run fiber /v1/kitchen-sink/person --body '{
  "companyDomain": {"domain": "{company_domain}"},
  "jobTitle": {"title": "{target_title}"},
  "fuzzySearch": true,
  "numProfiles": 3
}'
```

**Last resort — Scrapegraph website scrape** (scrape the company's leadership page):

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{company_domain}/about",
  "user_prompt": "Extract names, titles, and any contact info for the leadership team. Identify anyone with these titles: {target_titles}"
}'
```

If `/about` returns 422, fall back to the homepage URL.

### 5. Enrich Contacts

For each decision maker found, run **all** of these in parallel:

**Email discovery** (run all sources simultaneously):

```bash
# Hunter email-finder (name + domain)
orth run hunter /v2/email-finder --query 'domain={company_domain}&first_name={first}&last_name={last}'

# Tomba email-finder (name + domain)
orth run tomba /v1/email-finder --query 'domain={company_domain}&company={company_name}&first_name={first}&last_name={last}'

# Sixtyfour AI email finder
orth run sixtyfour /find-email --body '{
  "lead": {"first_name": "{first}", "last_name": "{last}", "domain": "{company_domain}"}
}'

# Tomba LinkedIn-to-email (if LinkedIn URL found in Step 4)
orth run tomba /v1/linkedin --query 'url={linkedin_url}'
```

**Phone discovery:**

```bash
orth run sixtyfour /find-phone --body '{
  "lead": {"first_name": "{first}", "last_name": "{last}", "company": "{company_name}"}
}'
```

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

**Fiber kitchen-sink enrichment** (if LinkedIn URL available):

```bash
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "{linkedin_url}"
}'
```

**Triple email verification** — verify ALL found emails with 3 services:

```bash
orth run hunter /v2/email-verifier --query 'email={email}'
orth run tomba /v1/email-verifier --query 'email={email}'
orth run fiber /v1/validate-email/single --body '{"email": "{email}"}'
```

Take the consensus. Label each email as verified/unverified. Collect both work and personal emails.

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
| # | Company | Website | Employees | Decision Maker | Title | Email | Email Status | Phone | Signal |
|---|---------|---------|-----------|---------------|-------|-------|-------------|-------|--------|
| 1 | Acme Staffing | https://acmestaffing.com | 250 | Jane Smith | COO | jane@acme.com | Verified | (555) 123-4567 | Hiring Scheduling Coordinator |

### Medium Priority — Matches ICP, No Signal Detected
| # | Company | Website | Employees | Decision Maker | Title | Email | Email Status | Phone | Notes |
|---|---------|---------|-----------|---------------|-------|-------|-------------|-------|-------|
| 5 | Beta Corp | https://betacorp.com | 180 | John Doe | VP Ops | john@beta.com | Verified | — | Growing 25% YoY |

### Lower Priority — Limited Data or Below Target Size
| # | Company | Website | Employees | Decision Maker | Title | Email | Phone | Notes |
|---|---------|---------|-----------|---------------|-------|-------|-------|-------|
| 10 | Small Co | https://smallco.com | 85 | — | — | — | — | Below 100 employee threshold |

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
| **Brand.dev** | `/v1/brand/retrieve` | Company overview/context |

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

- **Fiber NL search returns few results** — Broaden the query (remove size qualifiers) or try Scrapegraph searchscraper as primary instead. Industry terms vary — try synonyms (e.g., "staffing" vs "recruiting" vs "temp agency")
- **Nyne still pending after 30s** — Continue with Fiber/Scrapegraph results. Merge Nyne data when it arrives
- **Fiber kitchen-sink returns 400** — Usually a parameter format issue. Ensure `companyDomain` uses `{"domain": "x.com"}` format, not a bare string
- **Fiber job-search returns 400** — Known issue with searchParams filters. Use Scrapegraph searchscraper for hiring signals instead
- **Smartscraper 422 on /about path** — Fall back to scraping the homepage URL (no path appended)
- **Hunter/Tomba return null for email** — Expected for smaller companies. Sixtyfour AI finder catches some that pattern-based tools miss. Use all sources in parallel
- **No hiring signal found** — Not every industry/location has active job postings for specific roles. Mark as "No signal detected" — these are still valid medium-priority prospects

## Tips

- **Fiber NL search is the workhorse** — Use it as primary for both companies and profiles. The natural language interface handles complex queries ("fintech companies in Texas with 200+ employees") better than structured filters
- **Run all email sources in parallel** — Hunter, Tomba, Sixtyfour, and Tomba-LinkedIn each find emails the others miss. Coverage improves from ~40% (single source) to ~70%+ (all sources)
- **Employee count is the best size proxy** — Revenue data is rarely available from APIs. Use employee count: 50+ ≈ established, 100+ ≈ mid-market, 500+ ≈ enterprise
- **Hiring signals are the #1 prioritization tool** — A company actively hiring for a role your product replaces/supports is 3-5x more likely to buy. Always cross-reference hiring data with your company list
- **Nyne is slow but thorough** — Fire Nyne searches early (they're async), process Fiber/Scrapegraph results first, merge Nyne data when it arrives
- **Sixtyfour enrich-lead is slow but rich** — Takes 30-60s (AI web research). Fire it early for each person, don't block on it
- **LinkedIn URLs dramatically improve enrichment** — When Fiber NL profile search returns LinkedIn URLs, feed them into kitchen-sink and Tomba-LinkedIn for best email/phone hit rates
- **Deduplicate aggressively** — Multiple search strategies will return overlapping results. Dedup by domain first (most reliable), then by normalized company name
- **Triple-verify emails** — Run all three verifiers (Hunter, Tomba, Fiber) on every email found. Mark as "Verified" only on 2/3+ consensus
- **Include title variations** — Search for "COO OR Chief Operating Officer OR Head of Operations" to catch different title formats at the same level
