---
name: claude-team
description: Orchestrate Claude Code workers across git worktrees, assign tasks, monitor progress, and merge results.
---

# Claude Team

Use this skill when coordinating multiple Claude Code sessions for parallel implementation.

## Workflow

1. Create isolated worktrees for each assignment.
2. Give each worker a scoped task and expected verification.
3. Monitor progress and collect diffs.
4. Review, test, and integrate only the accepted changes.

## Notes

- Protect user changes in the main worktree.
- Avoid overlapping file ownership across workers.
