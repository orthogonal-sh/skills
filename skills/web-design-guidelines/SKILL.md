---
name: web-design-guidelines
description: Web accessibility (WCAG), responsive design, semantic HTML, performance, and progressive enhancement best practices.
---

# Web Design Guidelines

Standards and best practices for building web interfaces that are accessible, performant, responsive, and semantically correct. Apply these principles to every web project.

## Semantic HTML

Use HTML elements for their meaning, not their appearance:

```html
<!-- ❌ Div soup -->
<div class="header">
  <div class="nav">
    <div class="nav-item" onclick="goto('/')">Home</div>
  </div>
</div>
<div class="main">
  <div class="article">
    <div class="title">Article Title</div>
    <div class="content">...</div>
  </div>
  <div class="sidebar">...</div>
</div>
<div class="footer">...</div>

<!-- ✅ Semantic structure -->
<header>
  <nav aria-label="Main navigation">
    <a href="/">Home</a>
  </nav>
</header>
<main>
  <article>
    <h1>Article Title</h1>
    <p>...</p>
  </article>
  <aside aria-label="Related content">...</aside>
</main>
<footer>...</footer>
```

### Key Semantic Elements

| Element | Use For |
|---------|---------|
| `<header>` | Introductory content, navigation |
| `<nav>` | Navigation links (use `aria-label` if multiple navs) |
| `<main>` | Primary page content (one per page) |
| `<article>` | Self-contained content (blog post, comment, widget) |
| `<section>` | Thematic grouping with a heading |
| `<aside>` | Tangentially related content (sidebar, callout) |
| `<figure>` / `<figcaption>` | Images, diagrams, code with captions |
| `<details>` / `<summary>` | Expandable content (native accordion) |
| `<time>` | Dates and times (`datetime` attribute) |
| `<mark>` | Highlighted/relevant text |
| `<output>` | Result of a calculation or user action |

### Heading Hierarchy

Always maintain a logical heading order. Never skip levels for styling:

```html
<!-- ❌ Skipping from h1 to h4 -->
<h1>Page Title</h1>
<h4>Section Title</h4>

<!-- ✅ Logical hierarchy -->
<h1>Page Title</h1>
  <h2>Section Title</h2>
    <h3>Subsection</h3>
  <h2>Another Section</h2>
```

## Accessibility (WCAG)

### The Four Principles (POUR)

1. **Perceivable** — content can be perceived through sight, hearing, or touch
2. **Operable** — interface can be used with keyboard, mouse, touch, voice
3. **Understandable** — content and UI are clear and predictable
4. **Robust** — works across assistive technologies and browsers

### Essential Checklist

#### Images and Media

```html
<!-- Informative image: describe the content -->
<img src="chart.png" alt="Revenue grew 40% from Q1 to Q4 2024" />

<!-- Decorative image: empty alt -->
<img src="decorative-swirl.svg" alt="" role="presentation" />

<!-- Complex image: extended description -->
<figure>
  <img src="org-chart.png" alt="Organization chart showing reporting structure" />
  <figcaption>
    CEO reports to Board. Three VPs report to CEO: VP Engineering, VP Sales, VP Marketing.
  </figcaption>
</figure>

<!-- Video: captions + transcript -->
<video controls>
  <source src="demo.mp4" type="video/mp4" />
  <track kind="captions" src="captions.vtt" srclang="en" label="English" default />
</video>
```

#### Forms

```html
<!-- ✅ Every input needs a label -->
<label for="email">Email address</label>
<input type="email" id="email" name="email" required
  aria-describedby="email-hint email-error"
  aria-invalid="false" />
<p id="email-hint" class="hint">We'll never share your email.</p>
<p id="email-error" class="error" role="alert" hidden>Please enter a valid email.</p>

<!-- Group related fields -->
<fieldset>
  <legend>Shipping Address</legend>
  <label for="street">Street</label>
  <input type="text" id="street" name="street" autocomplete="street-address" />
  <!-- ... -->
</fieldset>
```

#### Keyboard Navigation

- All interactive elements must be reachable via Tab
- Logical tab order (follows visual order, or use `tabindex="0"`)
- Never use `tabindex` > 0
- Visible focus indicators on all interactive elements
- Custom widgets need full keyboard support:

```html
<!-- Custom dropdown needs keyboard handling -->
<div role="listbox" aria-label="Select country" tabindex="0"
  aria-activedescendant="option-us">
  <div role="option" id="option-us" aria-selected="true">United States</div>
  <div role="option" id="option-uk" aria-selected="false">United Kingdom</div>
</div>
```

#### ARIA (Use Sparingly)

**First rule of ARIA:** Don't use ARIA if a native HTML element works.

```html
<!-- ❌ Don't recreate native elements -->
<div role="button" tabindex="0" onclick="submit()">Submit</div>

<!-- ✅ Use native elements -->
<button type="submit">Submit</button>
```

Useful ARIA patterns:
- `aria-label` — label for elements without visible text
- `aria-describedby` — additional context (hints, errors)
- `aria-live="polite"` — announce dynamic content changes
- `aria-expanded` — toggle state for accordions/dropdowns
- `aria-hidden="true"` — hide decorative elements from screen readers
- `role="alert"` — urgent notifications

#### Color and Contrast

- **Text contrast:** 4.5:1 minimum (AA), 7:1 enhanced (AAA)
- **Large text (18px+ bold, 24px+):** 3:1 minimum
- **UI components:** 3:1 against adjacent colors
- **Never use color alone** to convey information:

```html
<!-- ❌ Color only -->
<span style="color: red;">Error</span>

<!-- ✅ Color + icon + text -->
<span class="error">
  <svg aria-hidden="true"><!-- error icon --></svg>
  Error: Email is required
</span>
```

### Testing Accessibility

- **Automated:** axe DevTools, Lighthouse, pa11y
- **Keyboard:** navigate entire page with Tab, Enter, Escape, Arrow keys
- **Screen reader:** test with VoiceOver (Mac), NVDA (Windows)
- **Zoom:** site works at 200% zoom
- **Reduced motion:** test with `prefers-reduced-motion`

## Responsive Design

### Mobile-First Approach

Write base styles for mobile, then add complexity:

```css
/* Base: mobile */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}

/* Tablet */
@media (min-width: 768px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}

/* Desktop */
@media (min-width: 1024px) {
  .grid { grid-template-columns: repeat(3, 1fr); }
}
```

### Container Queries

For component-level responsiveness (not just viewport):

```css
.card-container {
  container-type: inline-size;
}

@container (min-width: 400px) {
  .card {
    display: grid;
    grid-template-columns: 200px 1fr;
  }
}
```

### Responsive Patterns

```css
/* Fluid spacing */
padding: clamp(1rem, 3vw, 3rem);

/* Responsive text */
font-size: clamp(1rem, 2.5vw, 1.25rem);

/* Responsive images */
img {
  max-width: 100%;
  height: auto;
  display: block;
}
```

### Breakpoint Strategy

Don't chase device sizes. Break where your content breaks:
- **Small:** ~640px (single column)
- **Medium:** ~768px (two columns)
- **Large:** ~1024px (full layout)
- **Max-width:** 1280px–1440px (prevent ultra-wide readability issues)

## Performance

### Core Web Vitals

- **LCP (Largest Contentful Paint):** < 2.5s — preload hero image, optimize fonts
- **INP (Interaction to Next Paint):** < 200ms — minimize main thread work
- **CLS (Cumulative Layout Shift):** < 0.1 — set explicit dimensions on images/embeds

### Critical Optimizations

```html
<!-- Preload critical resources -->
<link rel="preload" href="/fonts/inter.woff2" as="font" type="font/woff2" crossorigin />
<link rel="preload" href="/hero.webp" as="image" />

<!-- Defer non-critical CSS -->
<link rel="preload" href="/non-critical.css" as="style" onload="this.rel='stylesheet'" />

<!-- Lazy load below-fold images -->
<img src="photo.webp" alt="..." loading="lazy" decoding="async" width="800" height="600" />

<!-- Preconnect to third-party origins -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="dns-prefetch" href="https://analytics.example.com" />
```

### Font Loading

```css
/* Use font-display: swap to prevent invisible text */
@font-face {
  font-family: 'Inter';
  src: url('/fonts/inter.woff2') format('woff2');
  font-display: swap;
  font-weight: 400 700;
}
```

Subset fonts to reduce size: include only Latin characters unless you need more.

## Progressive Enhancement

Build layers: HTML first, then CSS, then JavaScript.

```html
<!-- Works without JS: native form submission -->
<form action="/search" method="GET">
  <input type="search" name="q" />
  <button type="submit">Search</button>
</form>

<!-- Enhanced with JS: live results -->
<script>
  // Only enhance if JS is available
  const form = document.querySelector('form');
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const results = await fetch(`/api/search?q=${form.q.value}`).then(r => r.json());
    renderResults(results);
  });
</script>
```

### Feature Detection

```css
/* Use modern features with fallbacks */
.grid {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

@supports (display: grid) {
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
}
```

## HTML Best Practices

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="Concise page description for SEO" />
  <meta name="theme-color" content="#1a1a2e" />

  <!-- Open Graph -->
  <meta property="og:title" content="Page Title" />
  <meta property="og:description" content="Description" />
  <meta property="og:image" content="https://example.com/og.png" />
  <meta property="og:type" content="website" />

  <title>Page Title | Site Name</title>
</head>
```
