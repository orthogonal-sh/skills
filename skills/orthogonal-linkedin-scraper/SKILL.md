---
name: linkedin-scraper
description: Get LinkedIn profiles, company pages, posts, and employee data
---

# LinkedIn Scraper

Scrape public LinkedIn data including profiles, company pages, posts, and employee searches.

## When to Use

- User asks about someone's LinkedIn profile
- User wants company information from LinkedIn
- User asks "who works at [company]?"
- Research on a professional or company
- Finding employee lists

## How It Works

Uses the Shofo API to scrape LinkedIn data.

## Usage

### Get User Profile

```bash
orth run shofo /linkedin/user-profile -q 'username=satyanadella'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"shofo","path":"/linkedin/user-profile","query":{"username":"satyanadella"}}'
```
</details>

### Get Company Profile

```bash
orth run shofo /linkedin/company-profile -q 'company=anthropic'
```

### Get User's Posts

```bash
orth run shofo /linkedin/user-posts -q 'username=satyanadella'
```

### Get Company Posts

```bash
orth run shofo /linkedin/company-posts -q 'company=openai'
```

### Search Company Employees

```bash
orth run shofo /linkedin/search-employees -q 'company=anthropic'
```

## Parameters

### User Operations
- **username** (required) - LinkedIn username (from profile URL)

### Company Operations
- **company** (required) - Company name or LinkedIn company slug

## Response

### User Profile includes:
- Name, headline, location
- Current position
- Education history
- Skills
- Connection count
- Profile URL

### Company Profile includes:
- Company name and description
- Industry and size
- Headquarters location
- Founded date
- Employee count
- Specialties

## Examples

**User:** "Look up Satya Nadella on LinkedIn"
```bash
orth run shofo /linkedin/user-profile -q 'username=satyanadella'
```

**User:** "Tell me about Anthropic's LinkedIn page"
```bash
orth run shofo /linkedin/company-profile -q 'company=anthropic'
```

**User:** "Who works at OpenAI?"
```bash
orth run shofo /linkedin/search-employees -q 'company=openai'
```

## Tips

- Use LinkedIn username from the profile URL (linkedin.com/in/USERNAME)
- For companies, use the company name or slug
- Some profiles may have restricted visibility
