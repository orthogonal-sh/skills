---
name: linux-service-triage
description: Diagnose Linux service failures using logs, systemd, PM2, ports, permissions, and reverse proxies.
---

# Linux Service Triage

Use this skill when a server process, daemon, app, or reverse-proxied service is failing or unreachable.

## Stub Scope

- Start with service status, recent logs, ports, disk, memory, and process health.
- Check config files, permissions, environment variables, DNS, TLS, and proxy routing.
- Keep restart and mutation steps explicit and scoped.

## Future Implementation Notes

- Add systemd, PM2, Docker, Nginx, Caddy, and DNS triage command sequences.
- Add escalation templates for recurring crashes and resource exhaustion.
