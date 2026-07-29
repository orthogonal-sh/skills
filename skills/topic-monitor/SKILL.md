---
name: topic-monitor
description: Monitor a topic over time and alert only on meaningful changes or new developments.
---

# Topic Monitor

Use this skill when the user wants ongoing monitoring of a product, company, competitor, technology, person, or event.

## When To Use

- Track launches, pricing changes, funding news, outages, or policy changes.
- Watch a narrow research topic and summarize only important updates.
- Maintain a recurring check that should not spam the user.

## Monitor Spec

Capture:

- Topic and synonyms
- Sources to check
- Alert threshold
- Cadence
- Quiet hours
- Where to record state

## Workflow

1. Search current sources.
2. Compare against the prior state file.
3. Classify changes as `none`, `minor`, `important`, or `urgent`.
4. Notify only when the threshold is met.
5. Update the state file with checked time, source URLs, and summary.

## State

Use a small JSON file when possible:

```json
{
  "topic": "example",
  "lastChecked": "2026-07-29T14:30:00Z",
  "seen": []
}
```
