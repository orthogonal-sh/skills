---
name: golang-concurrency
description: Design and review Go concurrency with goroutines, channels, contexts, worker pools, locks, and leak prevention.
---

# Golang Concurrency

Use this skill when implementing or debugging concurrent Go code.

## Workflow

1. Define ownership, lifecycle, cancellation, backpressure, and error propagation.
2. Prefer `context.Context` for cancellation across request or job boundaries.
3. Check for goroutine leaks, unbounded queues, lock ordering problems, and data races.
4. Run race-enabled tests when the code path can be exercised locally.

## Source

Discovered from `skills.sh`: `samber/cc-skills-golang` / `golang-concurrency`.
