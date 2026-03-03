---
name: job-search
description: Search for jobs and companies hiring for specific roles using Fiber AI
---

# Job Search - Find Companies Hiring for Specific Roles

Search for job postings and companies actively hiring using Fiber's company search with job posting filters.

## Workflow

### Step 1: Quick Search (Natural Language)

For simple searches, use the natural language endpoint:

```bash
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "Companies hiring Software Engineers in San Francisco",
  "pageSize": 25
}'
```

### Step 2: Structured Search (Precise Filters)

For precise control, use company-search with `jobPostingsV2` filters. This finds companies that have job postings matching your criteria:

```bash
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "jobPostingsV2": {
      "allOf": [{
        "jobTitle": ["Software Engineer", "Full Stack Developer"],
        "jobPostingStatus": "active",
        "countryOrRegionCode": ["USA"],
        "jobLocationType": ["Remote"],
        "seniority": ["Mid-Senior level"],
        "employmentType": ["Full-time"]
      }]
    },
    "headquartersCountryCode": {"anyOf": ["USA"]}
  },
  "pageSize": 25
}'
```

#### jobPostingsV2 Filter Fields

Inside each filter object in `allOf`, `anyOf`, or `noneOf`:

- `jobTitle` (string[]) - Job title keywords to match, e.g. `["GTM Engineer", "Growth Engineer"]`
- `keywords` (string[]) - Keywords to search in job descriptions
- `jobPostingStatus` - `"active"`, `"closed"`, or `"either"`
- `countryOrRegionCode` (string[]) - 3-letter country codes, e.g. `["USA", "GBR"]`
- `seniority` (string[]) - `"Entry level"`, `"Associate"`, `"Mid-Senior level"`, `"Director"`, `"Executive"`, `"Internship"`, `"Not Applicable"`
- `employmentType` (string[]) - `"Full-time"`, `"Part-time"`, `"Contract"`, `"Temporary"`, `"Internship"`, `"Volunteer"`, `"Other"`
- `jobFunction` (string[]) - e.g. `"Engineering"`, `"Sales"`, `"Marketing"`, `"Information Technology"`
- `industry` (string[]) - e.g. `"Software"`, `"Healthcare"`, `"Finance"`
- `jobLocationType` (string[]) - `"On-site"`, `"Remote"`, `"Hybrid"`
- `postedAt` - Date filter (absolute or relative), e.g. `{"strategy": "relative", "window": {"method": "lastN", "period": "month", "quantity": 1}}`
- `annualPayUSD` - Salary range, e.g. `{"lowerBound": 100000, "upperBound": 200000}`
- `yearsOfExperience` - Experience range, e.g. `{"lowerBound": 3, "upperBound": 10}`
- `geoLocation` - Radial search with lat/lng and radius

#### Combining with Company Filters

You can add company-level filters alongside `jobPostingsV2`:

- `headquartersCountryCode`: `{"anyOf": ["USA"]}` or `{"noneOf": [...]}`
- `employeeCountV2`: `{"lowerBoundExclusive": 50}` (values: 0, 1, 10, 50, 200, 500, 1000, 5000, 10000)
- `industriesV2`: `{"anyOf": ["Software", "Artificial Intelligence"]}`
- `revenueUSD`: `{"min": {"quantity": 10, "suffix": "M"}}`
- `stage`: `{"anyOf": ["seed", "series_a", "series_b"]}`

### Step 3: Convert Natural Language to Structured Filters

If you want structured params from a description:

```bash
orth api run fiber /v1/text-to-search-params/companies --body '{
  "query": "AI startups in the US with 50+ employees hiring for Machine Learning Engineers"
}'
```

This returns a structured `searchParams` object you can use directly in `/v1/company-search`.

### Step 4: Research Companies

Get detailed info on interesting companies:

```bash
orth api run fiber /v1/kitchen-sink/company --body '{
  "companyIdentifier": "https://linkedin.com/company/anthropic"
}'
```

### Step 5: Find Hiring Managers

Find people at target companies:

```bash
orth api run fiber /v1/people-search --body '{
  "searchParams": {
    "jobTitleV3": {
      "anyOf": [
        {"type": "plain", "term": "Engineering Manager"},
        {"type": "plain", "term": "VP Engineering"}
      ]
    }
  },
  "currentCompanies": [{"identifier": "domain", "domain": "anthropic.com"}],
  "pageSize": 10
}'
```

### Step 6: Get Contact Info

Find email for outreach:

```bash
orth api run hunter /v2/email-finder --query 'domain=anthropic.com&first_name=John&last_name=Doe'
```

## Examples

```bash
# Find companies hiring GTM Engineers in SF
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "jobPostingsV2": {
      "allOf": [{
        "jobTitle": ["GTM Engineer", "Go-To-Market Engineer", "Growth Engineer"],
        "jobPostingStatus": "active",
        "countryOrRegionCode": ["USA"]
      }]
    },
    "headquartersLocation": {
      "unionAll": [{
        "strategy": "radial-distance",
        "center": {"latitude": 37.7749, "longitude": -122.4194},
        "radius": {"unit": "miles", "quantity": 50}
      }]
    }
  },
  "pageSize": 25
}'

# Find remote AI/ML jobs at well-funded startups
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "jobPostingsV2": {
      "allOf": [{
        "jobTitle": ["Machine Learning Engineer", "AI Engineer"],
        "jobPostingStatus": "active",
        "jobLocationType": ["Remote"],
        "keywords": ["LLM", "generative AI"]
      }]
    },
    "stage": {"anyOf": ["series_a", "series_b", "series_c"]},
    "industriesV2": {"anyOf": ["Artificial Intelligence", "Software"]}
  },
  "pageSize": 25
}'

# Quick natural language search
orth api run fiber /v1/natural-language-search/companies --body '{
  "query": "YC startups hiring senior backend engineers, remote OK"
}'
```

## Tips

- Use `allOf` when ALL conditions must match, `anyOf` when ANY condition can match
- Use `noneOf` to exclude (e.g. exclude closed positions)
- Paginate with `cursor` from previous response
- Use `text-to-search-params` to validate your filters before running full search
- The natural language endpoint is great for quick searches; structured search gives more control

## Discover More

```bash
orth api show fiber              # List all endpoints
orth api show fiber /v1/company-search   # Get endpoint details
```
