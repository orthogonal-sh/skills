---
name: ai-research-reproduction
description: Reproduce AI research papers, experiments, and benchmarks
---

# AI Research Reproduction

Use this skill when a user wants to reproduce a paper, compare implementation claims, run a benchmark, or turn research into working code.

## Workflow

1. Find the paper, official repo, model cards, datasets, and benchmark definitions.
2. Record hardware, software versions, seeds, checkpoints, and licenses.
3. Build the smallest runnable reproduction first.
4. Compare metrics against the paper and note any deviations.
5. Package scripts, commands, logs, and caveats so the run can be repeated.

## Guardrails

- Prefer official code and datasets.
- Do not silently substitute datasets, checkpoints, or evaluation metrics.
- Separate confirmed results from inferred explanations.

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
