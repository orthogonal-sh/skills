---
name: swift-concurrency-expert
description: Diagnose and design Swift concurrency using async/await, actors, tasks, cancellation, isolation, and MainActor rules.
---

# Swift Concurrency Expert

Use this skill when Swift code involves structured concurrency or isolation issues.

## Workflow

- Identify actors, tasks, async boundaries, shared state, and UI-thread requirements.
- Check for data races, priority inversions, leaked tasks, and missing cancellation.
- Prefer structured concurrency over detached work unless isolation requires it.
- Use compiler diagnostics and runtime warnings to guide changes.
- Add tests or instrumentation for cancellation, ordering, and thread confinement.
