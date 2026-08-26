---
name: golang-database
description: Build Go database code with transactions, pooling, migrations, query shape, and test coverage
---

# Go Database

Use this skill when implementing or reviewing database access in Go services.

## Workflow

1. Identify the database driver, query library, migration system, and transaction boundaries.
2. Keep SQL, parameters, scanning, and error handling explicit.
3. Use contexts with deadlines for database calls.
4. Add tests for successful queries, missing rows, constraint failures, and transaction rollback.
5. Review connection pooling, indexes, and query plans for hot paths.

## Checks

- Avoid string-built SQL with user input.
- Distinguish not-found errors from real failures.
- Keep migrations reversible or clearly forward-only.
- Close rows and release resources promptly.
