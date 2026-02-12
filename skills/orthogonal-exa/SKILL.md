---
name: exa
description: Neural web search - find similar content, extract pages, and run deep research
---

# Exa - Neural Web Search & Research

Neural search engine for finding similar content, extracting pages, and deep research.

## Capabilities

- **Search**: Neural search with content extraction ($0.01)
- **Find Similar**: Find pages similar to a URL ($0.01)
- **Contents**: Extract full page contents ($0.01)
- **Answer**: LLM answers backed by search ($0.01)
- **Research**: Async deep research tasks ($0.01)

## Usage

### Neural Search ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/exa/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "startups building AI coding assistants",
    "num_results": 10,
    "contents": {
      "text": true
    }
  }'
```

### Find Similar Pages ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/exa/findSimilar" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com/article",
    "num_results": 10
  }'
```

### Get Page Contents ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/exa/contents" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "ids": ["url1", "url2"],
    "text": true,
    "summary": true
  }'
```

### Get LLM Answer ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/exa/answer" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "What are the best practices for prompt engineering?"}'
```

### Start Research Task ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/exa/research/v1" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "Comprehensive analysis of AI agent frameworks"}'
```

### Check Research Status ($0.01)
```bash
curl "https://api.orth.sh/v1/run/exa/research/v1/{researchId}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Neural search
orth api run exa /search --body '{"query": "YC companies building developer tools", "num_results": 10}'

# Find similar pages
orth api run exa /findSimilar --body '{"url": "https://openai.com/blog/gpt-4", "num_results": 5}'

# Get answer with sources
orth api run exa /answer --body '{"query": "How does vector search work?"}'
```

## Use Cases

1. **Competitive Research**: Find companies similar to competitors
2. **Content Discovery**: Find related articles and resources
3. **Market Research**: Discover companies in specific niches
4. **Fact-Finding**: Get sourced answers to questions
5. **Deep Research**: Comprehensive research on complex topics
