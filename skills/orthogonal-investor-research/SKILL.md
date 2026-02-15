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
orth run fiber /v1/investor-search --body '{
  "searchParams": {
    "investment_stages": ["Seed", "Series A"],
    "industries": ["AI", "SaaS", "Developer Tools"]
  }
}'
```

### Step 2: Find Portfolio Companies
See their existing investments:

```bash
orth run exa /search --body '{
  "query": "Sequoia Capital portfolio companies AI 2023 2024",
  "num_results": 30
}'
```

### Step 3: Find Partner Contacts
Get contact info for partners:

```bash
orth run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["Sequoia Capital"],
    "job_titles": ["Partner", "General Partner", "Principal"]
  }
}'
```

### Step 4: Get Partner Email
Find email for outreach:

```bash
orth run sixtyfour /find-email --body '{
  "lead": {
    "first_name": "Alfred",
    "last_name": "Lin",
    "company": "Sequoia Capital"
  }
}'
```

## Example Usage

```bash
# Find AI-focused investors
orth run fiber /v1/investor-search --body '{
  "searchParams": {
    "industries": ["AI", "Machine Learning"],
    "investment_stages": ["Seed"],
    "locations": ["San Francisco", "New York"]
  }
}'

# Find angels in your space
orth run exa /search --body '{
  "query": "angel investors who invest in developer tools startups",
  "num_results": 25
}'
```

## Tips

- Check for portfolio overlap before reaching out
- Find warm intros through mutual connections
- Research partner's personal investment interests
- Time outreach when raising (not too early/late)

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show exa
orth api show fiber
orth api show sixtyfour
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
