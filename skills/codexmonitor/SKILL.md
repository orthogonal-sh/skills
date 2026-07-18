---
name: codexmonitor
description: Inspect and monitor local Codex sessions, context usage, tools, and active work.
---

# CodexMonitor

Use this skill when the user wants to inspect, list, watch, or summarize local OpenAI Codex sessions.

## Workflow

1. Check whether the CodexMonitor CLI is installed and available on PATH.
2. List recent sessions before opening a specific one.
3. Inspect active tools, context usage, model, working directory, and current task state.
4. Summarize only the operational details the user asked for.

## Notes

- Do not expose raw transcript content unless the user explicitly asks for it.
- Prefer compact session summaries over dumping logs.
