---
name: docker-pro-diagnostic
description: Diagnose Docker containers with focused log analysis, resource checks, networking, and compose review.
---

# Docker Pro Diagnostic

Use this skill when a Dockerized service is unhealthy, noisy, slow, or failing to start.

## When To Use

- Analyze container logs.
- Inspect compose files and environment wiring.
- Check health checks, ports, volumes, and networks.
- Identify resource pressure or restart loops.

## Commands

```bash
docker ps
docker logs --tail 200 <container>
docker inspect <container>
docker compose ps
```

## Workflow

1. Capture current state before restarting.
2. Look for the first meaningful error.
3. Check configuration and dependency readiness.
4. Propose the smallest fix and verification command.
