---
name: firecrawl
description: Crawl and scrape websites with AI-powered extraction
---

# Firecrawl Web Crawler

Crawl entire websites and extract structured data using Firecrawl's API.

## When to Use

- User needs to crawl an entire website (not just one page)
- User wants structured data extraction from web pages
- User needs to scrape multiple pages with consistent format
- User asks to index or map a website

## How It Works

Uses the Firecrawl API for intelligent web crawling with automatic JavaScript rendering, content extraction, and structured output.

## Source

Based on [firecrawl/cli](https://skills.sh/firecrawl/cli/firecrawl) (3.8K+ installs)

## Usage

```bash
orth run firecrawl /v1/scrape -d '{"url": "https://example.com"}'
```

## Key Features

- Full website crawling with depth control
- JavaScript rendering
- Markdown and structured data output
- Sitemap generation
- Rate limiting and politeness controls
