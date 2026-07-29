---
name: lmstudio-subagents
description: Offload summarization, extraction, classification, and first-pass drafts to local LM Studio models.
---

# LM Studio Subagents

Use this skill when a task can save paid-model context by delegating low-risk subtasks to local LM Studio models.

## When To Use

- Summarize large logs, transcripts, or documents.
- Extract structured fields from repetitive text.
- Classify items before final review.
- Draft first-pass outlines or alternatives.

## Requirements

- LM Studio running a local server.
- A model selected that fits the subtask.

## Starter Request

```bash
curl -s http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "local-model",
    "messages": [
      {"role": "user", "content": "Summarize this text in 5 bullets: ..."}
    ]
  }'
```

## Guardrails

- Do not delegate secret-heavy or high-stakes decisions to weak local models.
- Treat local output as a draft, then verify before acting.
