---
name: seo-analyzer
description: Analyze website SEO - keywords, content, competitors, and improvement opportunities
---

# SEO Analyzer - Website SEO Analysis

Analyze websites for SEO performance, keywords, content quality, and competitor positioning.

## Workflow

### Step 1: Crawl Site Structure
Map the website structure:

```bash
orth api run tavily /map --body '{"url": "https://example.com"}'
```

### Step 2: Extract Page Content
Get content for analysis:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com",
  "user_prompt": "Extract page title, meta description, headings (H1, H2, H3), main content, and internal links"
}'
```

### Step 3: Get Backlink Ideas
Find linking opportunities:

```bash
orth api run exa /search --body '{
  "query": "blogs and websites that accept guest posts about productivity software",
  "num_results": 20
}'
```

## Example Usage

```bash
# Quick site analysis
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://mysite.com",
  "user_prompt": "Analyze this page for SEO: title tag, meta description, heading structure, keyword usage, content length"
}'
```

## Tips

- Focus on long-tail keywords for faster wins
- Analyze top 3 competitors for each target keyword
- Prioritize pages with existing traffic for optimization
- Track rankings over time to measure progress

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show exa
orth api show scrapegraph
orth api show tavily
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
