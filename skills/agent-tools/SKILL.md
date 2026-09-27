---
name: agent-tools
description: Design, document, evaluate, or integrate tools intended for AI agents, including schemas, affordances, and safety boundaries.
---

# Agent Tools

Use this skill when building or reviewing tools that an AI agent will call.

## Workflow

- Define the tool's job, inputs, outputs, side effects, and failure modes.
- Prefer narrow, typed operations over broad free-form commands.
- Include examples that show normal use, edge cases, and recovery paths.
- Add guardrails for external actions, destructive operations, and private data.
- Test the tool contract from the agent's perspective, not only the human API.
