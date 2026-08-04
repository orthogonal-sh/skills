---
name: ticktick
description: Manage TickTick tasks, projects, due dates, and batch updates from the CLI
---

# TickTick

Use this skill when the user wants to add, list, update, complete, or organize TickTick tasks and projects.

## Workflow

1. Confirm the intended task list, project, due date, and priority.
2. Use the TickTick CLI or API wrapper for reads and writes.
3. Batch related changes where supported.
4. Verify created or updated task IDs.
5. Summarize only the resulting task changes.

## Safety

- Ask before deleting tasks or bulk-moving existing projects.
- Do not expose task contents outside the active user context.
