---
name: jd-candidate-search
description: Paste a job description and find matching LinkedIn profiles instantly
---

# JD Candidate Search - Job Description to Candidates

Paste a raw job description and get matching LinkedIn profiles. Converts unstructured JD text into candidate results — no manual filter building needed.

## Workflow

### Step 1: Search with Job Description
Paste the full JD text:

```bash
orth api run fiber /v1/natural-language-search/job-description-search --body '{
  "search": {
    "request": "initial",
    "query": "Senior Backend Engineer with 5+ years experience in Go or Rust, distributed systems, Kubernetes. Remote-friendly, Series B startup."
  },
  "pageSize": 25
}'
```

### Step 2: Get More Results
Use the cursor from the first response to paginate:

```bash
orth api run fiber /v1/natural-language-search/job-description-search --body '{
  "search": {
    "request": "next",
    "cursor": "CURSOR_FROM_PREVIOUS_RESPONSE"
  },
  "pageSize": 25
}'
```

### Step 3: Enrich Top Candidates
Get full profile details for promising matches:

```bash
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/CANDIDATE_SLUG"}'
```

### Step 4: Get Contact Info
Reach out to candidates:

```bash
orth api run hunter /v2/email-finder --query 'domain=candidate-company.com&first_name=Jane&last_name=Doe'
```

## Example Usage

```bash
# Search from a full JD
orth api run fiber /v1/natural-language-search/job-description-search --body '{
  "search": {
    "request": "initial",
    "query": "Staff Frontend Engineer. Requirements: 8+ years React/TypeScript, design system experience, accessibility expertise. Nice to have: Next.js, GraphQL, Figma plugin development. Location: NYC or remote US."
  },
  "pageSize": 10
}'

# Shorter role description also works
orth api run fiber /v1/natural-language-search/job-description-search --body '{
  "search": {
    "request": "initial",
    "query": "VP of Sales, B2B SaaS, enterprise sales experience, team of 20+, based in Austin TX"
  },
  "pageSize": 10
}'

# Include detailed work experience in results
orth api run fiber /v1/natural-language-search/job-description-search --body '{
  "search": {
    "request": "initial",
    "query": "Machine Learning Engineer, PyTorch, recommendation systems, 3+ years"
  },
  "pageSize": 10,
  "getDetailedWorkExperience": true
}'
```

## Tips

- Longer, more specific JD text produces better matches
- Include requirements, nice-to-haves, location, and seniority for best results
- Use `getDetailedWorkExperience: true` to see full career history (slower)
- Use `getDetailedEducation: true` to see school details (slower)
- Cost: 2 credits per request + 1 credit per profile returned
- Page through results with `cursor` — first page often has the strongest matches
- Works great alongside natural-language profile search for different angles on the same role

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
orth api show hunter
```

Example: `orth api show fiber /v1/natural-language-search/job-description-search` for endpoint parameters.
