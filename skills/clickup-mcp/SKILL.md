---
name: clickup-mcp
description: Manage ClickUp tasks, docs, time tracking, comments, chat, and search through MCP
---

# ClickUp MCP

Use this skill when the user asks to list, create, update, search, or comment on ClickUp tasks, docs, or project artifacts.

## Source

- OpenClaw discovery: `clickup-mcp`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/clickup-mcp

## Stub Notes

- Confirm workspace, list, and task identifiers before mutating ClickUp state.
- Use read/search flows first when the target is ambiguous.
- Summarize external changes after creating or updating tasks.

## Implementation TODO

- Add OAuth and MCP server setup.
- Document task, doc, comment, search, and time tracking commands.
- Add approval guidance for bulk updates.
