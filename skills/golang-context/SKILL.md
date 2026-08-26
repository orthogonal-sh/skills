---
name: golang-context
description: Use Go context correctly for cancellation, deadlines, request scope, and goroutine cleanup
---

# Go Context

Use this skill when adding or reviewing `context.Context` usage in Go code.

## Workflow

1. Pass context as the first parameter for request-scoped work.
2. Derive deadlines and cancellation at ownership boundaries.
3. Avoid storing context in structs unless a framework requires it.
4. Thread cancellation through I/O, database, and worker calls.
5. Test cancellation, timeout, and cleanup paths.

## Checks

- Do not use context for optional function parameters.
- Always call cancel functions when creating derived contexts.
- Keep context values limited to request-scoped metadata.
- Ensure goroutines exit when context is canceled.
