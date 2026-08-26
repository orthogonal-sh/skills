---
name: cloudflare-one
description: Plan and validate Cloudflare One access, Zero Trust, tunnels, DNS, and network security changes
---

# Cloudflare One

Use this skill when working with Cloudflare One, Zero Trust, Access, Gateway, tunnels, WARP, DNS policy, or network security changes.

## Workflow

1. Identify the Cloudflare account, zone, application, tunnel, identity provider, and policy surface involved.
2. Read the current configuration before proposing edits.
3. Separate identity policy, network routing, DNS, and device posture concerns.
4. Prefer staged rollout with a test group, logging, and a rollback path.
5. Verify access from an allowed and denied user or device path.

## Checks

- Confirm policy order and default deny behavior.
- Check DNS, route, and tunnel overlap before changes.
- Preserve emergency access paths.
- Document affected users, apps, and networks.
