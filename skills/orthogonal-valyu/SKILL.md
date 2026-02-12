---
name: valyu
description: Web search, AI answers, content extraction, and async deep research
---

# Valyu - Search, Answer & Deep Research

Search the web, get AI answers, extract content, and run deep research tasks.

## Capabilities

- **Search**: Search web and proprietary data ($0.01)
- **Answer**: AI-generated answers from search ($0.01)
- **Contents**: Extract content from URLs ($0.01)
- **Deep Research**: Async comprehensive research ($0.01)
- **Batch Research**: Run multiple research tasks ($0.01)

## Usage

### Search ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/valyu/v1/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "AI agent frameworks comparison"}'
```

### Get AI Answer ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/valyu/v1/answer" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "What are the best practices for building AI agents?"}'
```

### Extract Content ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/valyu/v1/contents" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"urls": ["https://example.com/article"]}'
```

### Start Deep Research ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/valyu/v1/deepresearch/tasks" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "Comprehensive analysis of vector databases market"}'
```

### Check Research Status ($0.01)
```bash
curl "https://api.orth.sh/v1/run/valyu/v1/deepresearch/tasks/{id}/status" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Create Research Batch ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/valyu/v1/deepresearch/batches" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": "Competitor Research"}'
```

## CLI Usage

```bash
# Quick search
orth api run valyu /v1/search --body '{"query": "latest LLM developments"}'

# Get AI answer
orth api run valyu /v1/answer --body '{"query": "How does RAG work?"}'

# Start deep research
orth api run valyu /v1/deepresearch/tasks --body '{"query": "AI startup landscape 2024"}'
```

## Use Cases

1. **Research Automation**: Comprehensive research on any topic
2. **Content Intelligence**: Extract and analyze web content
3. **Market Analysis**: Research markets and competitors
4. **Due Diligence**: Gather information for decisions
5. **Knowledge Base Building**: Collect structured information
