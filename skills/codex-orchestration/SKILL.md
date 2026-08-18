---
name: codex-orchestration
description: Coordinate parallel Codex workers for implementation, review, testing, and research tasks
---

# Codex Orchestration

Use this skill when a task is large enough to split across multiple Codex workers with independent context and deliverables.

## Source

- OpenClaw discovery: `codex-orchestration`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/codex-orchestration

## Stub Notes

- Split work by ownership boundary rather than by arbitrary file count.
- Give each worker a concrete output contract.
- Reconcile results in the parent session before editing shared code.

## Implementation TODO

- Add worker spawn and monitoring commands.
- Document handoff, review, and merge patterns.
- Add examples for code review, test repair, and research fan-out.
