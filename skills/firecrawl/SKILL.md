---
name: firecrawl
description: Crawl, scrape, map, and extract web pages with Firecrawl-style workflows and structured output checks.
---

# Firecrawl

Use this skill when a task asks for web crawling, page scraping, URL mapping, markdown extraction, or structured extraction suitable for agent workflows.

## Workflow

- Clarify the target URLs, crawl depth, freshness needs, output schema, and robots/legal constraints.
- Choose the smallest crawl or scrape that can answer the task, and preserve source URLs for traceability.
- Normalize extracted content into the requested structure, dedupe repeated navigation text, and flag missing or blocked pages.
- Verify a sample of results against the source pages before using the data downstream.
