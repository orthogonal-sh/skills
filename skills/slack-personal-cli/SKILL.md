---
name: slack-personal-cli
description: Use a local Slack CLI for personal Slack search, reads, drafts, sends, and unread triage.
---

# Slack Personal CLI

Use this skill when the user wants Slack handled through a local CLI rather than an API integration.

## Workflow

1. Identify the workspace, channel, DM, thread, or search query.
2. Prefer read-only commands for search, unread triage, and history lookup.
3. Summarize with channel, sender, timestamp, and message link when available.
4. Draft outgoing messages and wait for approval before sending unless the user explicitly authorized sending.

## Safety

- Do not reveal private Slack content outside the active context.
- Avoid sending or editing messages without clear permission.
