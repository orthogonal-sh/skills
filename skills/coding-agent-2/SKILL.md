---
name: coding-agent-2
description: Coordinate coding agents such as Codex, Claude Code, OpenCode, or Pi for background engineering tasks.
---

# Multi Coding Agent

Use this skill when work should be delegated to one or more coding agents, especially for independent implementation, investigation, review, or test-fixing tasks.

## Workflow

- Define the task with repository path, branch, scope, constraints, and expected output.
- Choose the smallest useful number of agents.
- Assign non-overlapping work when running agents in parallel.
- Monitor progress through commits, diffs, logs, and reported blockers.
- Review all generated changes before merging or presenting them.

## Safety

- Keep branches and worktrees separate.
- Do not let agents overwrite user changes.
- Require tests or a clear verification note for code changes.
