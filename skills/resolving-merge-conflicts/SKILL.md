---
name: resolving-merge-conflicts
description: Resolve merge conflicts by preserving intent from both sides and verifying behavior.
---

# Resolving Merge Conflicts

Use this skill when a merge, rebase, cherry-pick, or patch application produces conflicts.

## Workflow

1. Inspect both sides of each conflict and the common surrounding code.
2. Identify the intent of each change before editing.
3. Resolve with the smallest combined change that preserves intended behavior.
4. Run formatting and targeted tests for the conflicted area.
5. Review the final diff to catch accidental deletions or duplicated logic.

Never discard one side just to make the conflict disappear.
