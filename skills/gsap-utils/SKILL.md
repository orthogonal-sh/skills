---
name: gsap-utils
description: Use GSAP utility helpers for interpolation, snapping, wrapping, randomization, and reusable animation math
---

# GSAP Utils

Use this skill when implementing animation math with GSAP utility helpers.

## Workflow

1. Identify where interpolation, snapping, wrapping, clamping, mapping, or randomization is needed.
2. Prefer GSAP utility helpers over custom one-off math when they fit.
3. Keep reusable helpers pure and easy to test.
4. Validate animation output across initial, midpoint, and final states.
5. Check reduced-motion behavior for nonessential motion.

## Checks

- Avoid recreating helper functions on every render.
- Keep units explicit when mapping values to CSS.
- Test boundary values for clamp and wrap behavior.
- Ensure random values are acceptable for visual regression tests.
