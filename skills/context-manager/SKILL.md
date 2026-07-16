---
name: context-manager
description: Manage session context, active facts, and handoffs for long-running agent work.
---

# Smart Context Manager

Use this skill when a conversation spans many steps, multiple files, or several sessions and the agent needs an explicit context ledger.

## Workflow

- Track the user's objective, constraints, and latest instruction.
- Record current assumptions and update them when evidence changes.
- Keep a short list of active files, commands, decisions, and pending checks.
- Before handoff or compaction, rewrite the context into a concise state summary.
- Drop obsolete observations once they no longer affect the work.

## Output

Return the minimum useful context for continuing the task.
