---
name: tavily
description: AI-powered web search, crawling, extraction, and deep research
---

# Tavily - AI Search & Research API

Comprehensive web search, crawling, content extraction, and deep research.

## Capabilities

- **Search**: Execute search queries with AI ranking ($0.02)
- **Research**: Deep multi-query research on topics ($0.50)
- **Extract**: Extract content from URLs ($0.01)
- **Crawl**: Graph-based website crawling ($0.01)
- **Map**: Explore website structure ($0.01)

## Usage

### Search ($0.02)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "latest developments in AI agents",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Deep Research ($0.50)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/research" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Compare different AI agent frameworks for production use",
    "max_results": 20
  }'
```

### Check Research Status (free)
```bash
curl "https://api.orth.sh/v1/run/tavily/research/{request_id}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Extract Content ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/extract" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://example.com/article1", "https://example.com/article2"]
  }'
```

### Crawl Website ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/crawl" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://docs.example.com",
    "max_depth": 3
  }'
```

### Map Website ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/map" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```

## CLI Usage

```bash
# Quick search
orth api run tavily /search --body '{"query": "best practices for RAG systems", "include_answer": true}'

# Deep research
orth api run tavily /research --body '{"query": "AI startup funding trends 2024"}'

# Extract from multiple URLs
orth api run tavily /extract --body '{"urls": ["https://news.ycombinator.com"]}'
```

## Use Cases

1. **Research**: Comprehensive research on any topic
2. **Content Aggregation**: Extract and process web content
3. **Market Intelligence**: Track industry trends
4. **Documentation**: Crawl and index documentation sites
5. **Fact-Finding**: Get accurate, sourced answers
