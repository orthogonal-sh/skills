---
name: golang-observability
description: Add Go logging, metrics, traces, health checks, and operational diagnostics
---

# Go Observability

Use this skill when instrumenting Go services, workers, or CLIs.

## Workflow

1. Identify critical requests, background jobs, dependencies, and failure modes.
2. Add structured logs with stable fields and request correlation.
3. Emit metrics for rate, errors, duration, saturation, and queue depth.
4. Trace cross-service calls and slow paths where useful.
5. Add health and readiness checks that match runtime dependencies.

## Checks

- Avoid logging secrets or large payloads.
- Keep metric labels bounded.
- Propagate trace context through outbound calls.
- Test observability behavior on error paths.
