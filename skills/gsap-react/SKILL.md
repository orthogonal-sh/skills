---
name: gsap-react
description: Build React animations with GSAP contexts, cleanup, refs, timelines, and lifecycle-safe hooks
---

# GSAP React

Use this skill when adding or reviewing GSAP animations in React.

## Workflow

1. Identify component ownership, refs, timeline lifecycle, and trigger conditions.
2. Use scoped GSAP contexts or the project-standard React integration.
3. Clean up animations on unmount and dependency changes.
4. Keep animation state separate from application state unless interaction requires it.
5. Test mount, rerender, route change, and reduced-motion cases.

## Checks

- Avoid querying outside the component scope.
- Do not animate layout-critical content before it is measured.
- Prevent duplicate timelines in strict mode.
- Keep interactive controls keyboard accessible.
