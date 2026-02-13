---
name: fiber
description: People, company, investor, and job search with LinkedIn data enrichment
---

# Fiber AI - People & Company Intelligence

Comprehensive search and enrichment for people, companies, investors, and jobs.

## Capabilities

- **Natural Language Search**: Search people/companies using plain text ($0.54)
- **People Search**: Find people with filters ($0.01)
- **Company Search**: Find companies with filters ($0.01)
- **Investor Search**: Find investors/VCs ($1.50)
- **Job Search**: Search job postings ($0.50)
- **Email Validation**: Check if emails bounce ($0.02)
- **LinkedIn Live**: Fetch real-time LinkedIn data ($0.04)

## Usage

### Natural Language People Search ($0.54)
```bash
orth api run fiber /v1/natural-language-search/profiles --body '{"query": "Software engineers in San Francisco with 5+ years experience"}'
```

### Natural Language Company Search ($0.54)
```bash
orth api run fiber /v1/natural-language-search/companies --body '{"query": "Series A startups in fintech with 50-200 employees"}'
```

### People Search ($0.01)
```bash
orth api run fiber /v1/people-search --body '{
  "job_titles": ["CTO", "VP Engineering"],
  "locations": ["San Francisco", "New York"]
}'
```

### Company Search ($0.01)
```bash
orth api run fiber /v1/company-search --body '{
  "industries": ["Software", "AI"],
  "employee_count_min": 50,
  "employee_count_max": 500
}'
```

### Investor Search ($1.50)
```bash
orth api run fiber /v1/investor-search --body '{
  "investment_stages": ["Seed", "Series A"],
  "industries": ["AI", "SaaS"]
}'
```

### Job Search ($0.50)
```bash
orth api run fiber /v1/job-search --body '{
  "job_titles": ["Software Engineer"],
  "locations": ["Remote"]
}'
```

### Email Validation ($0.02)
```bash
orth api run fiber /v1/validate-email/single --body '{"email": "john@example.com"}'
```

### LinkedIn Profile Fetch ($0.04)
```bash
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"linkedin_url": "https://linkedin.com/in/johndoe"}'
```

### Reverse Email Lookup ($0.04)
```bash
orth api run fiber /v1/email-to-person/single --body '{"email": "john@company.com"}'
```

## Use Cases

1. **Recruiting**: Find candidates matching specific criteria
2. **Sales Prospecting**: Build targeted lead lists
3. **Fundraising**: Research investors in your space
4. **Competitive Intel**: Track companies and their employees
5. **Job Search**: Find relevant job opportunities
