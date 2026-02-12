---
name: tavus
description: AI video conversations - create real-time video calls with AI personas
---

# Tavus - AI Video Conversations

Create real-time video conversations with AI-powered digital personas.

## Capabilities

- **List Personas**: Get available AI personas ($0.01)
- **Start Conversation**: Begin a real-time video call with AI ($0.02)

## Usage

### List Available Personas ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tavus/v2/personas" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Start Video Conversation ($0.02)
```bash
curl -X POST "https://api.orth.sh/v1/run/tavus/v2/conversations" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "persona_id": "your-persona-id",
    "conversation_name": "Customer Support Call"
  }'
```

## CLI Usage

```bash
# List all personas
orth api run tavus /v2/personas

# Start a conversation
orth api run tavus /v2/conversations --body '{"persona_id": "abc123", "conversation_name": "Demo Call"}'
```

## Use Cases

1. **Customer Support**: AI-powered video support agents
2. **Sales Demos**: Personalized video product demos
3. **Training**: Interactive video training sessions
4. **Onboarding**: Automated new user onboarding calls
5. **Interviews**: AI-assisted screening interviews
