---
name: smart-compaction
description: Compact long agent context into durable state, summaries, and next-action handoffs.
---

# Smart Compaction

Use this skill when an agent session is approaching context limits or needs a durable handoff before continuing long-running work.

## Stub Notes

- Source: skills.sh hot list / openduo duoduo skills.
- Suggested coverage: extract decisions, current state, blockers, commands run, files touched, validation results, and next steps.
- Suggested setup: document where summaries are saved and how resumed agents should reload them.
