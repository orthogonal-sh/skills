---
name: llm-council
description: Gather independent implementation plans from multiple LLM workers and judge tradeoffs
---

# LLM Council

Use this skill when a decision benefits from several independent plans, critiques, or technical approaches before implementation.

## Workflow

1. Define the decision, constraints, and judging criteria.
2. Ask each council member for an independent answer.
3. Remove identifying bias where practical.
4. Compare plans by correctness, risk, cost, maintainability, and fit.
5. Return a recommended path with rejected alternatives.

## Safety

- Do not outsource secrets or private data to external models.
- Use the council for hard choices, not routine edits.
