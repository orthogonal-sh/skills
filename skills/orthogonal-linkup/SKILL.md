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
orth api run linkup /search --body '{
  "query": "latest AI developments 2024",
  "depth": "standard"
}'
```

### Fetch URL Content ($0.01)
```bash
orth api run linkup /fetch --body '{"url": "https://example.com/article"}'
```

## Use Cases

1. **Research**: Search for information on any topic
2. **Content Aggregation**: Fetch and process web content
3. **Fact Checking**: Verify information from multiple sources
4. **News Monitoring**: Track news on specific topics
