---
name: linux-service-triage
description: Triage Linux services with systemd status, logs, ports, config checks, and recovery-safe fixes.
---

# linux-service-triage

Use this skill when a Linux daemon, background service, cron, timer, socket, or local server is failing, flapping, slow, or unreachable.

## Workflow

- Inspect service status, unit files, recent logs, exit codes, dependencies, timers, sockets, and restart history.
- Check ports, processes, permissions, disk space, environment files, and recent config changes.
- Prefer read-only diagnosis first; preserve current config before proposing edits or restarts.
- Summarize likely cause, exact evidence, safe remediation steps, and verification commands.
