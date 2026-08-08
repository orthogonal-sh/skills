---
name: portable-tools
description: Build scripts and tools that run across machines without hardcoded paths or accounts.
---

# Portable Tools

Use this skill when creating automation intended to work across devices, repos, or user accounts.

## Workflow

1. Identify all machine-specific paths, usernames, ports, services, and credentials.
2. Replace hardcoded assumptions with environment variables, config files, discovery, or flags.
3. Use XDG, platform, and shell conventions where appropriate.
4. Add helpful errors for missing dependencies.
5. Test from a clean working directory or alternate account shape when practical.

## Output

Document required config, defaults, and portability limits.
