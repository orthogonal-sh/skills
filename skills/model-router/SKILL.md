---
name: model-router
description: Choose models by task type, cost, latency, tool needs, and required accuracy.
---

# Model Router

Use this skill when selecting an AI model or deciding whether to switch models during a task.

## Workflow

- Classify the task by risk, complexity, modality, context size, and tool requirements.
- Prefer cheaper or faster models for simple extraction, formatting, and classification.
- Use stronger reasoning models for architecture, debugging, security, financial, legal, or ambiguous decisions.
- Consider context window, structured output support, multimodal needs, and latency.
- Reevaluate the choice when the task changes.

## Output

Return the recommended model or model class with a brief reason and fallback.
