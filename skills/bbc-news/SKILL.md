---
name: bbc-news
description: Fetch and summarize BBC News headlines, sections, regions, and RSS feeds.
---

# BBC News

Use this skill when the user asks for BBC News headlines, UK news, world news, section summaries, or BBC RSS feed digests.

## Workflow

1. Clarify region, section, topic, and recency.
2. Fetch current BBC News feed or article metadata.
3. Summarize headlines with source links and timestamps.
4. Group stories by theme when returning a digest.
5. Cross-check breaking or high-stakes stories with another source when needed.

## Guardrails

- Do not present stale headlines as current.
- Keep summaries short and clearly attributed.
- Avoid copying article text beyond brief excerpts.
