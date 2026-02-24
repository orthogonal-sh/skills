---
name: team-linkedin-profiles
description: Find LinkedIn profiles of a specific team or department at a company. Use when asked to get LinkedIn profiles, find team members, or look up people in a particular team/department/group at a company.
---

# Team LinkedIn Profiles

Find everyone on a specific team/department at a company and return their LinkedIn profiles.

## Workflow

### 1. Parse the Request

Extract from the user's query:
- **Company name** (required)
- **Team/department name** (required) — e.g., fraud, engineering, sales, marketing, growth, data science
- **Filters** (optional) — seniority level, location, max results count

### 2. Resolve the Company

Use Brand.dev to disambiguate the company and get its domain, industry, and description. This is critical for companies with common names (e.g., "Mercury" the fintech vs "Mercury Financial" the credit card company).

```bash
orth run brand-dev /v1/brand/retrieve-by-name --query 'name=Mercury'
```

From the result, build a **company context string** combining the company name, domain, industry, and a short description. Example: `"Mercury fintech banking startup mercury.com"`. Use this context string in all subsequent search queries to improve precision.

If the user provides a domain directly, use `/v1/brand/retrieve` instead:
```bash
orth run brand-dev /v1/brand/retrieve --query 'domain=mercury.com'
```

### 3. Search for Team Members

Run both searches **in parallel** for maximum coverage:

**Primary — Exa people search** (best precision, returns LinkedIn URLs + structured data):
```bash
orth run exa /search --body '{
  "query": "{company context string} {team} team members",
  "category": "people",
  "numResults": 20,
  "includeDomains": ["linkedin.com"]
}'
```

Try multiple query variations if results are sparse:
- `"{company} {team} team"`
- `"{team} at {company} {industry}"`
- `"{team} analyst OR engineer OR manager at {company}"`

**Supplement — Fiber NL profile search** (broader coverage, different data source):
```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{team} team at {company} {industry context}",
  "pageSize": 20
}'
```

### 4. Filter & Deduplicate

This step is critical for accuracy:

1. **Verify current company** — For each result, confirm they currently work at the target company (not a similarly-named one). Use the domain and description from Step 2 to distinguish:
   - Example: Mercury (fintech, mercury.com) vs Mercury Financial (credit cards, mercuryfinancial.com)
   - Check the person's current employer name and domain against the Brand.dev data

2. **Verify team/department** — Check that the person's title or department matches the target team. Be flexible with title variations:
   - "Fraud" team → fraud analyst, fraud investigator, fraud ops, risk & fraud, trust & safety
   - "Engineering" team → software engineer, SWE, developer, engineering manager
   - "Sales" team → account executive, SDR, BDR, sales manager, revenue

3. **Deduplicate** — Merge results from Exa and Fiber by LinkedIn URL. Prefer Exa data when both sources have the same person (richer structured data).

4. **Flag uncertain matches** — If a person's company match is ambiguous, include them in the results but flag with a note (e.g., "Could not confirm current employer — verify manually").

### 5. Present Results

Output a clean markdown table:

```
## {Team} Team at {Company}

Found {N} members:

| Name | Title | Location | LinkedIn |
|------|-------|----------|----------|
| Jane Smith | Senior Fraud Analyst | San Francisco, CA | [Profile](https://linkedin.com/in/janesmith) |
| ... | ... | ... | ... |

**Uncertain matches** (verify manually):
| Name | Title | Note | LinkedIn |
|------|-------|------|----------|
| ... | ... | ... | ... |
```

Include a note about coverage: "These are publicly discoverable profiles. Team members with private LinkedIn profiles or no LinkedIn presence won't appear."

### 6. Optional Deep Enrichment

Only if the user requests more detail on specific people, use Fiber live-fetch per profile:

```bash
orth run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/USERNAME"}'
```

This returns full work history, education, skills, and recent activity. Run these in parallel for multiple profiles.

## Tips

- **Add industry context** to all search queries — "Mercury fintech" finds the right Mercury much more reliably than just "Mercury"
- **Expand title keywords** — Teams use varied titles. "Data team" could include data scientist, data engineer, analytics engineer, ML engineer, data analyst
- **Handle pagination** — If Exa returns exactly `numResults`, there may be more. Increase `numResults` or run follow-up queries with different title keywords
- **Rate limits** — If Exa rate-limits, lean on Fiber NL search as fallback. If both are limited, try Exa with `type: "keyword"` or different query phrasing
- **Small teams** — For niche teams (e.g., "fraud" at a 200-person startup), expect 3-8 results. This is normal
- **Large teams** — For broad teams (e.g., "engineering" at a 5,000-person company), suggest the user narrow by sub-team or seniority
- **Private profiles** won't surface in any search — mention this if results seem thin
