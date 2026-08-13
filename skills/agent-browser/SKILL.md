---
name: agent-browser
description: Drive a headless browser for navigation, form filling, screenshots, and accessibility-tree inspection.
---

# Agent Browser

Use this skill when a task needs repeatable browser automation without opening a local desktop browser.

## Workflow

1. Start a browser session with the target URL.
2. Inspect the page through structured snapshots or accessibility trees.
3. Execute clicks, typing, screenshots, or extraction steps.
4. Close the browser session and summarize the observed result.

## Notes

- Prefer stable element refs over pixel coordinates.
- Capture evidence when validating user-visible flows.
