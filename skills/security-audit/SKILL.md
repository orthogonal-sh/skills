---
name: security-audit
description: Audit deployments, repos, configs, ports, dependencies, and credentials for security risks.
---

# Security Audit

Use this skill when the user asks for a security audit or hardening pass.

## Workflow

1. Define the asset boundary and threat model.
2. Check exposed services, authentication, secrets, dependency risk, config defaults, and logging.
3. Rank findings by severity and exploitability.
4. Recommend minimal fixes and verification steps.

## Safety

- Do not exfiltrate secrets.
- Avoid destructive remediation without explicit permission.
