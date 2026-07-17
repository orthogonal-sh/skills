---
name: context-recovery
description: Recover active work context after compaction, interruption, vague continuation, or missing session state.
---

# Context Recovery

Use this skill when the user asks to continue prior work but the active context is incomplete.

## Workflow

- Identify the channel, repo, branch, issue, PR, or task hinted by the current message.
- Search recent session history, memory files, plans, git state, and local notes as appropriate.
- Reconstruct the goal, current state, decisions, blockers, and next actions.
- Ask only if multiple plausible contexts remain.
- Continue from the recovered state instead of restarting from scratch.

