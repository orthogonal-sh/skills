---
name: jina-s
description: Jina Search - fast web search returning SERP results
---

# Jina Search - Web Search API

Simple, fast web search using Jina's search foundation.

## Capabilities

- **Search**: Get search engine results pages (SERP) ($0.01)

## Usage

### Web Search ($0.01)
```bash
curl "https://api.orth.sh/v1/run/jina-s/?q=latest%20AI%20news" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Search with Options
```bash
curl "https://api.orth.sh/v1/run/jina-s/?q=machine%20learning%20tutorials&num=10" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Simple search
orth api run jina-s / --query 'q=best%20programming%20languages'

# Technical search
orth api run jina-s / --query 'q=kubernetes%20deployment%20guide'
```

## Use Cases

1. **Quick Research**: Fast search for any topic
2. **Information Gathering**: Get relevant web results
3. **Fact Checking**: Find sources for verification
4. **Technical Lookup**: Search documentation and guides
