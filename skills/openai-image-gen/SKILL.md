---
name: openai-image-gen
description: Generate and iterate bitmap image prompts with OpenAI image models.
---

# OpenAI Image Gen

Use this skill when the user asks to generate, revise, or batch-create raster images with OpenAI image models.

## Workflow

1. Clarify aspect ratio, style, subject, output count, and constraints.
2. Draft a prompt that names the subject, composition, medium, lighting, palette, and exclusions.
3. Generate images with the available image tool or provide an API-ready request.
4. Review outputs against the brief and propose focused revisions.
5. Save prompt variants and final asset notes when useful.

## Guardrails

- Do not use this for vector icons or repo-native SVG edits.
- Preserve brand, likeness, and safety constraints.
- Make iteration prompts specific rather than starting over blindly.
