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

### Step 2: Find Similar Companies
Use Exa to find related competitors:

```bash
orth api run exa /findSimilar --body '{
  "url": "https://notion.so",
  "num_results": 10
}'
```

### Step 3: Get Product Details
Scrape pricing and features:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://notion.so/pricing",
  "user_prompt": "Extract all pricing tiers, features per tier, and any enterprise options"
}'
```

### Step 4: Research Team
Find key people at the company:

```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["Notion"],
    "job_titles": ["CEO", "CTO", "VP Product", "VP Engineering"]
  }
}'
```

## Example Usage

```bash
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

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show exa
orth api show fiber
orth api show scrapegraph
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
