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
orth api run tavus /v2/personas
```

### Start Video Conversation ($0.02)
```bash
orth api run tavus /v2/conversations --body '{
  "persona_id": "your-persona-id",
  "conversation_name": "Customer Support Call"
}'
```

## Use Cases

1. **Customer Support**: AI-powered video support agents
2. **Sales Demos**: Personalized video product demos
3. **Training**: Interactive video training sessions
4. **Onboarding**: Automated new user onboarding calls
5. **Interviews**: AI-assisted screening interviews
