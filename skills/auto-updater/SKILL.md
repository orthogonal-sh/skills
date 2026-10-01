---
name: auto-updater
description: Check, plan, apply, and verify software updates while preserving config, data, and rollback paths.
---

# Auto Updater

Use this skill when the user wants dependencies, packages, apps, CLIs, plugins, or services updated.

## Workflow

1. Inspect current versions, lockfiles, release notes, migrations, and local changes.
2. Prefer small update batches with clear rollback options.
3. Apply updates using the project's package manager or official updater.
4. Run relevant tests, smoke checks, and version verification.

## Notes

- Never overwrite user config without reading it first.
- Avoid destructive cleanup unless explicitly requested.
