---
name: sales-prospecting
description: Build targeted prospect lists with verified contact information
---

# Sales Prospecting - Build Quality Lead Lists

Build targeted prospect lists with verified emails and contact information.

## Workflow

### Step 1: Define Target Companies
Search for companies matching your ICP:

```bash
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "B2B SaaS startups in San Francisco with 50-200 employees Series A or B funded"
}'
```

### Step 2: Find Decision Makers
Search for people at target companies:

```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "job_titles": ["CTO", "VP Engineering", "Head of Engineering"],
    "company_names": ["Stripe", "Figma", "Notion"],
    "locations": ["San Francisco"]
  }
}'
```

### Step 3: Get All Emails for Company
Find all contacts at a domain:

```bash
orth api run hunter /v2/domain-search --query 'domain=stripe.com'
```

### Step 4: Find Specific Contact's Email
Find email for a specific person:

```bash
orth api run sixtyfour /find-email --body '{
  "lead": {
    "first_name": "Sarah",
    "last_name": "Chen",
    "domain": "stripe.com"
  }
}'
```

### Step 5: Verify Emails
Check deliverability before outreach:

```bash
orth api run fiber /v1/validate-email/single --body '{"email": "sarah@stripe.com"}'
```

### Step 6: Enrich with Company Data
Get company context for personalization:

```bash
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

## Prospecting Pipeline

```bash
# 1. Find companies (Fiber)
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "industries": ["Software", "SaaS"],
    "employee_count_min": 50,
    "employee_count_max": 500,
    "locations": ["San Francisco", "New York"]
  }
}'

# 2. Find decision makers (Fiber)
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "job_titles": ["VP Sales", "Head of Sales", "CRO"],
    "company_domains": ["company1.com", "company2.com"]
  }
}'

# 3. Get emails (Hunter)
orth api run hunter /v2/domain-search --query 'domain=company1.com'

# 4. Verify emails (Fiber)
orth api run fiber /v1/validate-email/single --body '{"email": "lead@company.com"}'
```

## Tips

- Target specific job titles relevant to your product
- Verify all emails before adding to sequences
- Personalize outreach with company context
- Track email engagement for list optimization

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show fiber
orth api show hunter
orth api show sixtyfour 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
