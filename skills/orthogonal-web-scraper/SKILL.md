---
name: web-scraper
description: Scrape any website - extract structured data, crawl pages, convert to markdown
---

# Web Scraper - Extract Data from Any Website

Scrape websites, extract structured data, and convert content to usable formats.

## Workflow

### Step 1: Simple Page Scrape
Extract content from a single page:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/scrapes" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com/page"}'
```

### Step 2: AI-Powered Extraction
Extract specific data using natural language:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://example.com/products",
    "user_prompt": "Extract all product names, prices, descriptions, and image URLs"
  }'
```

### Step 3: Structured Extraction
Define a schema for consistent output:

```bash
curl -X POST "https://api.orth.sh/v1/run/riveter/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com/products",
    "schema": {
      "products": [{
        "name": "string",
        "price": "number",
        "description": "string",
        "url": "string"
      }]
    }
  }'
```

### Step 4: Crawl Entire Site
Crawl multiple pages:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/crawls" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://docs.example.com",
    "max_pages": 50
  }'
```

### Step 5: Convert to Markdown
Get clean markdown output:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/markdownify" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"website_url": "https://example.com/article"}'
```

### Step 6: Get Site Map
Discover all URLs on a site:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/map" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```

## Example Usage

```bash
# Scrape product listings
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://amazon.com/s?k=laptop",
  "user_prompt": "Extract product names, prices, ratings, and number of reviews"
}'

# Get all URLs from a site
orth api run olostep /v1/maps --body '{"url": "https://docs.stripe.com"}'

# Convert docs to markdown
orth api run scrapegraph /v1/markdownify --body '{"website_url": "https://docs.openai.com/api"}'
```

## Tips

- Use AI extraction for complex pages
- Define schemas for consistent data
- Respect rate limits and robots.txt
- Cache results to avoid duplicate requests
