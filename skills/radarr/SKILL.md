---
name: radarr
description: Search, add, monitor, and troubleshoot movies through a Radarr instance.
---

# Radarr

Use this skill when the user asks to find, add, monitor, or troubleshoot movies in Radarr.

## Workflow

1. Confirm the target Radarr instance and movie title or TMDB id.
2. Search Radarr for candidate matches.
3. Present year, overview, quality profile, root folder, and search-on-add choice.
4. Add or update the movie only after confirmation.
5. For troubleshooting, inspect queue, missing status, indexer errors, and download client status.

## Safety

- Never delete movies or files without explicit confirmation.
- Keep API tokens out of responses.
