---
name: improve-codebase-architecture
description: Review a codebase structure and propose scoped architectural improvements.
---

# Improve Codebase Architecture

Use this skill when asked to improve architecture, reduce coupling, clarify boundaries, or make a codebase easier to extend.

## Workflow

1. Read the existing module layout, entry points, tests, and dependency direction.
2. Identify current boundaries, shared abstractions, and places where responsibilities leak.
3. Prioritize changes that reduce concrete maintenance pain.
4. Avoid broad rewrites unless the user explicitly asks for them.
5. Propose or implement small, reviewable steps with clear behavior preservation.

Favor local conventions over generic architecture patterns.
