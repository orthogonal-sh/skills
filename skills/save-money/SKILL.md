---
name: save-money
description: Route work to cheaper models or tools based on task complexity and risk.
---

# Save Money

Use this skill when the user wants to reduce LLM or automation cost while preserving quality.

## Workflow

1. Classify the task by risk, context size, reasoning depth, tool use, and output importance.
2. Choose the cheapest model or tool that can reliably handle the task.
3. Escalate only for high-risk, ambiguous, long-context, or user-facing work.
4. Batch similar calls and reuse local context when possible.
5. Report meaningful tradeoffs when cost savings may affect quality.

## Guardrails

- Do not downshift safety-critical, legal, financial, medical, or public-send work.
- Prefer deterministic local tools for parsing, search, and formatting.
- Track failed downshifts so future routing improves.
