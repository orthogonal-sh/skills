---
name: codex-quota
description: Inspect Codex CLI session logs to estimate remaining quota and usage
---

# Codex Quota

Use this skill when the user asks about Codex CLI quota, rate limits, model usage, session duration, or token burn.

## Workflow

1. Locate local Codex session and usage logs.
2. Parse recent model, token, and timing entries.
3. Group usage by day, model, and session.
4. Estimate remaining quota from known limits when available.
5. Flag uncertainty where logs do not expose provider-side counters.

## Output

- Report estimates plainly.
- Include the log time window used for the calculation.
