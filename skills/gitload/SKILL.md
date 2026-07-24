---
name: gitload
description: Download, inspect, and copy selected files or folders from GitHub repositories.
---

# Gitload

Use this skill when the user wants to fetch files, folders, examples, or code from a GitHub repository.

## Stub Scope

- Prefer official repository contents, release artifacts, or raw file URLs.
- Respect licenses and avoid copying more code than the task requires.
- Keep fetched code isolated until reviewed.

## Future Implementation Notes

- Add GitHub archive, sparse checkout, gh api, and raw download recipes.
- Add workflows for copying only selected paths into a target project.
