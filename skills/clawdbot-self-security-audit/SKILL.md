---
name: clawdbot-self-security-audit
description: Audit OpenClaw configuration and workspace security posture
---

# Clawdbot Self Security Audit

Use this skill when a user asks to harden an OpenClaw, Clawdbot, or agent workspace setup.

## Workflow

1. Inventory config files, channel integrations, secrets references, skills, cron jobs, and exposed services.
2. Check for overbroad permissions, direct secrets, public endpoints, stale tokens, and risky automations.
3. Treat the audit as read-only unless the user asks for fixes.
4. Rank findings by impact and exploitability.
5. Provide exact remediation steps with file paths or commands.

## Guardrails

- Do not print secret values.
- Do not disable integrations without explicit approval.

## Source

Discovered from `sundial-org/awesome-openclaw-skills`.
