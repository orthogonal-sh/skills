---
name: manus
description: Create and manage autonomous Manus AI agent tasks through the Manus API
---

# Manus AI Agent

Use this skill when a user wants to delegate a self-contained browsing, research, or creation task to Manus and track its result.

## Source

- OpenClaw discovery: `manus`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/manus

## Stub Notes

- Define the expected artifact, constraints, and completion criteria before delegation.
- Do not delegate work involving private credentials or external actions without explicit approval.
- Poll and summarize task status instead of leaving long-running jobs opaque.

## Implementation TODO

- Add Manus API auth and task lifecycle commands.
- Document create, inspect, cancel, and result retrieval flows.
- Add examples for research and web automation tasks.
