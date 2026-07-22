---
name: clawddocs
description: Navigate Clawdbot and OpenClaw docs, config, tools, and troubleshooting paths.
---

# Clawdocs

Use this skill when the user asks about Clawdbot, OpenClaw docs, configuration, tools, skills, nodes, sessions, or troubleshooting.

## Workflow

1. Identify the product surface, version, and environment.
2. Search official docs or local docs before answering.
3. Provide the shortest working path, with commands or config snippets when useful.
4. Separate confirmed behavior from inference.
5. Capture any local convention that should be remembered.

## Guardrails

- Do not expose private workspace paths or secrets in shared contexts.
- Prefer official docs and local installed docs over stale memory.
- Ask before making external account or integration changes.
