---
name: golang-performance
description: Profile and improve Go CPU, memory, allocations, latency, concurrency, and benchmark behavior
---

# Go Performance

Use this skill when diagnosing or improving Go performance.

## Workflow

1. Define the target metric: latency, throughput, CPU, memory, allocations, or startup time.
2. Reproduce with a benchmark, profile, trace, or production sample.
3. Inspect hot paths before changing code.
4. Make one measurable optimization at a time.
5. Re-run benchmarks and compare before and after results.

## Checks

- Use `pprof`, `trace`, benchmarks, and race checks as appropriate.
- Watch allocation churn in loops and serialization paths.
- Avoid making code less clear for unmeasured wins.
- Include representative input sizes.
