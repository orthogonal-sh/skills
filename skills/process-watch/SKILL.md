---
name: process-watch
description: Monitor processes, ports, CPU, memory, disk IO, and resource hot spots
---

# Process Watch

Use this skill when diagnosing slow machines, runaway processes, stuck dev servers, port conflicts, or resource-heavy commands.

## Workflow

1. Inspect active processes, ports, CPU, memory, disk, and network use.
2. Identify the likely culprit with command, PID, owner, and start time.
3. Check logs or child processes when needed.
4. Recommend or perform a safe intervention.
5. Verify resource usage after the intervention.

## Safety

- Ask before killing unrelated or user-owned long-running processes.
- Prefer graceful termination before forceful signals.
