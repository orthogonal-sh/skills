---
name: gotify
description: Send Gotify push notifications for completed jobs, alerts, and long-running task updates.
---

# Gotify

Use this skill when the user wants lightweight push notifications through a Gotify server.

## When To Use

- Notify when a long-running command finishes.
- Send important monitoring alerts.
- Report a cron or background job result.
- Push a concise summary to a phone or desktop client.

## Send Notification

```bash
curl -s "$GOTIFY_URL/message" \
  -H "X-Gotify-Key: $GOTIFY_APP_TOKEN" \
  -F "title=Job complete" \
  -F "message=Backup finished successfully" \
  -F "priority=5"
```

## Message Guidelines

- Keep titles short.
- Include action needed, if any.
- Avoid secrets, tokens, or private raw logs.

## Safety

Do not send notifications to shared devices unless the content is safe for that audience.
