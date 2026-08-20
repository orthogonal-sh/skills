---
name: mcporter
description: Manage and call MCP servers and tools with mcporter
---

# Mcporter

Use this skill when a user asks to list MCP servers, inspect tool schemas, configure auth, call MCP tools, or debug MCP connectivity.

## Workflow

1. Inspect configured MCP servers and transport type.
2. Validate server health and available tools.
3. Read tool schemas before calling tools.
4. Prefer non-mutating calls while diagnosing.
5. Document server name, tool name, arguments, and result summary.

## Guardrails

- Do not expose tokens or secrets from MCP configs.
- Confirm before invoking tools that mutate external systems.

## Source

Discovered from `sundial-org/awesome-openclaw-skills`.
