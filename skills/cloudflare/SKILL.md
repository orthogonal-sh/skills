---
name: cloudflare
description: Manage Cloudflare DNS, Workers, Pages, zones, rules, and cache operations.
---

# Cloudflare

Use this skill when the user wants to inspect or change Cloudflare zones, DNS records, Workers, Pages projects, firewall rules, redirects, or cache settings.

## Workflow

1. Identify the account, zone, domain, and resource type.
2. Inspect current settings before making changes.
3. Apply the smallest scoped update through the approved Cloudflare interface.
4. Verify propagation, deployment status, or effective rules.

## Notes

- Ask before deleting DNS records or changing proxy/security mode.
- Do not expose API tokens or origin credentials.
