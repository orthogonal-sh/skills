---
name: clawdbot-backup
description: Back up, inspect, restore, and verify ClawdBot or OpenClaw state, config, memory, and skill data.
---

# ClawdBot Backup

Use this skill when safeguarding or restoring agent workspace and runtime state.

## Workflow

- Identify the state directories, configs, secrets boundaries, and backup destination.
- Inspect existing backups and disk space before creating new archives.
- Prefer recoverable, timestamped backups with manifests and checksums.
- Verify restore instructions against a safe target or dry run before relying on the backup.
