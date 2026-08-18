---
name: swiftui-performance-audit
description: Audit SwiftUI performance issues including rendering churn, janky scrolling, CPU, and memory usage
---

# SwiftUI Performance Audit

Use this skill when reviewing or fixing SwiftUI code with slow rendering, excessive view updates, janky scrolling, high CPU, or memory pressure.

## Source

- OpenClaw discovery: `swiftui-performance-audit`
- Reference: https://github.com/sundial-org/awesome-openclaw-skills/tree/main/skills/swiftui-performance-audit

## Stub Notes

- Inspect view identity, state ownership, list rendering, async work, and image loading.
- Prefer targeted fixes over broad rewrites.
- Verify improvements with Instruments, logs, or reproducible UI tests when possible.

## Implementation TODO

- Add audit checklist for common SwiftUI performance traps.
- Document measurement tools and before/after reporting.
- Add examples for lists, animations, async tasks, and view models.
