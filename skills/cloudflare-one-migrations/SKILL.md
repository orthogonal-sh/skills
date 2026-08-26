---
name: cloudflare-one-migrations
description: Migrate apps, tunnels, access policies, and DNS routing into Cloudflare One with rollout checks
---

# Cloudflare One Migrations

Use this skill when moving services, access rules, tunnels, or DNS flows into Cloudflare One or between Cloudflare accounts.

## Workflow

1. Inventory the current ingress, auth, DNS, firewall, and device posture setup.
2. Map each legacy rule to a Cloudflare One equivalent.
3. Create a migration plan with test users, canary routes, rollback steps, and owner signoff.
4. Apply changes in small batches and verify logs after each batch.
5. Remove legacy rules only after traffic and access checks pass.

## Checks

- Keep DNS TTLs low during switchover.
- Validate tunnel health and route precedence.
- Confirm break-glass access still works.
- Capture before and after policy diffs.
