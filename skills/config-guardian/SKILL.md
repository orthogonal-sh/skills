---
name: config-guardian
description: Audit, compare, harden, and safely update configuration files, secrets references, and service settings.
---

# Config Guardian

Use this skill when a task involves application, service, shell, CI, deployment, or agent configuration that could affect runtime behavior.

## Workflow

- Inspect the existing configuration, include/import chain, generated files, and owner conventions before editing.
- Preserve user changes and merge with current state rather than replacing whole files.
- Keep secrets out of logs and commits; use references or secret stores where available.
- Verify syntax, effective configuration, service reload behavior, and rollback path.
