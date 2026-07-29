---
name: swarm
description: Run cheap parallel worker agents for independent research, extraction, or implementation subtasks.
---

# Swarm

Use this skill when a task can be split into independent subtasks that cheaper workers can handle in parallel.

## When To Use

- Compare several libraries or vendors.
- Inspect many files or repositories.
- Extract structured data from multiple sources.
- Generate first-pass options for a final decision.

## Task Design

Each worker prompt should include:

- One clear objective
- Inputs and constraints
- Output format
- Time or token budget
- What not to change

## Merge Step

The coordinator must:

- Validate worker claims.
- Deduplicate findings.
- Resolve contradictions.
- Produce a final answer or implementation plan.

## Guardrails

Do not use parallel workers for tightly coupled code edits unless each worker has a separate worktree or read-only scope.
