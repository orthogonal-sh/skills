---
name: clickup
description: Manage ClickUp spaces, lists, tasks, assignees, and comments
---

# ClickUp

Use ClickUp when the user needs to read or change ClickUp tasks, spaces, folders, lists, statuses, assignees, or comments.

## Capabilities

- Search, list, create, and update ClickUp tasks
- Manage assignees, statuses, due dates, custom fields, and comments
- Navigate spaces, folders, lists, and subtasks

## Workflow

1. Resolve the target workspace hierarchy and task identifiers.
2. Read matching records before creating or updating.
3. Apply the requested mutation through the ClickUp API.
4. Summarize changes with task URLs and any unresolved ambiguity.

## Notes

- Confirm destructive or bulk operations.
- Preserve existing task context unless explicitly asked to rewrite it.
