---
name: portainer
description: Manage Docker containers, stacks, logs, and redeploys through the Portainer API.
---

# Portainer

Use this skill when the user wants to inspect or manage Docker resources through Portainer.

## Workflow

1. Identify the endpoint, stack, container, or service.
2. Check status, logs, image versions, and recent events before changing anything.
3. For redeploys, confirm the source branch or image tag.
4. Report the result with resource names and any followup checks.

## Safety

- Ask before restarting, stopping, deleting, or redeploying production resources.
- Avoid exposing tokens or environment secrets.
