---
name: rssaurus-cli
description: Read RSS feeds and items from RSSaurus with an agent-friendly command-line client.
---

# RSSaurus CLI

Use this skill when a task needs terminal access to RSSaurus feeds, items, and source URLs.

## When To Use

- Check subscribed feeds for updates.
- Pull article URLs for research or monitoring.
- Summarize unread items.
- Build lightweight feed-based topic monitoring.

## Starter Commands

```bash
rssaurus auth whoami
rssaurus feeds list --json
rssaurus items list --limit 20 --json
```

## Workflow

1. Authenticate if needed.
2. List feeds or filter by topic.
3. Fetch recent items as JSON.
4. Open only the relevant item URLs.
5. Track seen IDs for recurring jobs.

## Notes

- Prefer JSON output for automation.
- Avoid reposting duplicate feed items by storing item IDs or URLs.
