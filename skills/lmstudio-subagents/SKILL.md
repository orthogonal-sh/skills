---
name: lmstudio-subagents
description: Offload summarization, extraction, classification, and first-pass work to local LM Studio models.
---

# LM Studio Subagents

Use this skill when a task can be delegated to a local model to reduce hosted-model cost or preserve privacy.

## Workflow

1. Select low-risk subtasks suitable for a local model.
2. Send only the minimum required context.
3. Validate local-model output before acting on it.
4. Use the primary agent for final judgment, edits, and user-facing conclusions.
