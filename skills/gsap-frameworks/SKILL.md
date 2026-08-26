---
name: gsap-frameworks
description: Integrate GSAP across React, Next.js, Vue, Svelte, and SSR frameworks without lifecycle bugs
---

# GSAP Frameworks

Use this skill when integrating GSAP in a frontend framework or SSR app.

## Workflow

1. Identify the framework, rendering mode, hydration boundary, and animation target.
2. Run GSAP only where DOM APIs are available.
3. Scope selectors, refs, and timelines to the component or page section.
4. Clean up animations during route transitions and component unmount.
5. Verify SSR, hydration, and mobile behavior.

## Checks

- Guard browser-only code from server execution.
- Respect reduced-motion settings.
- Keep animation initialization idempotent.
- Validate no text or controls overlap during animation.
