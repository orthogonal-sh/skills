---
name: docker-essentials
description: Diagnose and operate Docker images, containers, Compose stacks, volumes, networks, and local dev environments.
---

# Docker Essentials

Use this skill when Docker is part of the task, especially for local setup, failing containers, Compose services, image builds, or reproducible dev environments.

## Workflow

- Inspect `Dockerfile`, Compose files, environment files, and service logs.
- Prefer non-destructive commands before pruning or removing resources.
- Verify image build context, port mappings, volumes, health checks, and dependency ordering.
- Capture exact commands and results needed to reproduce the issue.

## Safety

Ask before deleting volumes, pruning images, stopping unrelated containers, or exposing ports publicly.
