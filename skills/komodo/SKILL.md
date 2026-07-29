---
name: komodo
description: Manage Komodo infrastructure including servers, Docker deployments, stacks, builds, and procedures.
---

# Komodo

Use this skill when a task involves Komodo-managed infrastructure.

## When To Use

- Check server and deployment status.
- Inspect Docker stacks, containers, builds, or procedures.
- Trigger a deployment or runbook.
- Diagnose failed infrastructure operations.

## Starter Flow

1. Identify the Komodo base URL and auth method.
2. Fetch read-only status before taking action.
3. Use exact resource IDs for mutations.
4. Record deployment IDs, logs, and final status.

## Example Shape

```bash
curl -s "$KOMODO_URL/api/resources" \
  -H "Authorization: Bearer $KOMODO_API_KEY"
```

## Safety

Confirm before restarting, redeploying, deleting, or scaling resources.
