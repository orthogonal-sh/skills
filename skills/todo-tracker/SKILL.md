---
name: todo-tracker
description: Maintain a persistent scratch todo list with add, list, complete, remove, and search operations.
---

# TODO Tracker

Use when a user asks to capture or manage lightweight TODOs without needing a full project management system.

## Suggested Workflow

- Store TODOs in a durable local file or configured task backend.
- Read before writing to avoid duplicates.
- Keep each item actionable.
- Mark completion with enough context to be useful later.

## Candidate Sources

- OpenClaw `todo-tracker`
- Local markdown, JSON, or SQLite task stores
