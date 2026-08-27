---
name: documenting-contracts
description: Document API, event, schema, and service contracts with examples, invariants, and compatibility rules
---

# Documenting Contracts

Use this skill when documenting interfaces between systems or teams.

## Workflow

1. Identify producers, consumers, transport, schema source, and versioning model.
2. Document fields, types, required values, defaults, limits, and invariants.
3. Include examples for success, failure, empty, and edge-case payloads.
4. Describe compatibility rules, deprecations, migrations, and ownership.
5. Link contract tests, OpenAPI specs, protobufs, schemas, or fixtures.

## Checks

- Keep generated specs and prose consistent.
- Call out nullable, optional, and omitted values precisely.
- Include auth, rate limits, idempotency, and error semantics when relevant.
- Treat undocumented behavior as a risk, not an implied guarantee.
