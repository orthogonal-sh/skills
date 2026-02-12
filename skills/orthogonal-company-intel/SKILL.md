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
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 2: Deep Research
Get comprehensive company analysis:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/research" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Stripe company complete analysis - history, products, revenue, funding, team, competitive position, recent news, future plans"
  }'
```

### Step 3: Find Leadership Team
Get info on key executives:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/people-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "company_names": ["Stripe"],
    "job_titles": ["CEO", "CTO", "CFO", "COO", "VP", "Head of"]
  }'
```

### Step 4: Funding History
Research investment history:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "What is Stripe complete funding history? Include all rounds, amounts, valuations, and investors."
    }]
  }'
```

### Step 5: Product Analysis
Analyze products and pricing:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://stripe.com/pricing",
    "user_prompt": "Extract all products, pricing tiers, and features"
  }'
```

### Step 6: Recent News
Get latest company news:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Stripe news announcements updates 2024",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Step 7: Employee Count & Growth
Track company growth:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/company-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "company_names": ["Stripe"]
  }'
```

## Full Intelligence Report Pipeline

```bash
# Generate complete report
DOMAIN="stripe.com"
COMPANY="Stripe"

# 1. Basic info
orth api run brand-dev /v1/brand/retrieve --query "domain=$DOMAIN"

# 2. Deep research
orth api run tavily /research --body "{\"query\": \"$COMPANY complete company analysis\"}"

# 3. Leadership team
orth api run fiber /v1/people-search --body "{\"company_names\": [\"$COMPANY\"], \"job_titles\": [\"CEO\", \"CTO\", \"CFO\"]}"

# 4. Funding
orth api run perplexity /chat/completions --body "{\"model\": \"sonar\", \"messages\": [{\"role\": \"user\", \"content\": \"$COMPANY funding history and investors\"}]}"

# 5. Recent news
orth api run tavily /search --body "{\"query\": \"$COMPANY news 2024\", \"include_answer\": true}"
```

## Tips

- Combine multiple sources for accuracy
- Verify funding data from multiple sources
- Track company over time for changes
- Note any discrepancies between sources
