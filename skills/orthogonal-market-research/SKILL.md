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
orth api run tavily /research --body '{
  "query": "AI software market size 2024 growth projections trends key players competitive landscape"
}'
```

### Step 2: Market Size & Statistics
Find specific market data:

```bash
orth api run perplexity /chat/completions --body '{
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
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "AI software companies with over 100 employees, Series B or later funding"
}'
```

### Step 4: Analyze Trends
Research emerging trends:

```bash
orth api run tavily /search --body '{
  "query": "emerging trends AI software industry 2024 2025 predictions experts",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 5: Customer Segments
Understand target customers:

```bash
orth api run olostep /v1/answers --body '{
  "question": "Who are the main customer segments for enterprise AI software? What are their pain points and buying criteria?"
}'
```

### Step 6: Pricing Analysis
Research pricing models:

```bash
orth api run scrapegraph /v1/searchscraper --body '{
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
