---
name: llm-council
description: Run a multi-model planning council and synthesize independent proposals before implementation.
---

# LLM Council

Use this skill when a hard design, debugging, or planning problem benefits from several independent model perspectives.

## When To Use

- Architecture decisions with meaningful tradeoffs.
- Complex bugs where one hypothesis may tunnel vision the solution.
- Product or strategy questions that need critique from multiple roles.
- Implementation plans where risk review matters.

## Process

1. Write a neutral problem statement.
2. Ask each council member for an independent plan or critique.
3. Hide prior answers from later council members unless doing an explicit debate round.
4. Compare recommendations by evidence, risk, reversibility, and fit with constraints.
5. Produce one final recommendation with dissenting notes.

## Suggested Roles

- Implementer
- Reviewer
- Reliability engineer
- Product operator
- Security skeptic

## Guardrails

- Do not let the council replace direct code or source inspection.
- Prefer a small council for normal work and reserve larger rounds for genuinely ambiguous decisions.
