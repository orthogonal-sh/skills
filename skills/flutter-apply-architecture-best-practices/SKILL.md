---
name: flutter-apply-architecture-best-practices
description: Apply Flutter architecture patterns for state, routing, async work, modules, testing, and maintainability
---

# Flutter Architecture Best Practices

Use this skill when designing or refactoring Flutter application architecture.

## Workflow

1. Identify feature boundaries, routing, state management, data sources, and platform integrations.
2. Keep domain, presentation, infrastructure, and generated code responsibilities clear.
3. Model async loading, error, empty, and offline states explicitly.
4. Add tests around state transitions, widgets, repositories, and critical flows.
5. Document conventions so future features follow the same structure.

## Checks

- Avoid global mutable state unless the app already depends on it.
- Keep build methods predictable and lightweight.
- Validate platform-specific configuration and permissions.
- Run analyzer, formatter, and relevant tests before shipping changes.
