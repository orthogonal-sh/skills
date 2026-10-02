---
name: redis
description: Inspect, query, debug, and operate Redis caches, queues, streams, keys, memory, and connection issues.
---

# Redis

Use this skill when a task involves Redis, key-value caches, queues, streams, pub/sub, sessions, locks, memory use, or latency debugging.

## Workflow

- Identify the Redis instance, database, key patterns, client, and whether operations are read-only or mutating.
- Inspect key types, TTLs, memory, slow logs, connection counts, and relevant application usage before changing data.
- Avoid broad key scans or deletes in production unless explicitly approved and safely bounded.
- Verify behavior with targeted reads, metrics, application logs, and queue or stream state.
