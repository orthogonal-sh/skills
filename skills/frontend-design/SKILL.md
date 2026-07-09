---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with strong visual design and polish.
---

# Frontend Design

Guide for creating frontend interfaces that look intentionally designed — not like generic AI output. Covers typography, color, layout, animation, and the subtle details that separate polished work from templates.

## Avoiding the "AI Look"

AI-generated interfaces share telltale signs. Avoid these:

- **Excessive gradients** — especially purple-to-blue hero sections
- **Too-perfect symmetry** — real designs have intentional asymmetry and visual tension
- **Generic stock illustrations** — abstract blob people, isometric icons
- **Overuse of cards with rounded corners** — not everything needs to be a card
- **Default shadows everywhere** — shadow should convey hierarchy, not decoration
- **Too many colors** — good design uses restraint; 1-2 accent colors max
- **Hero sections with "Transform Your X"** — generic copy signals generic design
- **Centered everything** — left-aligned text is easier to read; center sparingly

## Typography

### Type Scale

Use a consistent scale. The 1.25 (Major Third) ratio works well for most UIs:

```
12px / 14px / 16px (base) / 20px / 25px / 31px / 39px / 49px
```

Or use CSS clamp for fluid typography:

```css
h1 { font-size: clamp(2rem, 5vw, 3.5rem); }
h2 { font-size: clamp(1.5rem, 3vw, 2.25rem); }
body { font-size: clamp(1rem, 1.5vw, 1.125rem); }
```

### Font Pairing Rules

1. **One font is often enough.** Use weight/size variations for hierarchy.
2. **If pairing:** contrast structure (serif heading + sans body, or vice versa).
3. **Safe modern pairs:**
   - Inter + Source Serif 4
   - DM Sans + DM Serif Display
   - Space Grotesk + Space Mono (for dev/tech)
   - Satoshi + Instrument Serif

### Line Height and Measure

- **Body text:** line-height 1.5–1.7, max-width 65ch
- **Headings:** line-height 1.1–1.3 (tighter is better for large text)
- **Small text/UI:** line-height 1.3–1.5

```css
p {
  font-size: 1rem;
  line-height: 1.6;
  max-width: 65ch;
  letter-spacing: -0.01em; /* slight tightening for body text */
}

h1 {
  font-size: 3rem;
  line-height: 1.1;
  letter-spacing: -0.03em; /* tighter tracking for headlines */
}
```

### Font Weight Strategy

Don't use every weight. Pick 3:
- **Regular (400)** — body text
- **Medium (500)** — emphasis, labels, navigation
- **Bold (700) or Semibold (600)** — headings, CTAs

## Color Theory

### Building a Palette

Start with one primary color, then derive the rest:

1. **Primary:** Your brand/accent color (1 hue)
2. **Neutral:** Gray scale derived from primary (desaturated version of primary hue)
3. **Semantic:** Success (green), warning (amber), error (red), info (blue)

```css
:root {
  /* Primary with HSL for easy manipulation */
  --primary-hue: 220;
  --primary: hsl(var(--primary-hue), 65%, 50%);
  --primary-light: hsl(var(--primary-hue), 65%, 95%);
  --primary-dark: hsl(var(--primary-hue), 65%, 35%);

  /* Neutrals tinted with primary hue */
  --gray-50: hsl(var(--primary-hue), 10%, 98%);
  --gray-100: hsl(var(--primary-hue), 8%, 95%);
  --gray-200: hsl(var(--primary-hue), 8%, 88%);
  --gray-500: hsl(var(--primary-hue), 5%, 50%);
  --gray-800: hsl(var(--primary-hue), 10%, 15%);
  --gray-900: hsl(var(--primary-hue), 12%, 8%);
}
```

### Contrast and Hierarchy

- **Text on background:** minimum 4.5:1 contrast ratio (WCAG AA)
- **Large text (18px+ bold, 24px+ regular):** minimum 3:1
- Use color weight to create depth: lighter backgrounds recede, darker elements advance
- **Don't use pure black (#000)** on pure white — it's harsh. Use near-black (#111, #1a1a1a)

### Dark Mode

Don't just invert. Dark mode needs its own palette:

```css
/* Light */
--bg: hsl(220, 10%, 98%);
--surface: hsl(220, 10%, 100%);
--text: hsl(220, 12%, 10%);
--text-secondary: hsl(220, 8%, 45%);

/* Dark - NOT just inverted */
--bg: hsl(220, 15%, 8%);
--surface: hsl(220, 12%, 12%); /* slightly lighter than bg */
--text: hsl(220, 10%, 90%); /* not pure white */
--text-secondary: hsl(220, 8%, 55%);
```

Key dark mode rules:
- Reduce saturation of colors (vivid colors are harsh on dark backgrounds)
- Elevate surfaces with slightly lighter backgrounds (not borders/shadows)
- Reduce font weight slightly (light text on dark appears heavier)

## Layout

### Spacing System

Use a consistent spacing scale based on multiples of 4 or 8:

```css
--space-1: 0.25rem;  /* 4px */
--space-2: 0.5rem;   /* 8px */
--space-3: 0.75rem;  /* 12px */
--space-4: 1rem;     /* 16px */
--space-6: 1.5rem;   /* 24px */
--space-8: 2rem;     /* 32px */
--space-12: 3rem;    /* 48px */
--space-16: 4rem;    /* 64px */
--space-24: 6rem;    /* 96px */
```

### Visual Hierarchy Without Boxes

Not everything needs a border or background. Create hierarchy through:

1. **Whitespace** — generous padding separates groups
2. **Typography** — size and weight differences
3. **Color** — lighter secondary text vs darker primary text
4. **Position** — proximity groups related items (Gestalt)

```css
/* Instead of boxing everything */
.section + .section {
  margin-top: var(--space-16);
  padding-top: var(--space-16);
  border-top: 1px solid var(--gray-100); /* subtle divider */
}
```

### Grid Systems

```css
/* Simple responsive grid */
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(min(300px, 100%), 1fr));
  gap: var(--space-6);
}

/* Asymmetric layouts feel more designed */
.layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: var(--space-8);
}

/* Bento-style grid */
.bento {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: 200px;
  gap: var(--space-4);
}
.bento .featured {
  grid-column: span 2;
  grid-row: span 2;
}
```

## Animation & Micro-interactions

### Principles

1. **Animations should have purpose** — guide attention, show state changes, provide feedback
2. **Duration:** 150–300ms for UI transitions, 300–500ms for page transitions
3. **Easing:** ease-out for entrances, ease-in for exits, ease-in-out for state changes
4. **Respect reduced motion:**

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Practical Animations

```css
/* Smooth hover state */
.card {
  transition: transform 200ms ease-out, box-shadow 200ms ease-out;
}
.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
}

/* Staggered entrance */
.list-item {
  opacity: 0;
  transform: translateY(8px);
  animation: fadeUp 300ms ease-out forwards;
}
.list-item:nth-child(1) { animation-delay: 0ms; }
.list-item:nth-child(2) { animation-delay: 50ms; }
.list-item:nth-child(3) { animation-delay: 100ms; }

@keyframes fadeUp {
  to { opacity: 1; transform: translateY(0); }
}

/* Skeleton loading pulse */
.skeleton {
  background: linear-gradient(90deg, var(--gray-100) 25%, var(--gray-50) 50%, var(--gray-100) 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
}
@keyframes shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
```

## Production Polish Checklist

Details that separate amateur from professional:

- [ ] **Focus states** — visible, styled focus rings on all interactive elements
- [ ] **Loading states** — skeletons, not spinners; progressive, not blocking
- [ ] **Empty states** — helpful message + CTA, not just "No data"
- [ ] **Error states** — specific, actionable messages; not raw error strings
- [ ] **Truncation** — long text handled with ellipsis or "show more"
- [ ] **Touch targets** — minimum 44×44px on mobile
- [ ] **Favicon + OG image** — first impressions matter
- [ ] **Scroll behavior** — smooth scroll, sticky headers if needed
- [ ] **Selection color** — custom `::selection` matching your palette
- [ ] **Consistent iconography** — one icon set, consistent stroke width and size
- [ ] **Responsive images** — srcset, proper aspect ratios, no layout shift
- [ ] **Form validation** — inline, real-time, specific error messages
