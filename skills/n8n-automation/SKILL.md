---
name: n8n-automation
description: Inspect, trigger, debug, and document n8n workflows, credentials, executions, and webhooks.
---

# n8n Automation

Use this skill when working with n8n workflows or automation runs.

## Workflow

1. Identify the n8n instance, workflow, trigger, execution ID, and intended outcome.
2. Inspect workflow nodes, credentials references, recent executions, and error output.
3. Reproduce with a manual trigger or test payload when safe.
4. Propose node-level fixes, retries, or observability improvements.
5. Document workflow purpose, inputs, outputs, and failure modes.

## Guardrails

Never expose credential values. Ask before activating workflows that affect external systems.
