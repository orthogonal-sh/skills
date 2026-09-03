---
name: process-watch
description: Inspect local processes, ports, resource usage, and runaway commands during troubleshooting.
---

# Process Watch

Use this skill when diagnosing high CPU, memory pressure, stuck development servers, busy ports, or runaway jobs.

## Workflow

1. Inspect active processes and resource usage with platform-appropriate tools.
2. Identify process owners, command lines, ports, and working directories.
3. Prefer graceful shutdown before terminating a process.
4. Report the process ID, command, and reason before any destructive action.
