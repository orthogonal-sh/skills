---
name: domain-dns-ops
description: Diagnose and update domains, DNS records, propagation, SPF, DKIM, and DMARC.
---

# Domain DNS Ops

Use this skill when the user wants domain setup, DNS debugging, email authentication, redirects, certificates, or propagation checks.

## Workflow

1. Identify the domain, registrar, DNS host, and desired record state.
2. Inspect current DNS records from multiple resolvers.
3. Plan minimal record changes with exact names, types, and values.
4. Verify propagation and dependent service health.

## Notes

- Ask before changing MX, NS, or production records.
- Use exact TTLs and record targets in summaries.
