---
name: cron-writer
description: Convert natural-language schedules into cron expressions with timezone and edge-case checks.
---

# Cron Writer

Use this skill when a user asks for a cron expression or wants to verify a schedule.

## Stub Scope

- Ask or infer timezone when needed.
- Return the cron expression, plain-English interpretation, and next few run times.
- Flag impossible, ambiguous, or daylight-saving-sensitive schedules.

## Future Implementation Notes

- Add examples for standard cron, Quartz cron, GitHub Actions, and systemd timers.
- Add validation commands for local cron parsers.
