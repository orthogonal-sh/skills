---
name: clawddocs
description: Navigate OpenClaw and ClawdBot docs, release notes, config, tools, skills, and troubleshooting references.
---

# ClawdDocs

Use this skill when the user asks how OpenClaw, ClawdBot, skills, tools, nodes, gateway, cron, or sessions work.

## Workflow

1. Determine whether the question is about installation, configuration, runtime behavior, tools, skills, or debugging.
2. Prefer official local docs, installed package docs, and current upstream documentation.
3. Check versions before giving commands that may have changed.
4. Provide the shortest working path, with file paths or commands the user can run.

## Notes

- Be careful not to leak private workspace settings when explaining examples.
- When changing OpenClaw config, inspect existing state first and preserve user edits.
