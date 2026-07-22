---
name: hn-digest
description: Fetch, filter, and summarize Hacker News stories by rank, topic, or discussion signal.
---

# HN Digest

Use this skill when the user asks for Hacker News front page, top stories, topic-specific HN items, or discussion summaries.

## Workflow

1. Clarify topic filters, story count, and whether comments matter.
2. Fetch current HN story metadata and URLs.
3. Filter for relevance, novelty, score, and comment signal.
4. Summarize each item in one or two sentences.
5. Highlight themes, controversies, and follow-up links.

## Guardrails

- Use current data for live HN requests.
- Distinguish article content from comment sentiment.
- Avoid summarizing unread linked articles as if fully reviewed.
