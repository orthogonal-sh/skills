---
name: asana
description: Manage Asana tasks, projects, workspaces, and comments
---

# Asana

Use Asana when the user needs to inspect or update Asana workspaces, projects, tasks, subtasks, or comments.

## Capabilities

- Search and list workspaces, projects, tasks, and users
- Create and update tasks, subtasks, assignees, due dates, and comments
- Handle pagination and common Asana REST API patterns

## Workflow

1. Resolve the workspace/project/task from names or IDs.
2. Read current task state before updating it.
3. Make only the requested change.
4. Return links, changed fields, and any ambiguous matches.

## Notes

- Confirm before closing, deleting, or bulk-moving tasks.
- Keep comments short and externally appropriate.
