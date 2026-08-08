---
name: sql-gen
description: Generate, explain, and validate SQL queries from schema, requirements, and examples.
---

# SQL Query Generator

Use this skill when the user needs SQL written or explained.

## Workflow

1. Gather dialect, schema, table relationships, sample rows, and desired output.
2. Write the query with explicit columns, joins, filters, grouping, and ordering.
3. Explain assumptions and edge cases.
4. Provide indexes or performance notes when the query may be expensive.
5. If execution is available and safe, validate against test data.

## Guardrails

Do not access production databases directly unless explicitly allowed in the environment instructions.
