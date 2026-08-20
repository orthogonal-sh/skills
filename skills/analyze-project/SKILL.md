---
name: analyze-project
description: Inspect a repository and produce a structured project analysis
---

# Analyze Project

Use this skill when a user asks for a codebase overview, technical due diligence, onboarding notes, or a map of how a project works.

## Workflow

1. Read the README, package manifests, config files, and directory structure.
2. Identify the main runtime, frameworks, entry points, and data stores.
3. Trace the most important user flows or background jobs.
4. Summarize architecture, risks, test coverage, and high-leverage next steps.

## Output

Return a concise project brief with:

- What the project does
- How it is structured
- How to run and test it
- Notable dependencies and integration points
- Risks, unknowns, and recommended follow-ups

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
