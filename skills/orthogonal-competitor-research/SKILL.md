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
orth api run brand-dev /v1/brand/retrieve --query 'domain=competitor.com'
```

### Step 2: Deep Research
Use Tavily for comprehensive research:

```bash
orth api run tavily /research --body '{
  "query": "Notion company analysis - products, pricing, funding, team size, recent news, competitive advantages"
}'
```

### Step 3: Find Similar Companies
Use Exa to find related competitors:

```bash
orth api run exa /findSimilar --body '{
  "url": "https://notion.so",
  "num_results": 10
}'
```

### Step 4: Get Product Details
Scrape pricing and features:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://notion.so/pricing",
  "user_prompt": "Extract all pricing tiers, features per tier, and any enterprise options"
}'
```

### Step 5: Research Team
Find key people at the company:

```bash
orth api run fiber /v1/people-search --body '{
  "company_names": ["Notion"],
  "job_titles": ["CEO", "CTO", "VP Product", "VP Engineering"]
}'
```

### Step 6: Track News & Updates
Search for recent news:

```bash
orth api run tavily /search --body '{
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
