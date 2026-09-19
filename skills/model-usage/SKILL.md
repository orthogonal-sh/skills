---
name: model-usage
description: Summarize per-model usage, recent model activity, token spend, and local AI session costs.
---

# Model Usage

Use when a user asks what models were used, how much quota or cost a session consumed, or which recent model is active.

## Suggested Workflow

- Inspect configured local usage logs before estimating.
- Group by model, provider, date, and session when possible.
- Report unknowns when provider-side billing data is unavailable.
- Avoid exposing private prompt content unless the user explicitly asks for session details.

## Candidate Sources

- OpenClaw `model-usage`
- Local Codex, Claude, or provider usage logs
