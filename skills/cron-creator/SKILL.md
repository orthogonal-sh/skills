---
name: cron-creator
description: Convert natural-language reminder and automation requests into OpenClaw cron job definitions.
---

# Cron Creator

Use this skill when the user asks to schedule a reminder, recurring message, check-in, or standalone automation.

## Workflow

1. Clarify date, time, timezone, recurrence, and destination when missing.
2. Prefer isolated jobs for standalone work and main-session events for lightweight reminders.
3. Preserve existing scheduler state when editing jobs.
4. Confirm the created schedule using concrete dates and local times.
