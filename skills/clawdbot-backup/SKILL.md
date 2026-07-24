---
name: clawdbot-backup
description: Back up, restore, migrate, and verify Clawdbot configuration, skills, memory, and settings.
---

# Clawdbot Backup

Use this skill when safeguarding or moving Clawdbot configuration, skills, commands, and local state.

## Stub Scope

- Prefer recoverable backups and manifests before modifying live configuration.
- Exclude secrets or store them through approved secret-management paths.
- Verify restore steps on a copy when possible.

## Future Implementation Notes

- Add backup manifests, archive commands, restore checks, and migration workflows.
- Add git-based backup patterns with secret scanning.
