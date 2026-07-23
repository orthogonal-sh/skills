---
name: context-recovery
description: Recover missing working context after compaction, session resets, or vague continuation requests.
---

# Context Recovery

Use this skill when the user says to continue, asks about prior work, or references a project without enough visible context.

## Stub Scope

- Search recent session history, memory, repo state, and active goals before asking the user.
- Reconstruct likely task state with confidence levels.
- Clearly separate verified facts from inferred context.

## Future Implementation Notes

- Add platform-specific history lookup workflows for Slack, Discord, Telegram, and OpenClaw sessions.
- Add recovery templates for PR work, research, inbox triage, and cron jobs.
