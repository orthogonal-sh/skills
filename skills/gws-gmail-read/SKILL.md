---
name: gws-gmail-read
description: Read Gmail messages with Google Workspace CLI, filters, labels, threads, and privacy-aware summaries
---

# Google Workspace Gmail Read

Use this skill when reading Gmail through the Google Workspace CLI or equivalent Google APIs.

## Workflow

1. Identify the account, mailbox scope, labels, query, and time range.
2. Fetch only the messages needed for the task.
3. Summarize sender, subject, date, and actionable content.
4. Preserve privacy by omitting irrelevant personal details.
5. Link or reference message IDs when follow-up actions are needed.

## Checks

- Do not expose credentials or raw tokens.
- Avoid broad mailbox searches when a focused query works.
- Separate unread, starred, sent, and archived states.
- Ask before sending or modifying mail unless explicitly instructed.
