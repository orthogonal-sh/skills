---
name: n8n-monitor
description: Monitor n8n executions, workflow health, failures, and alerting.
---

# n8n Monitor

Use this skill when a user asks to check n8n workflow status, failed executions, or automation health.

## Stub Scope

- Read workflow and execution state before suggesting fixes.
- Summarize recent failures by workflow, error, timestamp, and suspected cause.
- Avoid changing workflows unless explicitly requested.

## Future Implementation Notes

- Add n8n API commands for workflows, executions, logs, and retries.
- Add alerting patterns for repeated failures and stale workflows.
