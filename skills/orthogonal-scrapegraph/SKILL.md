---
name: scrapegraph
description: AI-powered web scraping - extract data using natural language prompts
---

# ScrapeGraph AI - Intelligent Web Scraping

Extract web content using AI with natural language prompts.

## Capabilities

- **Extract**: Extract content from a webpage using AI by providing a natural language prompt and a URL
- **Search**: Run an AI-powered web search request (returns results directly)
- **Scrape**: Convert web pages to markdown or raw HTML with JavaScript rendering support
- **Crawl**: Start a new web crawl request with AI extraction or markdown conversion
- **Get Crawl Status**: Get the status of a previous crawl request (free)
- **Get Crawl Pages**: Retrieve the extracted pages of a completed crawl request (free)

## Usage

### Extract
Extract content from a webpage using AI by providing a natural language prompt and a URL.

Parameters:
- prompt* (string) - Natural language description of what information you want to extract from the webpage.
- url* (string) - The URL of the webpage you want to extract information from.
- schema (object) - Optional schema to structure the output. If provided, the AI will attempt to format the results according to this schema.
- fetchConfig (object) - Optional fetch configuration. Supports `stealth` (boolean) to bypass bot protection, `mode: "js"` for enhanced JavaScript rendering on heavy JS websites (React, Vue, Angular, SPAs), and `scrolls` (number) for infinite-scroll pages.

```bash
orth api run scrapegraph /api/extract --body '{
  "url": "https://example.com/products",
  "prompt": "Extract all product names and prices"
}'
```

### Search
Run an AI-powered web search request. v2 search returns results directly — no polling needed.

Parameters:
- query* (string) - The search query or question you want to ask. This should be a clear and specific prompt that will guide the AI in finding relevant information. Example: “What is the latest version of Python and what are its main features?”
- prompt (string) - Optional extraction instruction applied to the search results, when distinct from the search string.
- schema (object) - Optional schema to structure the output. If provided, the AI will attempt to format the results according to this schema. Example: {   "properties": {     "version": {"type": "string"},     "release_date": {"type": "string"},     "major_features": {"type": "array", "items": {"type": "string"}}   },   "required": ["version", "release_date", "major_features"] }
- fetchConfig (object) - Optional fetch configuration. Supports `stealth` (boolean) to use advanced anti-detection techniques and bypass bot protection.

```bash
orth api run scrapegraph /api/search --body '{"query": "Find the latest iPhone prices from major retailers"}'
```

### Scrape
Convert web pages to markdown (or raw HTML) with JavaScript rendering support.

Parameters:
- url* (string) - The URL of the webpage to scrape. Example: "https://example.com"
- formats* (array) - Output formats to return, e.g. `[{"type": "markdown"}]` or `[{"type": "html"}]`.
- fetchConfig (object) - Optional fetch configuration. Supports `stealth` (boolean) for anti-bot protection and `mode: "js"` for heavy JavaScript rendering.

```bash
orth api run scrapegraph /api/scrape --body '{"url": "https://example.com", "formats": [{"type": "markdown"}]}'
```

### Crawl
Start a new web crawl request with AI extraction or markdown conversion.

Parameters:
- url* (string)
- formats (array) - e.g. `[{"type": "json", "prompt": "<extraction prompt>"}]` for AI extraction, or `[{"type": "markdown"}]` for markdown conversion.
- maxPages (number)
- depth (number)
- same_domain_only (boolean)
- schema (object)
- fetchConfig (object) - Supports `stealth` and `mode: "js"`.

```bash
orth api run scrapegraph /api/crawl --body '{
  "url": "https://docs.example.com",
  "formats": [{"type": "json", "prompt": "Extract all API endpoints and their descriptions"}]
}'
```

### Get Crawl Status (free)
Get the status of a previous crawl request.

```bash
orth api run scrapegraph /api/crawl/{id}
```

### Get Crawl Pages (free)
Retrieve the extracted pages of a completed crawl request.

```bash
orth api run scrapegraph /api/crawl/{id}/pages
```

## Use Cases

1. **Data Extraction**: Extract structured data without writing selectors
2. **Research**: Gather information from multiple sources
3. **Price Monitoring**: Track prices across e-commerce sites
4. **Content Conversion**: Convert web pages to markdown for LLMs
5. **Site Analysis**: Map site structure and content

## Discover More

For full endpoint details and parameters:

```bash
orth api show scrapegraph              # List all endpoints
orth api show scrapegraph /api/extract   # Get endpoint details
```
