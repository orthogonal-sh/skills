---
name: golang-modernize
description: Modernize Go code with current language features, tooling, modules, tests, and cleanup patterns
---

# Go Modernize

Use this skill when updating older Go code to current idioms and tooling.

## Workflow

1. Inspect the Go version, module settings, CI, linters, and dependency age.
2. Identify changes that improve clarity, safety, or maintainability.
3. Apply small modernizations such as `errors.Is`, `errors.As`, `context`, `testing` helpers, generics where justified, and cleaner module usage.
4. Preserve public APIs unless the task explicitly allows breaking changes.
5. Run tests and tooling after each meaningful set of changes.

## Checks

- Avoid novelty for its own sake.
- Keep generated code and vendored code out of manual rewrites.
- Confirm minimum supported Go version.
- Document behavioral changes separately from style cleanup.
