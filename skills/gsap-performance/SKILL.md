---
name: gsap-performance
description: Tune GSAP animation performance with timelines, rendering costs, cleanup, and runtime profiling
---

# GSAP Performance

Use this skill when diagnosing or improving GSAP animation performance.

## Workflow

1. Identify the animation target, timeline shape, trigger conditions, and runtime environment.
2. Profile frame rate, layout, paint, compositing, memory, and JavaScript work.
3. Prefer transform and opacity changes when they fit the design.
4. Batch setup, clean up contexts, and avoid duplicate timelines or listeners.
5. Re-test across responsive breakpoints and reduced-motion settings.

## Checks

- Avoid animating expensive layout properties without measuring.
- Clean up timelines, ScrollTriggers, and event handlers on unmount.
- Confirm the animation remains accessible and usable without motion.
- Inspect production builds, not only local dev behavior.
