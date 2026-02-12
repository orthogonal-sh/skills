---
name: andi
description: Fast, high-quality web search with intelligent ranking and instant answers
---

# Andi Search - Intelligent Web Search

Fast, high-quality search with intelligent ranking, instant answers, and research-grade results.

## Capabilities

- **Search**: High-quality web search with AI-powered ranking ($0.01)

## Usage

### Web Search ($0.01)
```bash
curl "https://api.orth.sh/v1/run/andi/v1/search?query=how%20does%20RAG%20work" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Search with Options
```bash
curl "https://api.orth.sh/v1/run/andi/v1/search?query=best%20programming%20languages%202024&limit=10" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Simple search
orth api run andi /v1/search --query 'query=latest%20AI%20news'

# Search for technical content
orth api run andi /v1/search --query 'query=kubernetes%20best%20practices'
```

## Use Cases

1. **Research**: Find high-quality sources on any topic
2. **Fact-Finding**: Get accurate answers with sources
3. **Technical Lookup**: Find documentation and guides
4. **News Monitoring**: Track current events
5. **Competitive Intelligence**: Research companies and products
