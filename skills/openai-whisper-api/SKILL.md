---
name: openai-whisper-api
description: Transcribe and translate audio with OpenAI Whisper-style APIs, timestamps, subtitles, batches, and transcript QA.
---

# OpenAI Whisper API

Use this skill when a task involves audio transcription, translation, subtitle generation, diarization preparation, transcript cleanup, or Whisper-compatible API workflows.

## Workflow

- Identify the audio sources, language expectations, timestamp needs, output format, and privacy constraints.
- Prefer chunked or batched processing for long media, preserving filenames and timing metadata.
- Normalize transcript text only after preserving a raw output copy when accuracy matters.
- Verify results with spot checks against representative audio segments and report uncertain sections.
