---
name: proxmox
description: Manage Proxmox VE nodes, VMs, containers, snapshots, and cluster tasks
---

# Proxmox

Use this skill when the user asks to inspect or manage Proxmox nodes, virtual machines, containers, storage, snapshots, or cluster tasks.

## Workflow

1. Identify the target cluster, node, VM, container, or storage pool.
2. Read current status before making changes.
3. Perform requested API or CLI actions with explicit target IDs.
4. Poll task status until completion when needed.
5. Summarize state changes and any follow-up maintenance.

## Safety

- Ask before stop, delete, rollback, or migration operations.
- Take or confirm backups before risky infrastructure changes.
