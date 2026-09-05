---
name: proxmox-admin
description: Manage Proxmox nodes, VMs, containers, storage, snapshots, and cluster health.
---

# Proxmox Admin

Use for Proxmox VE inventory, health checks, VM/LXC lifecycle, snapshots, backups, and resource troubleshooting.

## Workflow

1. Inspect cluster, node, and storage health first.
2. Identify the exact VM or container before lifecycle commands.
3. Prefer snapshots or backups before risky changes.
4. Ask before stopping, deleting, resizing, or migrating workloads.
5. Report task IDs and final resource state.
