---
name: olostep
description: Web scraping, crawling, and AI-powered answer extraction at scale
---

# Olostep - Web Scraping & Crawling API

Powerful web scraping, crawling, and AI-powered content extraction.

## Capabilities

- **Scrape Pages**: Extract content from individual URLs ($0.01)
- **Batch Processing**: Process multiple URLs in parallel ($0.01)
- **Web Crawling**: Crawl entire websites ($0.05)
- **AI Answers**: Get AI-powered answers from web research ($0.05)
- **Site Maps**: Extract all URLs from a website ($0.01)

## Usage

### Scrape a Page ($0.01)
```bash
orth api run olostep /v1/scrapes --body '{"url": "https://example.com/page"}'
```

### Check Scrape Status
```bash
orth api run olostep /v1/scrapes/{scrape_id}
```

### Start a Crawl ($0.05)
```bash
orth api run olostep /v1/crawls --body '{
  "url": "https://example.com",
  "max_pages": 100
}'
```

### Batch Scrape ($0.01)
```bash
orth api run olostep /v1/batches --body '{
  "urls": [
    "https://example.com/page1",
    "https://example.com/page2"
  ]
}'
```

### AI Answer ($0.05)
```bash
orth api run olostep /v1/answers --body '{"question": "What are the latest AI developments?"}'
```

### Get Site Map ($0.01)
```bash
orth api run olostep /v1/maps --body '{"url": "https://example.com"}'
```

## Use Cases

1. **Data Collection**: Gather data from websites at scale
2. **Content Monitoring**: Track changes on competitor sites
3. **Research Automation**: Get AI-synthesized answers from web sources
4. **SEO Analysis**: Crawl and analyze site structure
