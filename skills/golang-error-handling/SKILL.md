---
name: golang-error-handling
description: Improve Go error handling with wrapping, sentinel errors, typed errors, context, and caller-friendly messages.
---

# Golang Error Handling

Use this skill when implementing or reviewing error handling in Go services, CLIs, libraries, or workers.

## Workflow

1. Identify public error boundaries, retryable failures, validation failures, and internal defects.
2. Use wrapping with context where callers need diagnostics, and avoid losing root causes.
3. Choose sentinel or typed errors only when callers need programmatic branching.
4. Test failure paths, not just successful execution.

## Source

Discovered from `skills.sh`: `samber/cc-skills-golang` / `golang-error-handling`.
