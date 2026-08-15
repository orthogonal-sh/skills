---
name: sonarr
description: Search, add, monitor, and troubleshoot TV series through a Sonarr instance.
---

# Sonarr

Use this skill when the user asks to find, add, monitor, or troubleshoot TV series in Sonarr.

## Workflow

1. Confirm the target Sonarr instance and series title.
2. Search the Sonarr API for matching series.
3. Present the likely match, quality profile, root folder, language profile, and monitoring choice.
4. Add or update the series only after confirmation.
5. For troubleshooting, inspect queue, history, missing episodes, indexer errors, and download client status.

## Safety

- Never delete series, files, or history without explicit confirmation.
- Do not expose API keys in chat or logs.
