---
name: enrich
description: Enrich any person or company from any identifier — email, name, LinkedIn URL, domain, company name, Twitter/X handle. Use when asked to enrich, look up, or research a lead, contact, person, or company.
---

# Enrich — Comprehensive Person & Company Enrichment

Maximum data + correctness. Use ALL relevant APIs, cross-reference results, flag conflicts.

## 1. Identifier Detection

Detect input type, then route:

| Input | Contains | Route |
|-------|----------|-------|
| Email | `@` | Person + Company (extract domain) |
| LinkedIn person URL | `linkedin.com/in/` | Person + Company (from results) |
| LinkedIn company URL | `linkedin.com/company/` | Company only |
| Domain | `*.com`, `*.io`, etc. | Company only |
| Company name | No special pattern | Company only |
| Name + company | "John Doe at Stripe" | Person + Company |
| Twitter/X handle | `@handle` or `x.com/` | Person + Company (from results) |

**Person always cascades to company.** Once person enrichment reveals their employer (company name, domain, or LinkedIn company URL), automatically run full company enrichment too. The only time you skip company is if you truly can't identify one.
**If LinkedIn person URL provided:** extract username for Shofo calls, full URL for Fiber calls.

## 2. Person Enrichment

Run ALL of these in parallel where possible. Collect everything, then compile.

### 2a. Full Profile & Contact Info

**Fiber kitchen-sink** (accepts LinkedIn URL, email, or name+company):
```bash
# By LinkedIn URL:
orth run fiber /v1/kitchen-sink/person --body '{"profileIdentifier": "https://linkedin.com/in/johndoe"}'

# By email:
orth run fiber /v1/kitchen-sink/person --body '{"emailAddress": "john@stripe.com"}'

# By name + company:
orth run fiber /v1/kitchen-sink/person --body '{
  "personName": {"fullName": "John Doe"},
  "companyName": {"name": "Stripe"},
  "companyDomain": {"domain": "stripe.com"}
}'
```

**Nyne person search** (async — deep work history, education, social):
```bash
# Step 1: POST to start search
orth run nyne /person/search -d '{"query": "John Doe Stripe"}'
# Step 2: Poll with GET using request_id
orth run nyne /person/search -q request_id=REQUEST_ID
```

**Sixtyfour enrich-lead** (AI-powered — slow, ~30-60s, but finds rich context):
```bash
orth run sixtyfour /enrich-lead --body '{
  "lead_info": {"first_name": "John", "last_name": "Doe", "company": "Stripe", "linkedin_url": "https://linkedin.com/in/johndoe"},
  "struct": {"work_email": "Work email", "personal_email": "Personal email (Gmail, etc.)", "phone": "Phone number", "title": "Job title", "bio": "Short bio"}
}'
```

### 2b. Email — Find & Verify

Collect ALL emails — work AND personal. Many use cases (recruiting, etc.) need personal emails. Present each email with its type (work/personal) and verification status.

**Find work email** (cross-reference Hunter + Tomba):
```bash
# Hunter (returns work email)
orth run hunter /v2/email-finder --query domain=stripe.com first_name=John last_name=Doe

# Tomba (returns work email + sometimes personal)
orth run tomba /v1/email-finder --query domain=stripe.com company=Stripe first_name=John last_name=Doe
```

**Find personal email** — these sources often return personal (Gmail, etc.):
```bash
# Tomba from LinkedIn (often returns personal email)
orth run tomba /v1/linkedin --query url=https://linkedin.com/in/johndoe

# Tomba enrich (returns all known emails for a person)
orth run tomba /v1/enrich --query email=john@stripe.com
```
Nyne person/search and Sixtyfour enrich-lead (Section 2a) also return personal emails — check their results.

**Verify ALL found emails** (run all three verifiers per email):
```bash
orth run hunter /v2/email-verifier --query email=john@stripe.com
orth run tomba /v1/email-verifier --query email=john@stripe.com
orth run fiber /v1/validate-email/single --body '{"email": "john@stripe.com"}'
```
Verify every email found — work and personal. Run verifiers in parallel across all emails.

### 2c. Phone
```bash
orth run sixtyfour /find-phone --body '{
  "lead": {"first_name": "John", "last_name": "Doe", "company": "Stripe"}
}'
```

### 2d. Social Profiles

**LinkedIn** (cross-reference Shofo + Fiber):
```bash
orth run shofo /linkedin/user-profile -q username=johndoe
orth run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/johndoe"}'
```

**Twitter/X** (if handle known or discovered):
```bash
orth run shofo /x/user-profile -q username=johndoe
```

**Recent LinkedIn activity:**
```bash
orth run shofo /linkedin/user-posts -q username=johndoe count=5
```

### 2e. Open-Ended Research
```bash
orth run linkup /search --body '{
  "q": "John Doe Stripe VP Engineering recent news interviews talks",
  "depth": "deep",
  "outputType": "sourcedAnswer"
}'
```

### 2f. Compile Person Profile

Cross-reference all results into a single profile:
- **Name & title**: Compare across Fiber, Nyne, Sixtyfour, LinkedIn
- **Emails**: List ALL found emails, labeled by type:
  - **Work**: john@stripe.com (Hunter: score 95, verified ✓ | Tomba: verified ✓ | Fiber: valid ✓)
  - **Personal**: johndoe@gmail.com (Tomba LinkedIn: found | Nyne: confirmed | Hunter: verified ✓)
- **Phone**: From Sixtyfour find-phone
- **LinkedIn**: URL + headline + summary from both Shofo and Fiber (flag differences)
- **Twitter/X**: Profile + recent activity
- **Work history**: Merge Nyne (deep) + Fiber (current) + LinkedIn
- **Education**: From Nyne + LinkedIn
- **Recent activity**: LinkedIn posts + Linkup research (news, talks, interviews)
- **Company**: Once employer is identified, run full company enrichment (Section 3) and include summary

**When APIs disagree**: Show both values with source labels, e.g.:
> **Title**: VP Engineering (Fiber) / Senior VP Engineering (LinkedIn) -- CONFLICT

## 3. Company Enrichment

Run ALL of these in parallel where possible.

### 3a. Overview

**Brand.dev** (industry, size, description, logo):
```bash
# By domain (primary):
orth run brand-dev /v1/brand/retrieve --query domain=stripe.com

# By company name (if no domain):
orth run brand-dev /v1/brand/retrieve-by-name --query name=Stripe

# By email (extracts domain):
orth run brand-dev /v1/brand/retrieve-by-email --query email=john@stripe.com
```

**Hunter company data:**
```bash
orth run hunter /v2/domain-search --query domain=stripe.com
```

**LinkedIn** (cross-reference Shofo + Fiber):
```bash
orth run shofo /linkedin/company-profile -q company=stripe
orth run fiber /v1/kitchen-sink/company --body '{"companyDomain": {"domain": "stripe.com"}}'
```

### 3b. Leadership & Employees

**Key people by title:**
```bash
orth run fiber /v1/natural-language-search/profiles --body '{"query": "CEO, CTO, CFO, COO, VP at Stripe", "pageSize": 10}'
```

**Employee search:**
```bash
orth run shofo /linkedin/search-employees -q company=stripe count=10
```

### 3c. Funding

**Nyne funding history** (async):
```bash
# Step 1: POST
orth run -X POST nyne /company/funding -d '{"company_name": "Stripe"}'
# Step 2: Poll with GET
orth run nyne /company/funding -q request_id=REQUEST_ID
```

**Nyne investors:**
```bash
orth run -X POST nyne /company/funders -d '{"company_domain": "stripe.com"}'
```

### 3d. Products & Web Presence

**Products from website:**
```bash
orth run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
```

**Scrape for pricing/features:**
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://stripe.com/pricing",
  "user_prompt": "Extract all products, pricing tiers, and features"
}'
```

**Find competitors/similar companies:**
```bash
orth run exa /findSimilar --body '{
  "url": "https://stripe.com",
  "numResults": 10,
  "contents": {"text": true}
}'
```

### 3e. Open-Ended Research
```bash
orth run linkup /search --body '{
  "q": "Stripe recent news funding announcements partnerships press releases",
  "depth": "deep",
  "outputType": "sourcedAnswer"
}'
```

### 3f. Compile Company Profile

Cross-reference all results into a single report:
- **Overview**: Name, domain, industry, description, logo (Brand.dev) + employee count, HQ (LinkedIn)
- **Leadership**: Key executives from Fiber natural-language-search + Shofo employees
- **Funding**: Rounds, amounts, dates (Nyne) + investors
- **Products**: From Brand.dev ai/products + Scrapegraph pricing
- **Competitors**: From Exa findSimilar
- **Recent news**: From Linkup deep search
- **Social presence**: LinkedIn page stats + recent posts

**When APIs disagree**: Show both values with source labels.

## 4. Full Pipeline Example — `enrich john@stripe.com`

**Step 1: Detect** — Email → person enrichment + extract domain `stripe.com` for company.

**Step 2: Person enrichment** (run in parallel):
```bash
# Profile (3 sources)
orth run fiber /v1/kitchen-sink/person --body '{"emailAddress": "john@stripe.com", "companyDomain": {"domain": "stripe.com"}}'
orth run nyne /person/search -d '{"query": "john stripe.com"}'
orth run sixtyfour /enrich-lead --body '{"lead_info": {"email": "john@stripe.com", "company": "Stripe"}, "struct": {"work_email": "Work email", "personal_email": "Personal email", "phone": "Phone", "title": "Title", "bio": "Bio"}}'

# Find personal email
orth run tomba /v1/enrich --query email=john@stripe.com

# Verify work email (3 sources)
orth run hunter /v2/email-verifier --query email=john@stripe.com
orth run tomba /v1/email-verifier --query email=john@stripe.com
orth run fiber /v1/validate-email/single --body '{"email": "john@stripe.com"}'
# Also verify any personal emails found with the same 3 verifiers

# Phone
orth run sixtyfour /find-phone --body '{"lead": {"email": "john@stripe.com", "company": "Stripe"}}'

# Research
orth run linkup /search --body '{"q": "john stripe.com", "depth": "deep", "outputType": "sourcedAnswer"}'
```

Once you have the person's full name + LinkedIn from Step 2, fire off:
```bash
# LinkedIn profiles
orth run shofo /linkedin/user-profile -q username=LINKEDIN_USERNAME
orth run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "LINKEDIN_URL"}'
orth run shofo /linkedin/user-posts -q username=LINKEDIN_USERNAME count=5

# Twitter (if discovered)
orth run shofo /x/user-profile -q username=TWITTER_HANDLE
```

**Step 3: Company enrichment** (run in parallel with person):
```bash
# Overview
orth run brand-dev /v1/brand/retrieve --query domain=stripe.com
orth run hunter /v2/domain-search --query domain=stripe.com
orth run shofo /linkedin/company-profile -q company=stripe
orth run fiber /v1/kitchen-sink/company --body '{"companyDomain": {"domain": "stripe.com"}}'

# Leadership
orth run fiber /v1/natural-language-search/profiles --body '{"query": "CEO, CTO, CFO, COO, VP at Stripe", "pageSize": 10}'
orth run shofo /linkedin/search-employees -q company=stripe count=10

# Funding
orth run -X POST nyne /company/funding -d '{"company_name": "Stripe"}'
orth run -X POST nyne /company/funders -d '{"company_domain": "stripe.com"}'

# Products & competitors
orth run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
orth run scrapegraph /v1/smartscraper --body '{"website_url": "https://stripe.com/pricing", "user_prompt": "Extract all products, pricing tiers, and features"}'
orth run exa /findSimilar --body '{"url": "https://stripe.com", "numResults": 10}'

# News
orth run linkup /search --body '{"q": "Stripe recent news funding announcements", "depth": "deep", "outputType": "sourcedAnswer"}'
```

**Step 4: Compile** — Merge all results into one comprehensive report. List all emails (work + personal) with type labels and verification status. Cross-reference, flag conflicts, present consolidated person + company profile.

## 5. Tips

- **Parallelize**: Run all independent API calls concurrently — person and company enrichment can run simultaneously
- **Nyne is async**: POST returns `request_id`, poll with GET until status is complete (5-20 seconds)
- **Conflicts**: When APIs disagree, show both values with source labels — never silently pick one
- **LinkedIn URLs**: Dramatically improve match rates for Fiber and Tomba — extract from any source that returns them
- **All emails matter**: Always collect both work AND personal emails — recruiting and hiring use cases need personal emails. Label each as work/personal
- **Email verification**: Verify every email (work + personal) with all 3 verifiers (Hunter, Tomba, Fiber) and take consensus
- **Person → Company**: Person enrichment always cascades — once you identify their employer, run full company enrichment automatically
- **Linkup deep search**: Best for personalization angles — recent talks, interviews, blog posts, news mentions
- **Shofo can be flaky**: LinkedIn profile/company endpoints may return 400 intermittently — retry once, and rely on Fiber as the primary LinkedIn data source
- **Sixtyfour enrich-lead is slow**: Takes 30-60 seconds (AI web research). Fire it early and don't block on it
- **Adaptive**: Skip APIs that don't apply (e.g., don't run email-finder if email is already known, don't run funding search for public megacorps)
- **Tomba linkedin**: If you have a LinkedIn URL but no email, Tomba's LinkedIn finder is very effective
- **Company from email**: Brand.dev's retrieve-by-email endpoint handles domain extraction automatically
