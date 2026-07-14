---
name: a11y-checker
description: Audit web pages and UI changes for accessibility issues, WCAG risks, keyboard traps, and screen reader regressions.
---

# Accessibility Checker

Use this skill when asked to review a page, component, or design for accessibility, or when frontend changes need an accessibility pass before shipping.

## Checklist

- Identify the target URL, local route, or changed component.
- Run automated checks with the available accessibility toolchain, such as axe, Lighthouse, Playwright accessibility snapshots, or the project test suite.
- Manually check keyboard navigation, focus order, visible focus states, labels, form errors, color contrast, headings, landmarks, and dynamic announcements.
- Report issues with severity, affected element, reproduction steps, and a concrete fix.

## Output

Keep the result actionable:

- What was checked.
- Blocking issues.
- Non-blocking improvements.
- Tests or manual checks performed.
