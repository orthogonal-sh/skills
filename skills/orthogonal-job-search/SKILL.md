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
orth run fiber /v1/job-search --body '{
  "searchParams": {
    "job_titles": ["Software Engineer", "Full Stack Developer"],
    "locations": ["San Francisco", "Remote"],
    "experience_level": "senior"
  }
}'
```

### Step 2: Research Companies
Get company information for interesting roles:

```bash
orth run fiber /v1/company-search --body '{
  "searchParams": {
    "company_names": ["Stripe", "Figma", "Notion"]
  }
}'
```

### Step 3: Get Company Intel
Use Brand.dev for detailed company info:

```bash
orth run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

### Step 4: Find Hiring Managers
Find people at the company to network with:

```bash
orth run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["Stripe"],
    "job_titles": ["Engineering Manager", "VP Engineering", "CTO"]
  }
}'
```

### Step 5: Get Contact Info
Find email for outreach:

```bash
orth run hunter /v2/email-finder --query domain=stripe.com first_name=John last_name=Doe
```

## Example Usage

```bash
# Search for remote AI jobs
orth run fiber /v1/job-search --body '{
  "searchParams": {
    "job_titles": ["Machine Learning Engineer", "AI Engineer"],
    "locations": ["Remote"],
    "keywords": ["LLM", "generative AI"]
  }
}'

# Research a company
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "Tell me about Anthropic - funding, team size, culture"
}'
```

## Tips

- Customize your search for each application
- Research company culture before applying
- Network with people at target companies
- Set up alerts for new postings

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show fiber
orth api show hunter 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
