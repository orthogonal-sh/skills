---
name: scrapegraph
description: AI-powered web scraping - extract data using natural language prompts
---

# ScrapeGraph AI - Intelligent Web Scraping

Extract web content using AI with natural language prompts.

## Capabilities

- **SmartScraper**: AI extraction with natural language ($0.04)
- **SearchScraper**: AI-powered web search ($0.12)
- **Crawl**: Crawl websites with AI extraction ($0.04)
- **Markdownify**: Convert pages to markdown ($0.03)
- **Sitemap**: Extract all URLs from a site ($0.01)
- **Raw Scrape**: Get raw HTML content ($0.03)

## Usage

### SmartScraper - AI Extraction ($0.04)
```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/products",
  "user_prompt": "Extract all product names and prices"
}'
```

### Check SmartScraper Status (free)
```bash
orth api run scrapegraph /v1/smartscraper/{request_id}
```

### SearchScraper - AI Web Search ($0.12)
```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find the latest iPhone prices from major retailers"
}'
```

### Crawl with AI ($0.04)
```bash
orth api run scrapegraph /v1/crawl --body '{
  "url": "https://docs.example.com",
  "prompt": "Extract all API endpoints and their descriptions"
}'
```

### Convert to Markdown ($0.03)
```bash
orth api run scrapegraph /v1/markdownify --body '{"website_url": "https://example.com/article"}'
```

### Get Sitemap ($0.01)
```bash
orth api run scrapegraph /v1/sitemap --body '{"website_url": "https://example.com"}'
```

### Raw HTML Scrape ($0.03)
```bash
orth api run scrapegraph /v1/scrape --body '{"website_url": "https://example.com"}'
```

## Use Cases

1. **Data Extraction**: Extract structured data without writing selectors
2. **Research**: Gather information from multiple sources
3. **Price Monitoring**: Track prices across e-commerce sites
4. **Content Conversion**: Convert web pages to markdown for LLMs
5. **Site Analysis**: Map site structure and content
