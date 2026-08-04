---
name: git-notes-memory
description: Store branch-aware agent knowledge in git notes for repo-local continuity
---

# Git Notes Memory

Use this skill when repository-specific learnings should travel with Git history without changing source files.

## Workflow

1. Identify the commit, branch, file, or decision the memory belongs to.
2. Read existing git notes before adding new ones.
3. Write concise notes with date, scope, and source context.
4. Push or fetch notes refs when collaboration requires it.
5. Retrieve notes during future codebase work.

## Safety

- Do not store secrets in git notes.
- Keep notes scoped to repo knowledge, not broad personal memory.
