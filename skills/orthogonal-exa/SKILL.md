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
## Usage

### Neural Search ($0.01)
```bash
orth api run exa /search --body '{
  "query": "startups building AI coding assistants",
  "num_results": 10,
  "contents": {
    "text": true
  }
}'
```

### Find Similar Pages ($0.01)
```bash
orth api run exa /findSimilar --body '{
  "url": "https://example.com/article",
  "num_results": 10
}'
```

### Get Page Contents ($0.01)
```bash
orth api run exa /contents --body '{
  "ids": ["url1", "url2"],
  "text": true,
  "summary": true
}'
```

### Get LLM Answer ($0.01)
```bash
orth api run exa /answer --body '{"query": "What are the best practices for prompt engineering?"}'
```

## Use Cases

1. **Competitive Research**: Find companies similar to competitors
2. **Content Discovery**: Find related articles and resources
3. **Market Research**: Discover companies in specific niches
4. **Fact-Finding**: Get sourced answers to questions
5. **Deep Research**: Comprehensive research on complex topics
