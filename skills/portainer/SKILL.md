---
name: portainer
description: Manage Portainer environments, stacks, containers, logs, redeploys, and status checks.
---

# Portainer

Use this skill when working with Docker or Kubernetes environments managed through Portainer.

## Workflow

1. Confirm the Portainer endpoint, environment, stack, and access method.
2. Inspect containers, stacks, images, volumes, networks, and recent logs.
3. For redeploys, verify source repo, compose file, environment variables, and image tags.
4. Apply the smallest operation needed, such as restart, pull, redeploy, or log review.
5. Report status, changed resources, and rollback considerations.

## Guardrails

Ask before destructive stack, container, or volume operations.
