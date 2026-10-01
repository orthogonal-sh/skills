---
name: ssh-essentials
description: Use SSH safely for remote access, keys, config, port forwarding, file transfer, and troubleshooting.
---

# SSH Essentials

Use this skill when the user asks about SSH login, keys, agents, known_hosts, tunnels, remote commands, or connection debugging.

## Workflow

1. Inspect existing SSH config, aliases, keys, and target host details when available.
2. Diagnose DNS, network reachability, authentication, host key, shell, and permission issues.
3. Use verbose SSH output when needed and explain the relevant lines.
4. Apply the smallest durable config change that solves the problem.

## Notes

- Do not expose private keys or secrets.
- Preserve existing `~/.ssh/config` entries when editing.
