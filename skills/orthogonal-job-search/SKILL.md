---
name: job-search
description: Search for jobs matching your skills, experience, and preferences
---

# Job Search - Find Your Next Role

Search for jobs matching your skills, experience level, and location preferences.

## Workflow

### Step 1: Search Job Listings
Use Fiber to search for jobs:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/job-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "job_titles": ["Software Engineer", "Full Stack Developer"],
    "locations": ["San Francisco", "Remote"],
    "experience_level": "senior"
  }'
```

### Step 2: Research Companies
Get company information for interesting roles:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/company-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "company_names": ["Stripe", "Figma", "Notion"]
  }'
```

### Step 3: Get Company Intel
Use Brand.dev for detailed company info:

```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 4: Find Hiring Managers
Find people at the company to network with:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/people-search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "company_names": ["Stripe"],
    "job_titles": ["Engineering Manager", "VP Engineering", "CTO"]
  }'
```

### Step 5: Get Contact Info
Find email for outreach:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-finder?domain=stripe.com&first_name=John&last_name=Doe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## Example Usage

```bash
# Search for remote AI jobs
orth api run fiber /v1/job-search --body '{
  "job_titles": ["Machine Learning Engineer", "AI Engineer"],
  "locations": ["Remote"],
  "keywords": ["LLM", "generative AI"]
}'

# Research a company
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "Tell me about Anthropic - funding, team size, culture"
}'
```

## Tips

- Customize your search for each application
- Research company culture before applying
- Network with people at target companies
- Set up alerts for new postings
