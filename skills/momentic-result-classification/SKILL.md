---
name: momentic-result-classification
description: Classify Momentic test results, separate product defects from test flakes, and produce actionable failure summaries.
---

# Momentic Result Classification

Use this skill when analyzing Momentic test results or triaging browser-test failures.

## Workflow

1. Collect failing steps, assertions, screenshots, traces, logs, and recent code changes.
2. Classify each failure as product regression, environment issue, test bug, data issue, or flake.
3. Recommend the smallest next action: fix code, update selector, seed data, retry, or quarantine.
4. Keep summaries short and include evidence for each classification.

## Source

Discovered from `skills.sh`: `momentic-ai/skills` / `momentic-result-classification`.
