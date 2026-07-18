---
name: proxmox
description: Manage Proxmox VE nodes, VMs, containers, snapshots, tasks, and cluster status.
---

# Proxmox

Use this skill when the user asks about Proxmox VE infrastructure.

## Workflow

1. Identify the node, VM, or container before taking action.
2. Check cluster health, storage, backups, and task history when diagnosing issues.
3. Prefer read only commands for status requests.
4. Summarize actions with resource IDs and node names.

## Safety

- Ask before starting, stopping, rebooting, deleting, restoring, or migrating resources unless the user gave explicit instructions.
- Avoid exposing secrets from environment or config files.
