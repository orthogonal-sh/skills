---
name: linearis
description: Manage Linear issues, projects, cycles, comments, and documents from an agent-friendly CLI.
---

# Linearis

Use this skill when Linear work should be handled through the `linearis` CLI instead of ad hoc API calls.

## When To Use

- Search and list Linear issues.
- Create or update tasks, comments, labels, cycles, or project fields.
- Summarize project status for planning.
- Keep issue updates tied to local code changes.

## Starter Commands

```bash
linearis issues list --json
linearis issues search "customer onboarding" --json
linearis issues create --title "Investigate onboarding dropoff" --json
```

## Good Practice

- Use JSON output for agent parsing.
- Prefer issue IDs or keys over title matching.
- Include implementation links or PR URLs when updating issues.

## Safety

Confirm destructive or broad updates before applying them.
