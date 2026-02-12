---
name: linkup
description: Web search and content fetching - search the web or extract content from URLs
---

# Linkup - Web Search & Fetch API

Search the web and fetch content from any URL.

## Capabilities

- **Search**: Retrieve web content via search queries ($0.01)
- **Fetch**: Extract content from a specific URL ($0.01)

## Usage

### Search the Web ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/linkup/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "latest AI developments 2024",
    "depth": "standard"
  }'
```

### Fetch URL Content ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com/article"}'
```

## CLI Usage

```bash
# Search the web
orth api run linkup /search --body '{"query": "best programming languages 2024"}'

# Fetch content from URL
orth api run linkup /fetch --body '{"url": "https://news.ycombinator.com"}'
```

## Use Cases

1. **Research**: Search for information on any topic
2. **Content Aggregation**: Fetch and process web content
3. **Fact Checking**: Verify information from multiple sources
4. **News Monitoring**: Track news on specific topics
