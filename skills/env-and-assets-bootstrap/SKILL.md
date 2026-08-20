---
name: env-and-assets-bootstrap
description: Bootstrap local environment files, fixtures, and assets for a repo
---

# Environment And Assets Bootstrap

Use this skill when a repo needs a local setup pass before development, testing, demos, or agent work.

## Workflow

1. Inspect setup docs, examples, `.env.example`, package scripts, and asset folders.
2. Create missing local-only placeholders from documented examples.
3. Install dependencies using the repo's package manager.
4. Generate or download non-secret fixtures only when the docs allow it.
5. Run the smallest health check and document remaining manual setup.

## Guardrails

- Never ask for API keys.
- Never invent secrets.
- Keep generated assets small, local, and easy to replace.

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
