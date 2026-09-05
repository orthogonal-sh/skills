---
name: skilllens-audit
description: Audit local agent skills for trigger clarity, safety, packaging, and prompt-injection risk.
---

# SkillLens Audit

Use when reviewing installed or proposed agent skills for safety, maintainability, and usefulness.

## Workflow

1. Inventory skill locations, manifests, and referenced assets.
2. Check trigger specificity, permissions, external actions, and private-data handling.
3. Flag hidden instructions, broad authority, and unsafe shell patterns.
4. Recommend small fixes before large rewrites.
5. Produce a findings-first report with file references.
