---
name: agentmail
description: Work with API-first email inboxes for agents, including sending, receiving, and webhook workflows.
---

# AgentMail

Use this skill when a task needs dedicated programmable inboxes for AI agent workflows.

## When To Use

- Create throwaway or dedicated inboxes for automations.
- Send and receive email through an API rather than a personal mailbox.
- Build webhook-driven flows from inbound email.
- Test signup, verification, and reply loops that require email.

## Requirements

- AgentMail account and API key.
- Clear user approval before sending any outbound email.

## Starter API Shapes

```bash
curl -s "$AGENTMAIL_API_URL/inboxes" \
  -H "Authorization: Bearer $AGENTMAIL_API_KEY"
```

```bash
curl -s "$AGENTMAIL_API_URL/messages" \
  -H "Authorization: Bearer $AGENTMAIL_API_KEY"
```

## Safety

- Never use agent inboxes to impersonate a human.
- Confirm recipients and body text before outbound sends unless the user has explicitly delegated that workflow.
