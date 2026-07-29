---
name: multi-llm
description: Route tasks across multiple LLM providers or local models based on cost, context, latency, and capability.
---

# Multi LLM

Use this skill when a workflow can choose among several models instead of assuming one provider.

## When To Use

- Pick a model for coding, summarization, extraction, research, or creative drafting.
- Fall back when a provider is unavailable.
- Reduce cost by using smaller models for simple subtasks.
- Compare outputs from multiple models for uncertain work.

## Routing Factors

- Task risk
- Needed context length
- Tool-use support
- Latency tolerance
- Cost ceiling
- Privacy requirements

## Pattern

1. Classify the subtask.
2. Pick the cheapest capable model.
3. Escalate only when quality, context, or safety requires it.
4. Log the model used for reproducibility.

## Guardrails

Do not send private or regulated data to providers that are not approved for that data.
