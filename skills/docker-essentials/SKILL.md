---
name: docker-essentials
description: Docker build, run, compose, image, volume, network, and container debugging workflows.
---

# Docker Essentials

Use this skill for practical Docker tasks and troubleshooting.

## Workflow

1. Inspect `Dockerfile`, compose files, env requirements, volumes, and exposed ports.
2. Build or run the smallest target needed to reproduce the task.
3. Use `docker ps`, logs, inspect, exec, network, and volume commands to diagnose issues.
4. Keep changes limited to Docker-related config unless the app itself is broken.
5. Document exact commands and verification results.

## Guardrails

Avoid removing images, volumes, or containers unless the user asked for cleanup.
