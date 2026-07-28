---
name: swift-concurrency-expert
description: Review and fix Swift concurrency, actors, async tasks, Sendable, and isolation issues
---

# Swift Concurrency Expert

Use this skill when working on Swift code involving async/await, actors, MainActor, tasks, cancellation, structured concurrency, Sendable, or Swift 6 concurrency warnings.

## Workflow

1. Read the surrounding type ownership and threading model before editing.
2. Identify actor isolation, escaping closures, shared mutable state, and cancellation boundaries.
3. Prefer structured concurrency over detached tasks.
4. Keep UI mutations on the main actor.
5. Add focused tests or compiler checks for changed concurrency behavior.

## Review Checklist

- No accidental main-thread blocking.
- Cancellation is propagated.
- Sendable fixes do not hide real shared-state bugs.
