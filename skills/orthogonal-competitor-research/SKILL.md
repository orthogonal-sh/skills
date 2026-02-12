---
name: competitor-research
description: Research competitors - products, pricing, team, funding, and strategy
---

# Competitor Research - Comprehensive Intelligence

Gather comprehensive intelligence on competitors including products, pricing, team, and strategy.

## Workflow

### Step 1: Company Overview
Get basic company information:

```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=competitor.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 2: Deep Research
Use Tavily for comprehensive research:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/research" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Notion company analysis - products, pricing, funding, team size, recent news, competitive advantages"
  }'
```

### Step 3: Find Similar Companies
Use Exa to find related competitors:

```bash
curl -X POST "https://api.orth.sh/v1/run/exa/findSimilar" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://notion.so",
    "num_results": 10
  }'
```

### Step 4: Get Product Details
Scrape pricing and features:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://notion.so/pricing",
    "user_prompt": "Extract all pricing tiers, features per tier, and any enterprise options"
  }'
```

### Step 5: Research Team
Find key people at the company:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/people-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "company_names": ["Notion"],
    "job_titles": ["CEO", "CTO", "VP Product", "VP Engineering"]
  }'
```

### Step 6: Track News & Updates
Search for recent news:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Notion news announcements updates 2024",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

## Example Usage

```bash
# Full competitor analysis
orth api run tavily /research --body '{
  "query": "Linear app complete analysis - product, pricing, investors, team, growth, market position vs Jira"
}'

# Compare multiple competitors
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Compare Notion vs Coda vs Confluence - features, pricing, target market, pros/cons"}]
}'

# Find competitor customers
orth api run exa /search --body '{
  "query": "companies using Notion for documentation case studies",
  "num_results": 20
}'
```

## Tips

- Set up regular monitoring for competitor changes
- Track their job postings for strategic insights
- Monitor their social media and blog
- Analyze their customer reviews
