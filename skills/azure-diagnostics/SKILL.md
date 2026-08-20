---
name: azure-diagnostics
description: Diagnose Azure resources, deployments, logs, and configuration
---

# Azure Diagnostics

Use this skill when a user asks why an Azure service, deployment, identity, network path, or application is failing.

## Workflow

1. Identify subscription, resource group, resource type, region, and recent changes.
2. Prefer read-only Azure CLI commands and portal-equivalent diagnostics.
3. Check deployment status, activity logs, app logs, metrics, identities, and network rules.
4. Separate platform issues from application issues.
5. Return a prioritized diagnosis with exact commands used and next fixes.

## Guardrails

- Do not mutate cloud resources without explicit approval.
- Do not print secrets or connection strings.

## Source

Discovered from skills.sh trending: `microsoft/azure-skills`.
