---
name: skills-audit
description: Audit installed agent skills for security, privacy, quality, and operational risk.
---

# SkillLens Audit

Use this skill when reviewing local or third-party agent skills before installation, publication, or use.

## Checklist

- Check for secret exfiltration, unsafe shell commands, hidden network calls, credential handling, and destructive actions.
- Verify that trigger conditions are specific and not overly broad.
- Look for prompt injection risks and instructions that override user or system boundaries.
- Confirm required tools, environment variables, and external services are documented.
- Rate the skill as approve, revise, quarantine, or reject.

## Output

Report findings by severity with file references and recommended fixes.
