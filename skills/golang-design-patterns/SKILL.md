---
name: golang-design-patterns
description: Apply idiomatic Go design patterns for interfaces, packages, composition, and maintainable services
---

# Go Design Patterns

Use this skill when designing or refactoring Go packages, services, interfaces, and shared abstractions.

## Workflow

1. Start from concrete call sites and package boundaries.
2. Prefer small interfaces owned by consumers.
3. Use composition and plain functions before larger frameworks.
4. Keep constructors explicit about dependencies and defaults.
5. Add tests around behavior, not implementation shape.

## Checks

- Avoid premature generic abstractions.
- Keep package names short and meaningful.
- Prevent import cycles with clear ownership.
- Document exported types and functions.
