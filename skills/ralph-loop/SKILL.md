---
name: ralph-loop
description: Create supervised agent loop scripts for Codex, Claude Code, OpenCode, Goose, or similar CLIs.
---

# Ralph Loop

Use this skill when the user wants a repeatable coding agent loop or watchdog script.

## Workflow

1. Clarify the repository, command, stopping condition, and safety limits.
2. Generate a small shell script with logging, retries, and a clear max iteration count.
3. Include test or verification commands inside the loop when appropriate.
4. Explain how to stop and resume the loop.

## Safety

- Never create unbounded loops.
- Avoid destructive git commands inside loops.
