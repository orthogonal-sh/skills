---
name: redshift-guide
description: Operate Amazon Redshift schemas, queries, loading, permissions, performance, and cost controls
---

# Redshift Guide

Use this skill when working with Amazon Redshift data warehouses.

## Workflow

1. Identify cluster or serverless setup, schemas, data sources, workload, and permissions.
2. Review table design, sort keys, distribution, compression, and load patterns.
3. Inspect query plans, queues, concurrency, materialized views, and maintenance tasks.
4. Tune incrementally and validate with representative query timings.
5. Document operational checks, backup, security, and cost controls.

## Checks

- Avoid direct production data changes without an approved path.
- Keep PII and access boundaries explicit.
- Verify vacuum, analyze, and statistics needs.
- Watch scan volume, queue time, and storage growth.
