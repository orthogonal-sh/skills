---
name: agentmail
description: API-first email inboxes for agents, including sending, receiving, webhooks, and workflow mailboxes
---

# AgentMail

Use this skill when a workflow needs dedicated programmatic inboxes, transactional email handling, inbound parsing, or webhook-driven email automation.

## Source

- OpenClaw discovery: `agentmail`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/agentmail

## Stub Notes

- Never send outbound mail without user approval unless the caller has already granted a durable automation rule.
- Separate inbox setup, inbound search, drafting, and send operations.
- Treat email addresses and message bodies as private user data.

## Implementation TODO

- Add AgentMail API setup and auth details.
- Document inbox creation, message search, send, and webhook flows.
- Add examples for approval-gated sends and inbound triage.
