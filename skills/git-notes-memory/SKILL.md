---
name: git-notes-memory
description: Store branch-aware project memory in git notes and retrieve it during codebase work.
---

# Git Notes Memory

Use this skill when repo-local memory should travel with Git history without changing tracked files.

## Workflow

1. Determine the current branch and commit context.
2. Query relevant git notes before coding.
3. Add concise notes for decisions, hazards, or patterns worth preserving.
4. Push or fetch notes only when the workflow expects shared memory.

## Notes

- Never store secrets in git notes.
- Prefer concise entries tied to concrete commits or files.
