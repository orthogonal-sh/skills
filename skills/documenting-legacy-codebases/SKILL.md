---
name: documenting-legacy-codebases
description: Map legacy systems into readable docs with entry points, data flows, risks, and ownership notes
---

# Documenting Legacy Codebases

Use this skill when documenting unfamiliar or under-documented legacy software.

## Workflow

1. Identify entry points, runtime commands, dependencies, and deployment boundaries.
2. Trace key user flows, data flows, scheduled jobs, and integrations.
3. Document important modules, ownership assumptions, and known hazards.
4. Create diagrams or maps only where they clarify behavior.
5. Leave links to source files, tests, configs, and operational docs.

## Checks

- Prefer verified behavior over folklore.
- Mark uncertain areas and how to validate them.
- Keep docs close to the code when the repo has a documentation convention.
- Avoid rewriting history as if accidental design was intentional.
