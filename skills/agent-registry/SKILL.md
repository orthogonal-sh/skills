---
name: agent-registry
description: Discover, search, and load specialized agents lazily instead of loading every agent upfront.
---

# Agent Registry

Use this skill when a task may benefit from specialized agents or when the user asks what agents are available.

## Stub Scope

- Search for candidate agents before loading full instructions.
- Load only the agent instructions needed for the current task.
- Prefer clear selection criteria over dumping a full registry into context.

## Future Implementation Notes

- Add scripts for listing, searching, and loading agent definitions.
- Add examples for large registries with paging and relevance scoring.
