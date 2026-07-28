---
name: better-notion
description: Manage Notion pages, databases, blocks, search, and queries with approval-aware workflows
---

# Better Notion

Use this skill when the user asks to work with Notion content, including pages, databases, blocks, notes, task tables, project docs, or knowledge-base search.

## Workflow

1. Confirm the target workspace, page, or database when it is ambiguous.
2. Read existing Notion content before creating or editing records.
3. Prefer structured database queries for tables and filtered views.
4. Show drafts for destructive, external, or user-visible edits before applying them.
5. Summarize changed pages, created records, and any follow-up actions.

## Setup Notes

- Requires a Notion integration token or an approved local Notion CLI/API wrapper.
- Never ask the user to paste secrets into chat. Use documented local credential setup.
- Respect Notion sharing boundaries. A missing page may simply not be shared with the integration.
