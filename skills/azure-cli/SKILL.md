---
name: azure-cli
description: Operate Azure resources with Azure CLI, subscriptions, groups, and deployments.
---

# Azure CLI

Use this skill when the user wants to inspect, create, deploy, or troubleshoot Azure resources from the command line.

## Workflow

1. Check the active account, tenant, subscription, and resource group.
2. Prefer read-only inspection before mutation.
3. Use Azure CLI commands with explicit subscription and resource group flags.
4. Summarize resource IDs, regions, costs, and changed settings.

## Notes

- Ask before deleting resources or changing public exposure.
- Do not print secrets, connection strings, or access tokens.
