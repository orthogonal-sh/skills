---
name: investor-research
description: Research VCs, angels, and investors - portfolio, thesis, contact info
---

# Investor Research - Find and Research Investors

Research venture capitalists, angel investors, and their investment patterns.

## Workflow

### Step 1: Search for Investors
Find investors in your space:

```bash
orth api run fiber /v1/investor-search --body '{
  "investment_stages": ["Seed", "Series A"],
  "industries": ["AI", "SaaS", "Developer Tools"]
}'
```

### Step 2: Research Investment Thesis
Understand investor focus:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "What is Andreessen Horowitz investment thesis for AI companies? What do they look for in founders and startups?"
  }]
}'
```

### Step 3: Find Portfolio Companies
See their existing investments:

```bash
orth api run exa /search --body '{
  "query": "Sequoia Capital portfolio companies AI 2023 2024",
  "num_results": 30
}'
```

### Step 4: Find Partner Contacts
Get contact info for partners:

```bash
orth api run fiber /v1/people-search --body '{
  "company_names": ["Sequoia Capital"],
  "job_titles": ["Partner", "General Partner", "Principal"]
}'
```

### Step 5: Get Partner Email
Find email for outreach:

```bash
orth api run sixtyfour /find-email --body '{
  "first_name": "Alfred",
  "last_name": "Lin",
  "company": "Sequoia Capital"
}'
```

### Step 6: Recent Activity
Track recent investments:

```bash
orth api run tavily /search --body '{
  "query": "Sequoia Capital recent investments 2024 AI startups announcements",
  "search_depth": "advanced",
  "include_answer": true
}'
```

## Example Usage

```bash
# Find AI-focused investors
orth api run fiber /v1/investor-search --body '{
  "industries": ["AI", "Machine Learning"],
  "investment_stages": ["Seed"],
  "locations": ["San Francisco", "New York"]
}'

# Research specific investor
orth api run tavily /research --body '{
  "query": "First Round Capital - investment thesis, notable exits, typical check size, portfolio companies"
}'

# Find angels in your space
orth api run exa /search --body '{
  "query": "angel investors who invest in developer tools startups",
  "num_results": 25
}'
```

## Tips

- Check for portfolio overlap before reaching out
- Find warm intros through mutual connections
- Research partner's personal investment interests
- Time outreach when raising (not too early/late)
