---
name: firebase-firestore-enterprise-native-mode
description: Model, query, secure, and migrate Firestore Enterprise native mode databases
---

# Firestore Enterprise Native Mode

Use this skill when working with Firestore Enterprise native mode schemas, indexes, queries, rules, migrations, or performance issues.

## Workflow

1. Identify collections, document shapes, access patterns, and consistency needs.
2. Design composite indexes around real query filters and sort orders.
3. Keep transactions and batch writes bounded and retry-aware.
4. Validate security rules with emulator tests when possible.
5. Measure read, write, and storage costs for the proposed shape.

## Checks

- Avoid hot documents and unbounded fanout writes.
- Prefer explicit denormalization over cross-collection joins.
- Check migration backfill idempotency.
- Verify production indexes before rollout.
