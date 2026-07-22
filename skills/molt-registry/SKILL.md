---
name: molt-registry
description: Verify Moltbook identity registry entries and reputation metadata.
---

# Molt Registry

Use this skill when the user asks to verify a Moltbook identity, inspect registry status, manage profile metadata, or reason about agent reputation.

## Workflow

1. Identify the handle, profile, or registry entry to inspect.
2. Fetch registry metadata from the available trusted source.
3. Compare claimed identity, keys, profile links, and reputation signals.
4. Summarize confidence and any mismatches.
5. Ask before changing registry metadata.

## Guardrails

- Do not treat unverified claims as identity proof.
- Do not publish registry changes without explicit approval.
- Keep private identifiers out of public summaries.
