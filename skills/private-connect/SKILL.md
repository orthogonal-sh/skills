---
name: private-connect
description: Configure private connectivity, tunnels, access controls, and verification for internal tools or services.
---

# Private Connect

Use this skill when connecting private services without exposing more network surface than needed.

## Workflow

- Identify the service, caller, network path, auth boundary, and required ports.
- Prefer least-privilege access with explicit allowlists and short-lived credentials.
- Document tunnel, DNS, firewall, proxy, or VPN configuration.
- Verify connectivity from the intended client and deny access from unintended paths.
- Record rollback steps and monitoring signals for the connection.
