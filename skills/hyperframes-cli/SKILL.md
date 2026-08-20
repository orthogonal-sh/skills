---
name: hyperframes-cli
description: Operate Hyperframes video workflows from the command line
---

# Hyperframes CLI

Use this skill when a user wants to scaffold, render, inspect, or automate Hyperframes video projects from the terminal.

## Workflow

1. Check whether the Hyperframes CLI is installed and authenticated.
2. Inspect project config, assets, scene definitions, and render targets.
3. Run the smallest validation command before full renders.
4. Capture render IDs, output paths, errors, and retry guidance.
5. Keep generated files organized under the project asset or output directory.

## Guardrails

- Do not start expensive renders unless the user clearly asked for production output.
- Preserve existing generated media unless cleanup is requested.

## Source

Discovered from skills.sh trending: `heygen-com/hyperframes`.
