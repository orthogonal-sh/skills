---
name: gemini-youtube-transcript
description: Transcribe YouTube videos with Gemini, speaker labels, paragraph breaks, and clean transcript output.
---

# Gemini YouTube Transcript

Use this skill when the user asks for a YouTube transcript, quotes from a video, or a structured summary derived from video speech.

## Workflow

1. Validate the YouTube URL and capture title, duration, and language when available.
2. Use Gemini or the configured transcript tool to extract speech.
3. Add speaker labels when supported and preserve paragraph breaks.
4. Provide transcript, summary, timestamps, or action items based on the request.

## Safety

- Make clear when timestamps are approximate.
- Avoid long verbatim copyrighted excerpts unless the user provided the content or the excerpt is brief.
