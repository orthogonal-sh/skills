---
name: market-research
description: Research market trends, size, competitors, and growth opportunities
---

# Market Research - Comprehensive Market Analysis

Research market size, trends, competitors, and growth opportunities for any industry.

## Workflow

### Step 1: Market Overview
Get comprehensive market analysis:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/research" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "AI software market size 2024 growth projections trends key players competitive landscape"
  }'
```

### Step 2: Market Size & Statistics
Find specific market data:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "What is the current market size of the AI software industry? Include TAM, SAM, growth rate, and projections for 2025-2030 with sources."
    }]
  }'
```

### Step 3: Identify Key Players
Find competitors in the market:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/natural-language-search/companies" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "AI software companies with over 100 employees, Series B or later funding"
  }'
```

### Step 4: Analyze Trends
Research emerging trends:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "emerging trends AI software industry 2024 2025 predictions experts",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Step 5: Customer Segments
Understand target customers:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/answers" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "Who are the main customer segments for enterprise AI software? What are their pain points and buying criteria?"
  }'
```

### Step 6: Pricing Analysis
Research pricing models:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/searchscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "user_prompt": "Find and compare pricing for top AI software platforms - per seat, usage-based, enterprise pricing"
  }'
```

## Example Usage

```bash
# Quick market overview
orth api run tavily /research --body '{
  "query": "EdTech market analysis 2024 - size, growth, key players, trends, challenges"
}'

# Compare market segments
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Compare B2B vs B2C SaaS markets - size, growth rates, typical metrics, investment trends"}]
}'
```

## Tips

- Cite specific sources and dates for statistics
- Compare multiple analyst reports
- Look for both bullish and bearish perspectives
- Update research quarterly for fast-moving markets
