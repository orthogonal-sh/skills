---
name: hubspot-crm
description: Work with HubSpot contacts, companies, deals, owners, notes, tasks, and CRM data
---

# HubSpot CRM

Use this skill when the user asks to search, create, update, enrich, export, or summarize HubSpot CRM records.

## Workflow

1. Identify object type: contact, company, deal, ticket, owner, note, task, or list.
2. Search before creating to avoid duplicates.
3. Use HubSpot object IDs for updates whenever possible.
4. Preview bulk changes, owner assignments, lifecycle updates, and outbound notes before applying.
5. Summarize records touched and fields changed.

## Safety

- CRM updates affect live customer data. Use dry-run mode when available.
- Never overwrite fields with lower-confidence enrichment without approval.
