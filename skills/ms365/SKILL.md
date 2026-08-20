---
name: ms365
description: Work with Microsoft 365 services through CLI or Graph APIs
---

# Microsoft 365

Use this skill when a user asks to inspect or automate Microsoft 365 mail, calendar, files, users, groups, Teams, SharePoint, or tenant configuration.

## Workflow

1. Identify the service, tenant context, user, and required permission scope.
2. Prefer the Microsoft 365 CLI, Microsoft Graph CLI, or documented Graph endpoints.
3. Use read-only checks before creating or changing objects.
4. Capture IDs, URLs, timestamps, and permission assumptions.
5. Summarize actions and any admin approval needed.

## Guardrails

- Do not request secrets.
- Do not send messages, change permissions, or delete resources without explicit approval.

## Source

Discovered from `sundial-org/awesome-openclaw-skills`.
