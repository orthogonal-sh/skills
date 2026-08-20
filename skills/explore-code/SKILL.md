---
name: explore-code
description: Explore unfamiliar codebases with focused questions and findings
---

# Explore Code

Use this skill when a user asks where behavior lives, how a feature works, or what code needs to change.

## Workflow

1. Start from the user's target behavior or error.
2. Search with `rg` for routes, commands, symbols, strings, and tests.
3. Read the smallest connected set of files that explain the behavior.
4. Build a short evidence-backed map of the relevant modules.
5. Only propose edits after the ownership and data flow are clear.

## Output

Return file references, key functions, and a direct answer to the user's question.

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
