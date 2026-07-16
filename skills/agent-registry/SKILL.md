---
name: agent-registry
description: Discover, profile, and route work to available agents by capability and current context.
---

# Agent Registry

Use this skill when deciding which agent, subagent, or assistant profile should handle a task.

## Workflow

- List available agents and their known capabilities.
- Match the task to skills, tools, model strengths, and access boundaries.
- Prefer specialized agents for narrow work and the main agent for integration.
- Include enough task context for delegation without exposing unrelated private data.
- Track ownership and expected deliverables.

## Output

Return a routing recommendation with the selected agent, reason, and task brief.
