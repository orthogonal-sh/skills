---
name: stealth-startup-finder
description: Find founders at stealth-mode startups or who recently launched from stealth
---

# Stealth Startup Finder

Find people currently building at stealth-mode companies, or who recently left stealth (launched). Useful for investor deal sourcing, competitive intelligence, and recruiting at early-stage companies.

## Workflow

### Step 1: Find In-Stealth Founders
Search for people currently at stealth companies:

```bash
orth api run fiber /v1/stealth-founders/search --body '{"stealthConfig": {"mode": "in-stealth"}, "pageSize": 25}'
```

### Step 2: Find Ex-Stealth (Recently Launched)
Find founders who recently exited stealth:

```bash
orth api run fiber /v1/stealth-founders/search --body '{"stealthConfig": {"mode": "left-stealth"}, "pageSize": 25}'
```

### Step 3: Filter by Profile Criteria
Add search filters to narrow results:

```bash
orth api run fiber /v1/stealth-founders/search --body '{
  "stealthConfig": {"mode": "in-stealth"},
  "searchParams": {
    "locations": ["San Francisco", "New York"],
    "keywords": ["AI", "machine learning"]
  },
  "pageSize": 25
}'
```

### Step 4: Enrich Interesting Profiles
Get full details on promising matches:

```bash
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/SLUG"}'
```

### Step 5: Research Their Background
Check their career history and network:

```bash
orth api run fiber /v1/natural-language-search/profiles --body '{"query": "Former engineers at [previous company] now at startups"}'
```

## Example Usage

```bash
# All currently stealth founders
orth api run fiber /v1/stealth-founders/search --body '{"stealthConfig": {"mode": "in-stealth"}, "pageSize": 10}'

# Stealth founders in AI/ML in SF
orth api run fiber /v1/stealth-founders/search --body '{
  "stealthConfig": {"mode": "in-stealth"},
  "searchParams": {
    "locations": ["San Francisco Bay Area"],
    "keywords": ["artificial intelligence", "machine learning", "LLM"]
  },
  "pageSize": 25
}'

# Recently launched companies (left stealth)
orth api run fiber /v1/stealth-founders/search --body '{
  "stealthConfig": {"mode": "left-stealth"},
  "pageSize": 25
}'
```

## Tips

- `in-stealth` finds people whose current company is stealth/unnamed
- `left-stealth` finds people who were recently at stealth companies but have since launched
- Combine with location and keyword filters to narrow large result sets
- Cost: 1 credit per profile returned
- Use pagination (`cursor`) to iterate through large result sets
- Cross-reference with investor search to find funded stealth companies

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
```

Example: `orth api show fiber /v1/stealth-founders/search` for endpoint parameters.
