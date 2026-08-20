---
name: run-train
description: Run and document ML training or fine-tuning jobs
---

# Run Train

Use this skill when a user asks to launch, debug, or document a model training, fine-tuning, or evaluation run.

## Workflow

1. Identify the training entry point, config, dataset, checkpoint, and output directory.
2. Verify hardware requirements, dependency versions, and auth-free data access.
3. Start with a tiny dry run or overfit batch when possible.
4. Record exact commands, seeds, metrics, logs, and generated artifacts.
5. Summarize cost, runtime, result quality, and next experiment choices.

## Guardrails

- Do not use private datasets unless the user provided them for this task.
- Avoid long or expensive jobs without clear user intent.

## Source

Discovered from skills.sh trending: `lllllllama/rigorpilot-skills`.
