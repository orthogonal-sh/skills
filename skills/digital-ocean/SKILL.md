---
name: digital-ocean
description: Manage DigitalOcean droplets, apps, databases, domains, and deployments.
---

# DigitalOcean

Use this skill when the user wants to inspect, deploy, scale, or troubleshoot DigitalOcean infrastructure.

## Workflow

1. Identify the project, region, resource, and environment.
2. Inspect current resource state before mutation.
3. Use doctl or the approved API path with explicit resource IDs.
4. Verify health, logs, DNS, and deployment state after changes.

## Notes

- Ask before destroying resources, resizing databases, or opening ports.
- Avoid exposing tokens, SSH keys, and database credentials.
