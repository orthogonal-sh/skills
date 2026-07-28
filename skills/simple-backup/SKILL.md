---
name: simple-backup
description: Back up agent workspace and state to local or rclone-managed destinations
---

# Simple Backup

Use this skill when the user wants to back up an agent workspace, OpenClaw state, skills, memory files, configs, or project artifacts.

## Workflow

1. Identify the source directories and destination.
2. Exclude caches, build artifacts, logs, and secrets unless explicitly required.
3. Create a timestamped archive or synced folder.
4. Verify restore basics by listing archive contents or checking checksums.
5. Document restore commands and retention policy.

## Safety

- Use recoverable operations and avoid destructive cleanup unless approved.
- Be careful with credentials and private memory files in cloud destinations.
