---
name: claude-team
description: Coordinate multiple Claude Code workers in isolated worktrees
---

# Claude Team

Use this skill when a coding task can be split across multiple Claude Code workers with separate worktrees and clear ownership.

## Workflow

1. Break the task into independent work scopes.
2. Create or assign clean worktrees for each worker.
3. Give each worker explicit files, goals, and verification commands.
4. Monitor progress and resolve conflicts.
5. Integrate reviewed changes into the main branch.

## Safety

- Do not let workers edit overlapping files without coordination.
- Review worker output before committing or pushing.
