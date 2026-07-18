---
name: cron-mastery
description: Design, debug, and harden OpenClaw cron schedules, reminders, and recurring jobs.
---

# Cron Mastery

Use this skill when creating or debugging cron jobs, reminders, scheduled workflows, or recurring maintenance tasks.

## Workflow

1. Convert the user's schedule into an explicit timezone and recurrence.
2. Check edge cases such as weekends, daylight saving changes, and missed runs.
3. Keep payloads small, idempotent, and easy to audit.
4. Record the job ID and next expected run when available.

## Notes

- Use cron for precise timing.
- Use heartbeat style checks for flexible background monitoring.
