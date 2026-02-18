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
| Email | `@` | Person enrichment + extract domain for company |
| LinkedIn person URL | `linkedin.com/in/` | Person enrichment |
| LinkedIn company URL | `linkedin.com/company/` | Company enrichment |
| Domain | `*.com`, `*.io`, etc. | Company enrichment |
| Company name | No special pattern | Company enrichment |
| Name + company | "John Doe at Stripe" | Person enrichment |
| Twitter/X handle | `@handle` or `x.com/` | Person enrichment |

**If email provided:** always run BOTH person (full pipeline) AND company (extract domain) enrichment.
**If LinkedIn person URL provided:** extract username for Shofo calls, full URL for Fiber calls.

## 2. Person Enrichment

Run ALL of these in parallel where possible. Collect everything, then compile.

### 2a. Full Profile & Contact Info

**Fiber kitchen-sink** (accepts LinkedIn URL, email, or name+company):
```bash
# By LinkedIn URL:
orth api run fiber /v1/kitchen-sink/person --body '{"profileIdentifier": "https://linkedin.com/in/johndoe"}'

# By email:
orth api run fiber /v1/kitchen-sink/person --body '{"emailAddress": "john@stripe.com"}'

# By name + company:
orth api run fiber /v1/kitchen-sink/person --body '{
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
orth run nyne /person/search -q 'request_id=REQUEST_ID'
```

**Sixtyfour enrich-lead** (AI-powered):
```bash
orth api run sixtyfour /enrich-lead --body '{
  "lead_info": {"first_name": "John", "last_name": "Doe", "company": "Stripe", "linkedin_url": "https://linkedin.com/in/johndoe"},
  "struct": {"email": "Work email", "phone": "Phone number", "title": "Job title", "bio": "Short bio"}
}'
```

### 2b. Email — Find & Verify

**Find email** (cross-reference Hunter + Tomba):
```bash
# Hunter
orth run hunter /v2/email-finder --query 'domain=stripe.com&first_name=John&last_name=Doe'

# Tomba
orth run tomba /v1/email-finder --query 'domain=stripe.com&company=Stripe&first_name=John&last_name=Doe'

# Tomba from LinkedIn (if URL available)
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/johndoe'
```

**Verify email** (run all three, compare):
```bash
orth run hunter /v2/email-verifier --query 'email=john@stripe.com'
orth run tomba /v1/email-verifier --query 'email=john@stripe.com'
orth api run fiber /v1/validate-email/single --body '{"email": "john@stripe.com"}'
```

### 2c. Phone
```bash
orth api run sixtyfour /find-phone --body '{
  "lead": {"first_name": "John", "last_name": "Doe", "company": "Stripe"}
}'
```

### 2d. Social Profiles

**LinkedIn** (cross-reference Shofo + Fiber):
```bash
orth run shofo /linkedin/user-profile -q 'username=johndoe'
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/johndoe"}'
```

**Twitter/X** (if handle known or discovered):
```bash
orth run shofo /x/user-profile -q 'username=johndoe'
```

**Recent LinkedIn activity:**
```bash
orth run shofo /linkedin/user-posts -q 'username=johndoe&count=5'
```

### 2e. Open-Ended Research
```bash
orth api run linkup /search --body '{
  "q": "John Doe Stripe VP Engineering recent news interviews talks",
  "depth": "deep",
  "outputType": "sourcedAnswer"
}'
```

### 2f. Compile Person Profile

Cross-reference all results into a single profile:
- **Name & title**: Compare across Fiber, Nyne, Sixtyfour, LinkedIn
- **Email**: Show all found emails with confidence scores + verification status from each verifier
- **Phone**: From Sixtyfour find-phone
- **LinkedIn**: URL + headline + summary from both Shofo and Fiber (flag differences)
- **Twitter/X**: Profile + recent activity
- **Work history**: Merge Nyne (deep) + Fiber (current) + LinkedIn
- **Education**: From Nyne + LinkedIn
- **Recent activity**: LinkedIn posts + Linkup research (news, talks, interviews)

**When APIs disagree**: Show both values with source labels, e.g.:
> **Title**: VP Engineering (Fiber) / Senior VP Engineering (LinkedIn) -- CONFLICT

## 3. Company Enrichment

Run ALL of these in parallel where possible.

### 3a. Overview

**Brand.dev** (industry, size, description, logo):
```bash
# By domain (primary):
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'

# By company name (if no domain):
orth api run brand-dev /v1/brand/retrieve-by-name --query 'name=Stripe'

# By email (extracts domain):
orth api run brand-dev /v1/brand/retrieve-by-email --query 'email=john@stripe.com'
```

**Hunter company data:**
```bash
orth run hunter /v2/domain-search --query 'domain=stripe.com'
```

**LinkedIn** (cross-reference Shofo + Fiber):
```bash
orth run shofo /linkedin/company-profile -q 'company=stripe'
orth api run fiber /v1/linkedin-live-fetch/company/single --body '{"identifier": "https://linkedin.com/company/stripe"}'
```

### 3b. Leadership & Employees

**Key people by title:**
```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["Stripe"],
    "job_titles": ["CEO", "CTO", "CFO", "COO", "VP", "Head of"]
  }
}'
```

**Employee search:**
```bash
orth run shofo /linkedin/search-employees -q 'company=stripe&count=10'
```

### 3c. Funding

**Nyne funding history** (async):
```bash
# Step 1: POST
orth run -X POST nyne /company/funding -d '{"company_name": "Stripe"}'
# Step 2: Poll with GET
orth run nyne /company/funding -q 'request_id=REQUEST_ID'
```

**Nyne investors:**
```bash
orth run -X POST nyne /company/funders -d '{"company_domain": "stripe.com"}'
```

### 3d. Products & Web Presence

**Products from website:**
```bash
orth api run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
```

**Scrape for pricing/features:**
```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://stripe.com/pricing",
  "user_prompt": "Extract all products, pricing tiers, and features"
}'
```

**Find competitors/similar companies:**
```bash
orth api run exa /findSimilar --body '{
  "url": "https://stripe.com",
  "numResults": 10,
  "contents": {"text": true}
}'
```

### 3e. Open-Ended Research
```bash
orth api run linkup /search --body '{
  "q": "Stripe recent news funding announcements partnerships press releases",
  "depth": "deep",
  "outputType": "sourcedAnswer"
}'
```

### 3f. Compile Company Profile

Cross-reference all results into a single report:
- **Overview**: Name, domain, industry, description, logo (Brand.dev) + employee count, HQ (LinkedIn)
- **Leadership**: Key executives from Fiber people-search + Shofo employees
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
orth api run fiber /v1/kitchen-sink/person --body '{"emailAddress": "john@stripe.com", "companyDomain": {"domain": "stripe.com"}}'
orth run nyne /person/search -d '{"query": "john stripe.com"}'
orth api run sixtyfour /enrich-lead --body '{"lead_info": {"email": "john@stripe.com", "company": "Stripe"}, "struct": {"phone": "Phone", "title": "Title", "bio": "Bio"}}'

# Email verify (3 sources)
orth run hunter /v2/email-verifier --query 'email=john@stripe.com'
orth run tomba /v1/email-verifier --query 'email=john@stripe.com'
orth api run fiber /v1/validate-email/single --body '{"email": "john@stripe.com"}'

# Phone
orth api run sixtyfour /find-phone --body '{"lead": {"email": "john@stripe.com", "company": "Stripe"}}'

# Research
orth api run linkup /search --body '{"q": "john stripe.com", "depth": "deep", "outputType": "sourcedAnswer"}'
```

Once you have the person's full name + LinkedIn from Step 2, fire off:
```bash
# LinkedIn profiles
orth run shofo /linkedin/user-profile -q 'username=LINKEDIN_USERNAME'
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "LINKEDIN_URL"}'
orth run shofo /linkedin/user-posts -q 'username=LINKEDIN_USERNAME&count=5'

# Twitter (if discovered)
orth run shofo /x/user-profile -q 'username=TWITTER_HANDLE'
```

**Step 3: Company enrichment** (run in parallel with person):
```bash
# Overview
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
orth run hunter /v2/domain-search --query 'domain=stripe.com'
orth run shofo /linkedin/company-profile -q 'company=stripe'
orth api run fiber /v1/linkedin-live-fetch/company/single --body '{"identifier": "https://linkedin.com/company/stripe"}'

# Leadership
orth api run fiber /v1/people-search --body '{"searchParams": {"company_names": ["Stripe"], "job_titles": ["CEO", "CTO", "CFO", "COO", "VP"]}}'
orth run shofo /linkedin/search-employees -q 'company=stripe&count=10'

# Funding
orth run -X POST nyne /company/funding -d '{"company_name": "Stripe"}'
orth run -X POST nyne /company/funders -d '{"company_domain": "stripe.com"}'

# Products & competitors
orth api run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
orth api run scrapegraph /v1/smartscraper --body '{"website_url": "https://stripe.com/pricing", "user_prompt": "Extract all products, pricing tiers, and features"}'
orth api run exa /findSimilar --body '{"url": "https://stripe.com", "numResults": 10}'

# News
orth api run linkup /search --body '{"q": "Stripe recent news funding announcements", "depth": "deep", "outputType": "sourcedAnswer"}'
```

**Step 4: Compile** — Merge all results into one comprehensive report. Cross-reference, flag conflicts, present consolidated person + company profile.

## 5. Tips

- **Parallelize**: Run all independent API calls concurrently — person and company enrichment can run simultaneously
- **Nyne is async**: POST returns `request_id`, poll with GET until status is complete (5-20 seconds)
- **Conflicts**: When APIs disagree, show both values with source labels — never silently pick one
- **LinkedIn URLs**: Dramatically improve match rates for Fiber and Tomba — extract from any source that returns them
- **Email verification**: Always verify emails before outreach — use all 3 verifiers (Hunter, Tomba, Fiber) and take consensus
- **Linkup deep search**: Best for personalization angles — recent talks, interviews, blog posts, news mentions
- **Adaptive**: Skip APIs that don't apply (e.g., don't run email-finder if email is already known, don't run funding search for public megacorps)
- **Tomba linkedin**: If you have a LinkedIn URL but no email, Tomba's LinkedIn finder is very effective
- **Company from email**: Brand.dev's retrieve-by-email endpoint handles domain extraction automatically
