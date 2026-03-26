---
name: scrapegraph-search
description: AI-powered web search - find and extract structured data from multiple sources using natural language
metadata:
  tags: search, scraping, ai, research, web
---

# ScrapeGraph SearchScraper

Search the web and extract structured data from multiple sources using AI. Combines web search with intelligent extraction in a single call.

## When to Use

- User wants to research a topic and get structured results
- User asks "find information about [topic]"
- User needs data aggregated from multiple web sources
- User wants to search and extract in one step (no need to find URLs first)

## Usage

### Basic Search

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find the latest AI research papers published this week"
}'
```

### Search with AI Extraction

Get AI-structured results (10 credits/page):

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find the top 5 CRM tools for startups with pricing",
  "num_results": 5,
  "extraction_mode": true
}'
```

### Search in Markdown Mode

Get raw markdown content at lower cost (2 credits/page):

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Latest developments in quantum computing",
  "num_results": 3,
  "extraction_mode": false
}'
```

### Search with Schema

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find SaaS companies that raised Series A in 2025",
  "num_results": 10,
  "extraction_mode": true,
  "output_schema": {
    "type": "object",
    "properties": {
      "companies": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "funding_amount": {"type": "string"},
            "description": {"type": "string"},
            "website": {"type": "string"}
          }
        }
      }
    }
  }
}'
```

### Geo-Targeted Search

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Best Italian restaurants in Berlin",
  "num_results": 5,
  "location_geo_code": "de"
}'
```

### Time-Filtered Search

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "OpenAI announcements",
  "num_results": 5,
  "time_range": "past_week"
}'
```

## Parameters

- **user_prompt** (required) - Natural language description of what to search for
- **num_results** - Number of results to return (3-20, default: 3)
- **extraction_mode** - `true` for AI-structured extraction (10 credits/page), `false` for markdown (2 credits/page)
- **output_schema** - JSON schema for structured results (only with `extraction_mode: true`)
- **location_geo_code** - Country code for geo-targeted results (us, gb, de, fr, etc.)
- **time_range** - Filter by recency: `past_hour`, `past_24_hours`, `past_week`, `past_month`, `past_year`

## Response

**AI extraction mode** (`extraction_mode: true`):
```json
{
  "request_id": "sg-req-xxx",
  "status": "completed",
  "result": { "extracted": "structured data" },
  "reference_urls": ["https://source1.com", "https://source2.com"],
  "error": ""
}
```

**Markdown mode** (`extraction_mode: false`):
```json
{
  "request_id": "sg-req-xxx",
  "status": "completed",
  "markdown_content": "# Results\n\n...",
  "reference_urls": ["https://source1.com", "https://source2.com"],
  "error": ""
}
```

## Examples

**User:** "Research competitors of Notion"
```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find the top 10 Notion competitors with their key features and pricing",
  "num_results": 10,
  "extraction_mode": true
}'
```

**User:** "What happened in tech news today?"
```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Major tech news and announcements",
  "num_results": 5,
  "time_range": "past_24_hours",
  "extraction_mode": false
}'
```

**User:** "Find Python web frameworks and compare them"
```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Compare the most popular Python web frameworks",
  "num_results": 5,
  "extraction_mode": true,
  "output_schema": {
    "type": "object",
    "properties": {
      "frameworks": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "github_stars": {"type": "string"},
            "pros": {"type": "array", "items": {"type": "string"}},
            "cons": {"type": "array", "items": {"type": "string"}},
            "best_for": {"type": "string"}
          }
        }
      }
    }
  }
}'
```

## Credits

- **5 credits** base per request
- **+10 credits/page** with AI extraction mode
- **+2 credits/page** with markdown mode
- Failed requests are not charged

## Error Handling

- **400** - Invalid parameters or schema
- **401** - Invalid API key
- **402** - Insufficient credits
- **429** - Rate limit exceeded — wait and retry
- **500** - Server error — retry with backoff

## Discover More

```bash
orth api show scrapegraph                      # List all endpoints
orth api show scrapegraph /v1/searchscraper    # Get endpoint details
```
