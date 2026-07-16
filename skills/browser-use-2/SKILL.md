---
name: browser-use-2
description: Use cloud browser automation for scraping, form filling, navigation, and web task execution.
---

# Browser Use API

Use this skill when a task requires AI-driven browser interaction beyond simple HTTP fetches, such as form filling, login flows, screenshots, or multi-step extraction.

## Workflow

- Define the target URL, task, success criteria, and data to collect.
- Prefer accessible selectors and visible state over brittle coordinates.
- Keep credentials and private data out of prompts unless explicitly required and authorized.
- Capture screenshots, HTML, or structured results for verification.
- Retry with narrower instructions when automation gets stuck.

## Output

Return the completed action, extracted data, and verification evidence.
