---
name: xurl
description: Inspect, expand, normalize, archive, and diagnose URLs, redirects, headers, tracking params, and link safety.
---

# xurl

Use this skill when a task involves URL expansion, redirect tracing, header inspection, canonicalization, tracking-parameter cleanup, or link safety checks.

## Workflow

- Capture the original URL exactly before normalization or expansion.
- Inspect redirects, status codes, headers, canonical URLs, and final destinations.
- Avoid fetching sensitive or suspicious links in contexts that may leak credentials or local metadata.
- Return the cleaned URL, redirect chain, and any safety or availability notes.
