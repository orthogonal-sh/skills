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
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/natural-language-search/companies" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "B2B SaaS startups in San Francisco with 50-200 employees Series A or B funded"
  }'
```

### Step 2: Find Decision Makers
Search for people at target companies:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/people-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "job_titles": ["CTO", "VP Engineering", "Head of Engineering"],
    "company_names": ["Stripe", "Figma", "Notion"],
    "locations": ["San Francisco"]
  }'
```

### Step 3: Get All Emails for Company
Find all contacts at a domain:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/domain-search?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 4: Find Specific Contact's Email
Find email for a specific person:

```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/find-email" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "Sarah",
    "last_name": "Chen",
    "domain": "stripe.com"
  }'
```

### Step 5: Verify Emails
Check deliverability before outreach:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/validate-email/single" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "sarah@stripe.com"}'
```

### Step 6: Enrich with Company Data
Get company context for personalization:

```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## Prospecting Pipeline

```bash
# 1. Find companies (Fiber)
orth api run fiber /v1/company-search --body '{
  "industries": ["Software", "SaaS"],
  "employee_count_min": 50,
  "employee_count_max": 500,
  "locations": ["San Francisco", "New York"]
}'

# 2. Find decision makers (Fiber)
orth api run fiber /v1/people-search --body '{
  "job_titles": ["VP Sales", "Head of Sales", "CRO"],
  "company_domains": ["company1.com", "company2.com"]
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
