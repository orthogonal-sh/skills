---
name: codex-orchestration
description: Coordinate multiple Codex workers for parallel coding, research, or verification tasks.
---

# Codex Orchestration

Use this skill when a task can be decomposed into independent Codex subagent workstreams.

## Workflow

1. Split the task into non-overlapping assignments with clear outputs.
2. Spawn workers with isolated context unless they need the current transcript.
3. Continue useful local work while workers run.
4. Merge results, verify them, and resolve conflicts.

## Notes

- Do not delegate reading skill instructions.
- Keep ownership of final judgment and edits.
