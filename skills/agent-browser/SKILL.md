---
name: agent-browser
description: Headless browser automation for agents using accessibility snapshots and structured page actions
---

# Agent Browser

Use this skill when a task needs browser navigation, page inspection, screenshots, form filling, or interaction with pages that do not expose a clean API.

## Source

- OpenClaw discovery: `agent-browser`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/agent-browser

## Stub Notes

- Prefer structured accessibility snapshots over brittle selectors.
- Keep login, payment, posting, and destructive actions behind explicit user approval.
- Record the page URL, intended action, and result when automating multi-step flows.

## Implementation TODO

- Add the concrete browser CLI or MCP command surface.
- Document install/auth requirements.
- Add safe examples for navigation, extraction, and screenshots.
