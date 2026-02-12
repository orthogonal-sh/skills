---
name: parallel
description: Web research API with OpenAI-compatible chat completions and async tasks
---

# Parallel - Web Research API

Web research API that returns OpenAI ChatCompletions-compatible responses.

## Capabilities

- **Chat Completions**: Web research with OpenAI-compatible format ($0.01)
- **Task Runs**: Async research tasks ($0.01)
- **Beta Search**: Advanced web search ($0.01)

## Usage

### Chat Completions ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/parallel/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "parallel",
    "messages": [
      {"role": "user", "content": "What are the latest developments in quantum computing?"}
    ]
  }'
```

### Start Task Run ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/parallel/v1/tasks/runs" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "task": "Research the competitive landscape of AI coding assistants",
    "depth": "comprehensive"
  }'
```

### Beta Search ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/parallel/v1beta/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -H "parallel-beta: true" \
  -d '{"query": "AI agent frameworks comparison 2024"}'
```

## CLI Usage

```bash
# Research via chat completion
orth api run parallel /chat/completions --body '{
  "model": "parallel",
  "messages": [{"role": "user", "content": "Compare GPT-4 vs Claude 3"}]
}'

# Start async research task
orth api run parallel /v1/tasks/runs --body '{"task": "Find all YC W24 AI startups"}'
```

## Use Cases

1. **Research Automation**: Get comprehensive research on any topic
2. **OpenAI Drop-in**: Use with existing OpenAI SDK code
3. **Competitive Analysis**: Research competitors and market
4. **Due Diligence**: Gather information for investment decisions
