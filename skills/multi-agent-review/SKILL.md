---
name: multi-agent-review
description: Coordinate independent agent reviews, compare findings, dedupe issues, and produce a final verdict
---

# Multi-Agent Review

Use this skill when a change benefits from several independent reviewers or perspectives.

## Workflow

1. Define the review scope, files, risk areas, and expected output format.
2. Assign focused review prompts to separate agents or passes.
3. Collect findings with severity, file references, evidence, and reproduction notes.
4. Dedupe overlapping findings and reconcile disagreements.
5. Produce a concise final review with open questions and test gaps.

## Checks

- Do not let one reviewer see another's findings before independent analysis when independence matters.
- Prioritize actionable bugs over style preferences.
- Verify high-severity claims before reporting them.
- Keep the final summary traceable to source evidence.
