---
name: crustdata
description: B2B data platform for company and people intelligence. Search companies by industry, headcount, funding, and growth metrics. Find professionals by title, company, and seniority. Enrich companies and people by domain, LinkedIn URL, or email. Get LinkedIn posts, job listings, Gartner reviews, and ProductHunt data.
---

# Crustdata — B2B Company & People Intelligence

Comprehensive B2B data platform with firmographic data, growth metrics, people profiles, LinkedIn posts, and dataset APIs covering 16+ data sources.

## When to Use

- Search for companies by industry, headcount, funding, growth, or location
- Search for professionals by title, company, seniority, region, or skills
- Enrich a company by domain, name, or ID (headcount, revenue, funding, news, job openings)
- Enrich a person by LinkedIn URL or email (work history, education, skills, contact info)
- Identify/match a company from a domain, name, or LinkedIn URL
- Get LinkedIn posts for a company or person
- Search LinkedIn posts by keyword
- Get job listings for specific companies
- Get Gartner review data for companies
- Get ProductHunt launch metrics for companies

## Usage

### Company Search (In-DB)

Search millions of companies with advanced filtering. Supports nested AND/OR logic, fuzzy matching, and cursor pagination.

```bash
orth run crustdata /screener/companydb/search -b '{
  "filters": {
    "op": "and",
    "conditions": [
      {"filter_type": "linkedin_industries", "type": "(.)", "value": "technology"},
      {"filter_type": "employee_metrics.growth_12m_percent", "type": ">=", "value": 30},
      {"filter_type": "year_founded", "type": ">", "value": 2018}
    ]
  },
  "limit": 50,
  "sorts": [{"column": "employee_metrics.growth_12m_percent", "order": "desc"}]
}'
```

**Filter types:** company_name, hq_country, hq_location, largest_headcount_country, linkedin_industries, linkedin_categories, crunchbase_categories, markets, company_website_domain, year_founded, employee_count_range, employee_metrics.latest_count, employee_metrics.growth_12m_percent, employee_metrics.growth_6m_percent, follower_metrics.latest_count, estimated_revenue_lower_bound_usd, crunchbase_total_investment_usd, crunchbase_valuation_usd, last_funding_round_type (seed, series_a, series_b, series_c, etc.), last_funding_date, acquisition_status, linkedin_id.

**Operators:** `=`, `!=`, `in`, `not_in`, `>`, `<`, `>=`, `<=`, `(.)` (fuzzy text match).

**Pagination:** Use `next_cursor` from response as `cursor` in next request.

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"crustdata","path":"/screener/companydb/search","body":{"filters":{"op":"and","conditions":[{"filter_type":"linkedin_industries","type":"(.)","value":"technology"}]},"limit":20}}'
```
</details>

### People Search (In-DB)

Search millions of professional profiles with advanced filtering.

```bash
orth run crustdata /screener/persondb/search -b '{
  "filters": {
    "op": "and",
    "conditions": [
      {"column": "current_employers.seniority_level", "type": "=", "value": "CXO"},
      {"column": "region", "type": "=", "value": "San Francisco Bay Area"},
      {"column": "current_employers.company_name", "type": "(.)", "value": "Stripe"}
    ]
  },
  "limit": 100
}'
```

**Columns:** current_employers.title, current_employers.company_name, current_employers.seniority_level (CXO, VP, Director, Manager, Senior, Entry), past_employers.title, past_employers.company_name, region, skills, languages, name, first_name, last_name, headline, years_of_experience_raw, recently_changed_jobs, emails, linkedin_profile_url.

### Company Identification

Identify a company in Crustdata's database from a domain, name, LinkedIn URL, or Crunchbase URL. Returns matching companies with relevance scores. Useful for getting the `company_id` needed by other endpoints.

```bash
orth run crustdata /screener/identify/ -b '{"query_company_website": "stripe.com"}'
```

By name:
```bash
orth run crustdata /screener/identify/ -b '{"query_company_name": "Stripe", "count": 5}'
```

### Company Enrichment

Get comprehensive firmographic data for one or more companies.

```bash
orth run crustdata /screener/company -q 'company_domain=stripe.com'
```

Multiple companies:
```bash
orth run crustdata /screener/company -q 'company_domain=stripe.com,hubspot.com,notion.so'
```

With specific fields (reduces response size):
```bash
orth run crustdata /screener/company -q 'company_domain=stripe.com&fields=company_name,headcount,linkedin_company_url,job_openings,news_articles'
```

Realtime enrichment (for companies not yet in database, takes ~10 minutes):
```bash
orth run crustdata /screener/company -q 'company_domain=newstartup.com&enrich_realtime=True'
```

### Person Enrichment

Enrich individuals by LinkedIn URL or business email.

```bash
orth run crustdata /screener/person/enrich -q 'linkedin_profile_url=https://www.linkedin.com/in/satyanadella&fields=name,title,current_employers,email,skills'
```

By email:
```bash
orth run crustdata /screener/person/enrich -q 'business_email=satya@microsoft.com&fields=name,title,current_employers,past_employers'
```

Multiple profiles:
```bash
orth run crustdata /screener/person/enrich -q 'linkedin_profile_url=https://www.linkedin.com/in/person1,https://www.linkedin.com/in/person2&fields=name,title,email'
```

**Available fields:** name, location, email, title, last_updated, headline, summary, num_of_connections, skills, profile_picture_url, profile_picture_permalink, twitter_handle, languages, all_employers, past_employers, current_employers, education_background, all_titles, all_schools, all_degrees, github_profiles, linkedin_profile_url, linkedin_flagship_url.

### LinkedIn Posts

Get recent LinkedIn posts for a company or person.

By company domain:
```bash
orth run crustdata /screener/linkedin_posts -q 'company_domain=stripe.com&page=1'
```

By person:
```bash
orth run crustdata /screener/linkedin_posts -q 'person_linkedin_url=https://www.linkedin.com/in/satyanadella&page=1'
```

By specific post URL:
```bash
orth run crustdata /screener/linkedin_posts -q 'linkedin_post_url=https://www.linkedin.com/feed/update/urn:li:activity:1234567890'
```

**Important:** Use either `page` OR `limit`, not both.

### LinkedIn Post by Keyword Search

Search LinkedIn posts containing specific keywords.

```bash
orth run crustdata /screener/linkedin_posts/keyword_search/ -b '{
  "keyword": "Series A funding",
  "sort_by": "date_posted",
  "date_posted": "past-week",
  "limit": 10
}'
```

With exact matching and author filters:
```bash
orth run crustdata /screener/linkedin_posts/keyword_search/ -b '{
  "keyword": "generative AI",
  "exact_keyword_match": true,
  "limit": 20,
  "sort_by": "relevance",
  "date_posted": "past-month",
  "filters": [{"filter_type": "AUTHOR_TITLE", "type": "in", "value": ["CEO", "Co-Founder"]}]
}'
```

### Job Listings

Get job listings for companies. Use Company Identification first to get `company_id` values.

```bash
orth run crustdata /data_lab/job_listings/Table/ -b '{
  "dataset": {"name": "job_listings", "id": "joblisting"},
  "filters": {
    "op": "and",
    "conditions": [
      {"column": "company_id", "type": "in", "value": [7576, 680992]},
      {"column": "date_updated", "type": ">", "value": "2024-01-01"}
    ]
  },
  "offset": 0,
  "count": 100,
  "tickers": [],
  "groups": [],
  "aggregations": [],
  "functions": [],
  "sorts": []
}'
```

### Gartner Reviews

Get Gartner Peer Insights review data for companies.

```bash
orth run crustdata /data_lab/gartner_reviews/Table/ -b '{
  "dataset": {"name": "gartner_reviews", "id": "gartnerreview"},
  "filters": {
    "op": "and",
    "conditions": [
      {"column": "gartner_review_overall_rating", "type": ">=", "value": "4"}
    ]
  },
  "offset": 0,
  "limit": 50,
  "tickers": [],
  "groups": [],
  "aggregations": [],
  "functions": [],
  "sorts": []
}'
```

### ProductHunt Metrics

Get ProductHunt launch data and performance metrics.

```bash
orth run crustdata /data_lab/producthunt_metrics/Table/ -b '{
  "dataset": {"name": "producthunt_metrics", "id": "producthuntmetric"},
  "filters": {
    "op": "and",
    "conditions": [
      {"column": "company_id", "type": "in", "value": [680992, 673947]}
    ]
  },
  "offset": 0,
  "limit": 50,
  "tickers": [],
  "groups": [],
  "aggregations": [],
  "functions": [],
  "sorts": []
}'
```

## Common Workflows

### Find decision makers at fast-growing startups

```bash
# 1. Find companies
orth run crustdata /screener/companydb/search -b '{
  "filters": {"op": "and", "conditions": [
    {"filter_type": "employee_metrics.growth_12m_percent", "type": ">=", "value": 50},
    {"filter_type": "last_funding_round_type", "type": "in", "value": ["series_a", "series_b"]},
    {"filter_type": "hq_country", "type": "=", "value": "United States"}
  ]},
  "limit": 20
}'

# 2. Find CTOs/VPs at those companies
orth run crustdata /screener/persondb/search -b '{
  "filters": {"op": "and", "conditions": [
    {"column": "current_employers.company_name", "type": "(.)", "value": "CompanyName"},
    {"column": "current_employers.seniority_level", "type": "in", "value": ["CXO", "VP"]}
  ]},
  "limit": 20
}'

# 3. Enrich the people for contact info
orth run crustdata /screener/person/enrich -q 'linkedin_profile_url=URL&fields=name,title,email,current_employers'
```

### Research a company before a meeting

```bash
# Full company enrichment
orth run crustdata /screener/company -q 'company_domain=target.com'

# Recent LinkedIn activity
orth run crustdata /screener/linkedin_posts -q 'company_domain=target.com&page=1'

# Current job openings (hiring signals)
# First identify the company
orth run crustdata /screener/identify/ -b '{"query_company_website": "target.com"}'
# Then get listings using the company_id
orth run crustdata /data_lab/job_listings/Table/ -b '{
  "dataset": {"name": "job_listings", "id": "joblisting"},
  "filters": {"op": "and", "conditions": [{"column": "company_id", "type": "in", "value": [COMPANY_ID]}]},
  "offset": 0, "count": 50, "tickers": [], "groups": [], "aggregations": [], "functions": [], "sorts": []
}'
```

### Monitor industry trends via LinkedIn

```bash
orth run crustdata /screener/linkedin_posts/keyword_search/ -b '{
  "keyword": "AI infrastructure",
  "sort_by": "date_posted",
  "date_posted": "past-week",
  "limit": 20,
  "filters": [{"filter_type": "AUTHOR_TITLE", "type": "in", "value": ["CEO", "CTO", "VP Engineering"]}]
}'
```

## Pricing

| Endpoint | Base Price | Dynamic |
|----------|-----------|---------|
| Company Search (In-DB) | $0.22 | Scales with limit: $0.22 per 100 records |
| People Search (In-DB) | $0.66 | Scales with limit: $0.66 per 100 records |
| Company Identification | $0.22 | Fixed |
| Company Enrichment | $0.22 | $1.10 if enrich_realtime=true |
| Person Enrichment | $0.66 | $1.10 if enrich_realtime=true |
| LinkedIn Posts | $0.22 | $1.10 if requesting reactors/comments |
| LinkedIn Post by Keyword | $0.22 | $1.10 if requesting reactors/comments |
| Job Listings | $0.22 | Fixed |
| Gartner Reviews | $0.22 | Fixed |
| ProductHunt Metrics | $0.22 | Fixed |

## Tips

- **Get company_id first:** Job Listings, Gartner, and ProductHunt endpoints filter by `company_id`. Use Company Identification (`/screener/identify/`) to get IDs from domains or names.
- **Use fields parameter:** Company and Person Enrichment return huge payloads by default. Specify `fields` to get only what you need.
- **Fuzzy matching:** Use the `(.)` operator in In-DB searches for flexible text matching (e.g., "tech" matches "technology", "tech startup", etc.).
- **Cursor pagination:** In-DB search endpoints use cursor-based pagination. Pass `next_cursor` from the response as `cursor` in the next request.
- **Dataset endpoints require boilerplate:** Job Listings, Gartner, and ProductHunt need `dataset`, `tickers`, `groups`, `aggregations`, `functions` fields. Copy from examples above.
- **LinkedIn Posts:** Use `page` OR `limit`, never both. For posts with engagement data (reactors/comments), set `max_reactors` and/or `max_comments`.

## Error Handling

- **400** — Invalid filter or missing required field. Check filter_type/column names and operator compatibility.
- **401** — Invalid API key.
- **402** — Insufficient Crustdata credits.
- **404** — Endpoint not found or deprecated.
- **500** — Server-side error (retry, or try different filter values).
