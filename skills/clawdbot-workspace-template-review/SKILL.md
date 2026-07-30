---
name: clawdbot-workspace-template-review
description: Compare an OpenClaw workspace against official templates and identify missing or stale sections.
---

# Clawdbot Workspace Template Review

Use this skill when reviewing an OpenClaw workspace for drift from the current official templates.

## Workflow

1. Locate the active workspace and the installed OpenClaw template source.
2. Compare key files such as `AGENTS.md`, `SOUL.md`, `USER.md`, `TOOLS.md`, `HEARTBEAT.md`, and workspace skill notes.
3. Report missing sections, stale conventions, and local customizations that should be preserved.
4. Suggest minimal patches rather than replacing user-owned files wholesale.
