---
name: byterover-headless
description: Query and curate project knowledge with the ByteRover CLI from headless agent sessions.
---

# ByteRover Headless

Use this skill when an agent needs persistent project knowledge through ByteRover's headless CLI.

## When To Use

- Search project memory before making code or architecture decisions.
- Curate reusable findings after debugging, reviews, or implementation work.
- Sync a ByteRover context tree between machines or agent sessions.

## Starter Flow

1. Confirm the `brv` CLI is installed and authenticated.
2. Query existing knowledge before acting:

```bash
brv query "authentication patterns in this repo"
```

3. Curate durable discoveries with enough context to be useful later:

```bash
brv curate "The API client retries 429s with exponential backoff in src/api/client.ts."
```

4. Push or pull the context tree when working across environments:

```bash
brv pull
brv push
```

## Notes

- Prefer concise, verifiable memories over full transcripts.
- Include file paths, command names, and decision rationale when storing project facts.
