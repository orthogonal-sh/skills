---
name: linearis
description: Linear issue tracking from the terminal with JSON-friendly workflows
---

# Linearis

Use Linearis when you need to manage Linear issues, projects, comments, and search from a terminal-first agent workflow.

## Capabilities

- List, search, create, and update Linear issues
- Add comments and inspect issue/project metadata
- Produce JSON output suitable for agent parsing

## Workflow

1. Confirm the target Linear workspace, team, project, or issue key.
2. Use the Linearis CLI/API to fetch current state before making changes.
3. Apply the smallest requested issue, comment, or project update.
4. Return the issue key, URL, and a concise change summary.

## Notes

- Prefer read-only inspection unless the user asks to change Linear.
- Keep outbound issue/comment text clear and ready for teammates to read.
