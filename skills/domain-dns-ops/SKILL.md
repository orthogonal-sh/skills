---
name: domain-dns-ops
description: Diagnose domain, DNS, registrar, TLS, email auth, and propagation issues with safe change plans.
---

# domain-dns-ops

Use this skill when working on domains, DNS records, registrar settings, nameservers, TLS certificates, redirects, SPF, DKIM, DMARC, or propagation checks.

## Workflow

- Gather the target domain, desired behavior, current provider, and any recent changes.
- Inspect authoritative nameservers, record values, TTLs, DNSSEC, CAA, MX, SPF, DKIM, DMARC, and certificate state.
- Distinguish authoritative answers from resolver cache and propagation delay.
- Provide a minimal change plan, rollback path, and verification commands before any external DNS change.
