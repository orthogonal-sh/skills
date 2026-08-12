---
name: git-guardrails-claude-code
description: Protect user work in agent coding sessions with careful git status, diffs, and branch hygiene.
---

# Git Guardrails Claude Code

Use this skill when an agent is editing a git repository with possible user changes.

## Stub Scope

- Check branch and worktree status before edits.
- Treat unknown changes as user-owned.
- Avoid destructive resets, checkouts, and force pushes.
- Summarize only relevant diffs and commit hashes.

Source candidates: skills.sh and sundial-org/awesome-openclaw-skills.
