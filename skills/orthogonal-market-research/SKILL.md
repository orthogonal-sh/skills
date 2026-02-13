---
name: market-research
description: Research market trends, size, competitors, and growth opportunities
---

# Market Research - Comprehensive Market Analysis

Research market size, trends, competitors, and growth opportunities for any industry.

## Workflow

### Step 1: Identify Key Players
Find companies in the market:

```bash
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "AI software companies with over 100 employees, Series B or later funding"
}'
```

### Step 2: Research Company Details
Get detailed info on key players:

```bash
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "company_names": ["OpenAI", "Anthropic", "Cohere"],
    "include_financials": true
  }
}'
```

### Step 3: Find Decision Makers
Identify leadership at key companies:

```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["OpenAI", "Anthropic"],
    "job_titles": ["CEO", "CTO", "VP Product", "Head of Sales"]
  }
}'
```

## Example Usage

```bash
# Find companies by industry and size
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "EdTech companies with 50-500 employees founded after 2018"
}'

# Search by specific criteria
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "industries": ["Enterprise Software"],
    "employee_count_min": 100,
    "funding_stage": ["Series A", "Series B"]
  }
}'
```

## Tips

- Cite specific sources and dates for statistics
- Compare multiple analyst reports
- Look for both bullish and bearish perspectives
- Update research quarterly for fast-moving markets

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
