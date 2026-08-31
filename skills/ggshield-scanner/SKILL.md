---
name: ggshield-scanner
description: Scan code and commits for leaked secrets with ggshield
---

# ggshield Secret Scanner

Use ggshield-scanner when checking repositories, commits, or files for hardcoded secrets before they reach GitHub.

## Capabilities

- Scan working trees, staged changes, commits, and CI contexts
- Detect common API keys, tokens, credentials, and private material
- Report remediation guidance without exposing full secret values

## Workflow

1. Identify the scan scope: files, repo, staged changes, or commit range.
2. Run ggshield with output suitable for automation.
3. Triage findings and redact sensitive values in summaries.
4. Recommend rotation, removal, and history cleanup when needed.

## Notes

- Never paste full secrets into chat or logs.
- Treat positive findings as urgent until proven false.
