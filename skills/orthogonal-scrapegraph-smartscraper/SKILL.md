---
name: scrapegraph-smartscraper
description: AI-powered web scraping - extract structured data from any webpage using natural language prompts
metadata:
  tags: scraping, extraction, ai, structured-data, web
---

# ScrapeGraph SmartScraper

Extract structured data from any webpage using AI. Describe what you want in natural language and get back clean JSON.

## When to Use

- User wants to extract specific data from a webpage
- User asks "scrape [website] for [data]"
- User needs structured data from a product page, article, directory, etc.
- User wants to turn a webpage into structured JSON

## Usage

### Basic Extraction

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com",
  "user_prompt": "Extract the main heading and description"
}'
```

### Extract with Schema

Define an output schema to get consistently shaped results:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/product",
  "user_prompt": "Extract the product details",
  "output_schema": {
    "type": "object",
    "properties": {
      "name": {"type": "string"},
      "price": {"type": "number"},
      "description": {"type": "string"},
      "rating": {"type": "number"}
    }
  }
}'
```

### Stealth Mode

For sites with bot protection (costs +4 credits):

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://protected-site.com",
  "user_prompt": "Extract all product listings",
  "stealth": true
}'
```

### With Custom Headers/Cookies

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com",
  "user_prompt": "Extract user profile data",
  "headers": {
    "Cookie": "session_id=abc123",
    "User-Agent": "Mozilla/5.0"
  }
}'
```

### Scrollable Pages

For pages that load content on scroll (e.g. infinite scroll):

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/feed",
  "user_prompt": "Extract all post titles and authors",
  "number_of_scrolls": 10
}'
```

## Parameters

- **website_url** (required*) - URL of the page to scrape
- **website_html** (required*) - Raw HTML to scrape (alternative to URL)
- **user_prompt** (required) - Natural language description of what to extract
- **output_schema** - JSON schema defining the desired response structure
- **stealth** - Enable stealth mode for bot-protected sites (+4 credits)
- **wait_ms** - Milliseconds to wait for page load (default: 3000)
- **number_of_scrolls** - Number of times to scroll the page (0-50)
- **country_code** - Country code for geo-located requests
- **headers** - Custom HTTP headers including cookies
- **plain_text** - Return plain text instead of JSON

*One of `website_url`, `website_html`, or `website_markdown` is required.

## Response

```json
{
  "request_id": "sg-req-xxx",
  "status": "completed",
  "result": { "extracted": "data" },
  "error": ""
}
```

## Examples

**User:** "Get all the team members from this company's about page"
```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/about",
  "user_prompt": "Extract all team members with their name, role, and bio"
}'
```

**User:** "Scrape this product page for pricing info"
```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/pricing",
  "user_prompt": "Extract all pricing tiers with plan name, price, and features list",
  "output_schema": {
    "type": "object",
    "properties": {
      "plans": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "price": {"type": "string"},
            "features": {"type": "array", "items": {"type": "string"}}
          }
        }
      }
    }
  }
}'
```

**User:** "Extract job listings from this careers page"
```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/careers",
  "user_prompt": "Extract all job listings with title, location, department, and application link"
}'
```

## Credits

- **1 credit** per request
- **+4 credits** with stealth mode enabled
- Failed requests are not charged

## Error Handling

- **400** - Invalid parameters or schema
- **401** - Invalid API key
- **402** - Insufficient credits
- **429** - Rate limit exceeded — wait and retry
- **500** - Server error — retry with backoff

## Discover More

```bash
orth api show scrapegraph                    # List all endpoints
orth api show scrapegraph /v1/smartscraper   # Get endpoint details
```
