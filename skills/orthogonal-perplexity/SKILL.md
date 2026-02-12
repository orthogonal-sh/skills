---
name: perplexity
description: Perplexity AI search and chat completions with real-time web data
---

# Perplexity - AI Search & Chat

AI-powered search and chat completions with real-time web data.

## Capabilities

- **Search**: Ranked search with real-time index ($0.01)
- **Chat Completions**: AI responses with web grounding ($0.01)
- **Async Chat**: Background chat completion jobs ($0.01)

## Usage

### Search ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "latest AI developments February 2024"}'
```

### Chat Completion ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [
      {"role": "user", "content": "What are the latest developments in AI agents?"}
    ]
  }'
```

### Async Chat Completion ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/async/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [
      {"role": "user", "content": "Write a comprehensive analysis of vector databases"}
    ]
  }'
```

### Check Async Status ($0.01)
```bash
curl "https://api.orth.sh/v1/run/perplexity/async/chat/completions/{request_id}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### List Async Jobs ($0.01)
```bash
curl "https://api.orth.sh/v1/run/perplexity/async/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Quick search
orth api run perplexity /search --body '{"query": "best practices for RAG"}'

# Chat with web grounding
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Explain quantum computing recent breakthroughs"}]
}'
```

## Use Cases

1. **Research**: Get AI-synthesized answers with sources
2. **Current Events**: Access real-time information
3. **Technical Questions**: Get accurate technical answers
4. **Fact-Checking**: Verify information with web sources
5. **Content Creation**: Generate content grounded in facts
