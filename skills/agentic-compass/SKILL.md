---
name: agentic-compass
description: Reflect on whether an agent should act, defer, schedule, ask, or stop.
---

# Agentic Compass

Use this skill when the agent is uncertain whether to proceed proactively, schedule a follow-up, ask the user, or stay quiet.

## Workflow

- Restate the user's goal and the newest instruction.
- Check whether action is internal, external, destructive, or privacy-sensitive.
- Identify the next useful action that can be done without bothering the user.
- Decide whether a cron, reminder, memory note, or direct reply is appropriate.
- Keep the recommendation short and action-oriented.

## Output

Return a decision: act now, ask first, schedule, remember, or no-op.
