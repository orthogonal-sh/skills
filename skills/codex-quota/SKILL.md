---
name: codex-quota
description: Check and reason about OpenAI Codex CLI quota, rate limits, and session usage.
---

# Codex Quota

Use this skill when a user asks about Codex usage, quota pressure, rate limits, or whether to route work to Codex.

## Workflow

- Inspect local Codex session or usage logs when available.
- Distinguish daily, weekly, and model-specific limits if the data supports it.
- Estimate whether a planned task is likely to fit the remaining quota.
- Recommend cheaper or local alternatives for low-value work.
- Avoid exposing raw tokens, credentials, or private transcript content unless needed.

## Output

Return current quota status, confidence, and a routing recommendation.
