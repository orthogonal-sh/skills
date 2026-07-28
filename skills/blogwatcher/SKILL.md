---
name: blogwatcher
description: Monitor blogs and RSS or Atom feeds for new posts and summarize updates
---

# Blogwatcher

Use this skill when the user wants to watch blogs, changelogs, RSS/Atom feeds, release notes, or competitor content for updates.

## Workflow

1. Collect feed URLs or discover feeds from site URLs.
2. Store feed state locally with last-seen item IDs or timestamps.
3. Fetch updates and deduplicate by canonical URL.
4. Summarize new posts with title, date, source, and why it matters.
5. Create a scheduled check only after the user approves cadence and delivery channel.

## Notes

- Prefer RSS/Atom over scraping pages.
- Keep source links with each summary.
