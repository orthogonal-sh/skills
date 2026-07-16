---
name: context-optimizer
description: Optimize agent context with compaction, summarization, relevance pruning, and retrieval-aware handoffs.
---

# Context Optimizer

Use this skill when a session, project, or prompt is getting too large and the agent needs to preserve the useful parts while reducing noise.

## Workflow

- Identify the current goal, constraints, decisions, active files, blockers, and next actions.
- Separate durable facts from transient chat history.
- Compress repeated or low-signal material into short summaries.
- Preserve exact commands, file paths, identifiers, and user preferences that may be needed later.
- Produce a compact handoff that another agent can use without rereading the whole history.

## Output

Return a concise context pack with:

- Goal.
- Current state.
- Key decisions.
- Important references.
- Open risks.
- Next steps.
