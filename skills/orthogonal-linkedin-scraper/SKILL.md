---
name: linkedin-scraper
description: Get LinkedIn profiles, company pages, and posts
---

# LinkedIn Scraper

Scrape public LinkedIn data including profiles, company pages, and posts.

## When to Use

- User asks about someone's LinkedIn profile
- User wants company information from LinkedIn
- Research on a professional or company

## How It Works

Uses the Scrape Creators API via Orthogonal to scrape LinkedIn data.

**Note:** Scrape Creators LinkedIn endpoints use full LinkedIn URLs as the query parameter (not usernames).

## Usage

### Get User Profile

```bash
orth run scrapecreators /v1/linkedin/profile -q 'url=https://linkedin.com/in/satyanadella'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"scrapecreators","path":"/v1/linkedin/profile","query":{"url":"https://linkedin.com/in/satyanadella"}}'
```
</details>

### Get Company Page

```bash
orth run scrapecreators /v1/linkedin/company -q 'url=https://linkedin.com/company/anthropic'
```

### Get Specific Post

```bash
orth run scrapecreators /v1/linkedin/post -q 'url=https://linkedin.com/posts/somepost'
```

## Parameters

### User Profile
- **url** (required) - LinkedIn profile URL (e.g., `https://linkedin.com/in/username`)

### Company Page
- **url** (required) - LinkedIn company page URL (e.g., `https://linkedin.com/company/name`)

### Post
- **url** (required) - LinkedIn post URL

## Response

### User Profile includes:
- Name, headline, location
- Current position
- Education history
- Skills
- Connection count
- Profile URL

### Company Page includes:
- Company name and description
- Industry and size
- Headquarters location
- Founded date
- Employee count
- Specialties

## Examples

**User:** "Look up Satya Nadella on LinkedIn"
```bash
orth run scrapecreators /v1/linkedin/profile -q 'url=https://linkedin.com/in/satyanadella'
```

**User:** "Tell me about Anthropic's LinkedIn page"
```bash
orth run scrapecreators /v1/linkedin/company -q 'url=https://linkedin.com/company/anthropic'
```

## Error Handling

- **success: false** — the API may temporarily fail to access LinkedIn; retry after a few seconds
- Private/restricted profiles return limited or no data
- Rate limiting may apply — add short delays between sequential requests

### No Longer Available

The following were previously available via Shofo but have no direct equivalent in Scrape Creators:
- **LinkedIn Company Posts** — no direct equivalent endpoint
- **LinkedIn Search Employees** — no direct equivalent endpoint
- **LinkedIn User Posts (by username)** — use `/v1/linkedin/post` with a specific post URL instead

## Tips

- Use full LinkedIn URLs (e.g., `https://linkedin.com/in/USERNAME`)
- For companies, use the full company page URL
- Some profiles may have restricted visibility
