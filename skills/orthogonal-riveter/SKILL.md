---
name: riveter
description: Web scraping with structured data extraction - define your output schema
---

# Riveter - Structured Web Scraping

Scrape web pages and extract data into your defined structure.

## Capabilities

- **Scrape**: Extract text content from web pages ($0.01)
- **Structured Run**: Define output schema and extract structured data ($0.01)
- **Status Tracking**: Monitor long-running extraction jobs (free)
- **Stop Jobs**: Cancel running extraction jobs (free)

## Usage

### Simple Scrape ($0.01)
```bash
orth api run riveter /v1/scrape --body '{"url": "https://example.com/article"}'
```

### Structured Extraction ($0.01)
```bash
orth api run riveter /v1/run --body '{
  "url": "https://example.com/products",
  "schema": {
    "products": [{
      "name": "string",
      "price": "number",
      "description": "string"
    }]
  }
}'
```

### Check Run Status (free)
```bash
orth api run riveter /v1/run_status --query 'run_id=abc123'
```

### Get Run Data (free)
```bash
orth api run riveter /v1/run_data --query 'run_id=abc123'
```

### Stop a Run (free)
```bash
orth api run riveter /v1/stop_run --body '{"run_id": "abc123"}'
```

## Use Cases

1. **E-commerce Scraping**: Extract product data in consistent format
2. **Job Listings**: Gather job postings with structured fields
3. **News Aggregation**: Extract articles with title, date, content
4. **Price Monitoring**: Track prices across competitor sites
