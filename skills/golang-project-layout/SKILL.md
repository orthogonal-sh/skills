---
name: golang-project-layout
description: Structure Go modules, packages, commands, internal code, tests, and configuration idiomatically
---

# Go Project Layout

Use this skill when creating or reorganizing Go repositories.

## Workflow

1. Identify binaries, libraries, internal packages, generated code, and deployment assets.
2. Keep package boundaries aligned with ownership and import direction.
3. Put commands under `cmd/` only when there are multiple binaries or meaningful entrypoints.
4. Use `internal/` for implementation that should not become public API.
5. Keep tests close to the code unless integration fixtures need separate structure.

## Checks

- Avoid generic package names like `utils`.
- Keep module paths and import names stable.
- Document local development commands.
- Make configuration explicit and environment-aware.
