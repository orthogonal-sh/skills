---
name: swift-concurrency-pro
description: Review and improve Swift concurrency with actors, tasks, cancellation, Sendable, and MainActor safety
---

# Swift Concurrency Pro

Use this skill when implementing or reviewing Swift concurrency.

## Workflow

1. Identify actor boundaries, UI isolation, async APIs, shared state, and cancellation paths.
2. Use structured concurrency where possible and avoid unbounded detached tasks.
3. Mark Sendable, MainActor, and actor isolation intentionally.
4. Handle priority, cancellation, timeouts, retries, and error propagation.
5. Validate with compiler checks, tests, and race-oriented review.

## Checks

- Do not block the main actor with synchronous work.
- Avoid escaping non-Sendable values across concurrency domains.
- Make lifecycle ownership clear for long-running tasks.
- Test cancellation and deallocation paths.
