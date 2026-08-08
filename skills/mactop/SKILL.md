---
name: mactop
description: Inspect Apple Silicon CPU, GPU, memory, thermal, power, network, and disk metrics with mactop.
---

# mactop

Use this skill when diagnosing local Apple Silicon performance or hardware pressure.

## Workflow

1. Confirm the symptom, process, workload, and time window.
2. Run or parse `mactop` metrics in a machine-readable format when available.
3. Review CPU, GPU, ANE, memory pressure, swap, thermal state, power, and IO.
4. Correlate spikes with processes or workload phases.
5. Recommend focused mitigations or deeper profiling.

## Output

Return a concise hardware health summary with any notable limits or bottlenecks.
