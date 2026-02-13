---
name: tavus
description: AI video conversations - create real-time video calls with AI personas
---

# Tavus - AI Video Conversations

Create real-time video conversations with AI-powered digital personas.

## Capabilities

- **List Personas**: This endpoint returns a list of all Personas ($0.01)
- **Create Conversation**: This endpoint starts a real-time video conversation with your AI replica, powered by a persona that allows it to see, hear, and respond like a human ($0.02)

## Usage

### List Personas ($0.01)
This endpoint returns a list of all Personas. You can first list the Personas to choose which one you'd like to create a conversation with. Then, using the Create Conversation endpoint, you can start a conversation with that persona providing the persona ID.

```bash
orth api run tavus /v2/personas
```

### Create Conversation ($0.02)
This endpoint starts a real-time video conversation with your AI replica, powered by a persona that allows it to see, hear, and respond like a human. Provide the most relevant persona_id obtained from the List Personas endpoint.

Parameters:
- persona_id* (string) - p1b06420cfdc

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

## Discover More

For full endpoint details and parameters:

```bash
orth api show tavus              # List all endpoints
```
