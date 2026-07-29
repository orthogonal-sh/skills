---
name: homey-cli
description: Control Homey smart home devices, zones, and flows from the command line.
---

# Homey CLI

Use this skill when a user wants to inspect or control a Homey home automation hub.

## When To Use

- List devices, zones, or flows.
- Check status for lights, plugs, thermostats, sensors, or locks.
- Trigger a Homey flow.
- Troubleshoot device connectivity.

## Starter Commands

```bash
homey devices list --json
homey zones list --json
homey flows list --json
```

## Safety

- Confirm before unlocking doors, disabling security, changing climate schedules, or running broad automations.
- Prefer status checks before state changes.
- Name the exact device and zone before acting.

## Output

Summarize the current state and any action taken with timestamps when available.
