---
name: company-intel
description: Full company intelligence report - overview, team, funding, products, news
---

# Company Intelligence - Comprehensive Company Reports

Generate full intelligence reports on any company including overview, team, funding, products, and recent news.

## Workflow

### Step 1: Company Overview
Get basic company information:

```bash
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

### Step 2: Find Leadership Team
Get info on key executives:

```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["Stripe"],
    "job_titles": ["CEO", "CTO", "CFO", "COO", "VP", "Head of"]
  }
}'
```

### Step 3: Product Analysis
Analyze products and pricing:

```bash
orth api run scrapegraph /api/extract --body '{
  "url": "https://stripe.com/pricing",
  "prompt": "Extract all products, pricing tiers, and features"
}'
```

### Step 4: Employee Count & Growth
Track company growth:

```bash
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "company_names": ["Stripe"]
  }
}'
```

## Full Intelligence Report Pipeline

```bash
# Generate complete report
DOMAIN="stripe.com"
COMPANY="Stripe"

# 1. Basic info
orth api run brand-dev /v1/brand/retrieve --query "domain=$DOMAIN"

# 2. Leadership team
orth api run fiber /v1/people-search --body "{\"searchParams\": {\"company_names\": [\"$COMPANY\"], \"job_titles\": [\"CEO\", \"CTO\", \"CFO\"]}}"

# 3. Products & pricing
orth api run scrapegraph /api/extract --body "{\"url\": \"https://$DOMAIN/pricing\", \"prompt\": \"Extract all products, pricing tiers, and features\"}"

# 4. Company data
orth api run fiber /v1/company-search --body "{\"searchParams\": {\"company_names\": [\"$COMPANY\"]}}"
```

## Tips

- Combine multiple sources for accuracy
- Verify funding data from multiple sources
- Track company over time for changes
- Note any discrepancies between sources

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show fiber
orth api show scrapegraph
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
