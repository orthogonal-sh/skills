---
name: local-whisper
description: Transcribe audio locally with Whisper models without sending media to cloud APIs.
---

# Local Whisper

Use this skill when a user asks to transcribe audio locally or wants speech-to-text with privacy constraints.

## Stub Scope

- Prefer local model execution when media should not leave the machine.
- Report model, language, timestamps, and confidence caveats where available.
- Keep original media paths and generated transcripts organized.

## Future Implementation Notes

- Add install and usage examples for whisper.cpp, OpenAI Whisper, or faster-whisper.
- Add workflows for long files, diarization handoff, subtitle export, and batch transcription.
