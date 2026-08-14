---
name: skill-scanner
description: Scan agent skills for suspicious code, secrets, supply-chain risks, and unsafe install behavior before adding them.
---

# Skill Scanner

Use this skill when reviewing third-party agent skills before installation, publication, or recommendation.

## Scope

- Inspect `SKILL.md`, scripts, package manifests, install commands, and referenced URLs.
- Flag secrets, exfiltration paths, destructive commands, unexpected network calls, and risky postinstall hooks.
- Produce a short risk summary with recommended next steps.

## Source

Discovered from skills.sh and awesome-openclaw-skills.

## TODO

- Add concrete scanner commands and a rubric for low, medium, and high-risk findings.
