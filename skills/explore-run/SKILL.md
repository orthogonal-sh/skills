---
name: explore-run
description: Run a project just enough to verify behavior while exploring
---

# Explore Run

Use this skill when code exploration needs a live run, smoke test, local server, CLI command, or reproduction script.

## Workflow

1. Inspect package scripts and setup docs before running commands.
2. Choose the lightest command that exercises the behavior.
3. Capture command, environment assumptions, and output summary.
4. If the run fails, diagnose missing dependencies, config, ports, or fixtures.
5. Stop background processes that are no longer needed.

## Guardrails

- Avoid destructive commands.
- Prefer smoke tests before full suites.
- Keep user-visible summaries concise.

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
