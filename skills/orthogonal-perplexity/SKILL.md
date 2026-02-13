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
orth api run perplexity /search --body '{"query": "latest AI developments February 2024"}'
```

### Chat Completion ($0.01)
```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [
    {"role": "user", "content": "What are the latest developments in AI agents?"}
  ]
}'
```

### Async Chat Completion ($0.01)
```bash
orth api run perplexity /async/chat/completions --body '{
  "model": "sonar",
  "messages": [
    {"role": "user", "content": "Write a comprehensive analysis of vector databases"}
  ]
}'
```

### Check Async Status ($0.01)
```bash
orth api run perplexity /async/chat/completions/{request_id}
```

### List Async Jobs ($0.01)
```bash
orth api run perplexity /async/chat/completions
```

## Use Cases

1. **Research**: Get AI-synthesized answers with sources
2. **Current Events**: Access real-time information
3. **Technical Questions**: Get accurate technical answers
4. **Fact-Checking**: Verify information with web sources
5. **Content Creation**: Generate content grounded in facts
