---
name: ui-ux-design
description: UI/UX design principles including user research, information architecture, interaction design, and usability heuristics.
---

# UI/UX Design

Principles and frameworks for designing user interfaces and experiences. Use this when making design decisions, evaluating interfaces, or planning user flows.

## Nielsen's 10 Usability Heuristics

Apply these as a design checklist and review framework:

### 1. Visibility of System Status

Always keep users informed about what's happening:
- Show loading indicators for operations > 1 second
- Progress bars for multi-step processes
- Success/error confirmations after actions
- "Saving..." / "Saved" indicators for auto-save
- Active states on navigation to show current location

### 2. Match Between System and Real World

Use language and concepts users already know:
- Label buttons with verbs: "Save draft", "Send message", not "Submit" or "OK"
- Use familiar metaphors: shopping cart, inbox, folder
- Format data as users expect: dates in local format, currency with symbols
- Avoid internal jargon: "Your session expired" not "Token invalidated"

### 3. User Control and Freedom

Users make mistakes. Provide escape routes:
- Undo for destructive actions (don't just confirm dialogs)
- "Back" that works predictably
- Clear way to cancel in-progress operations
- Draft auto-saving so users don't lose work
- "Are you sure?" only for truly irreversible actions

### 4. Consistency and Standards

Same action = same result everywhere in the app:
- Buttons that look the same behave the same
- Same terminology throughout (don't mix "delete" and "remove")
- Follow platform conventions (links are blue/underlined, × closes things)
- Consistent placement: primary actions always in the same position

### 5. Error Prevention

Better than good error messages is preventing errors:
- Disable submit buttons until forms are valid
- Constrain inputs: date pickers instead of text fields, dropdowns for known options
- Inline validation as users type (not just on submit)
- Confirm before destructive actions with clear consequences
- Smart defaults that work for most users

### 6. Recognition Rather Than Recall

Minimize memory load:
- Show recent searches, recently viewed items
- Autocomplete and suggestions
- Visible navigation (not hidden hamburger menus on desktop)
- Contextual help and tooltips where needed
- Preview before committing (file upload preview, email preview)

### 7. Flexibility and Efficiency of Use

Serve both novice and expert users:
- Keyboard shortcuts for power users
- Recent/frequent items for quick access
- Customizable dashboards
- Bulk actions for repetitive tasks
- Progressive disclosure: simple by default, advanced when needed

### 8. Aesthetic and Minimalist Design

Every extra element competes with relevant information:
- Remove content that doesn't serve a purpose
- Prioritize: what does the user need *right now*?
- White space is not wasted space — it aids comprehension
- Reduce visual noise: fewer borders, shadows, colors
- One primary action per screen/section

### 9. Help Users Recognize, Diagnose, and Recover from Errors

Error messages should be:
- **Specific:** "Email address is missing @" not "Invalid input"
- **Constructive:** Tell users how to fix it
- **Visible:** Place errors near the problem, not just at the top
- **Polite:** No blame ("That email doesn't look right" vs "Error: Invalid email")
- **Persistent:** Don't auto-dismiss error messages

### 10. Help and Documentation

Even intuitive UIs need help sometimes:
- Contextual help near complex features
- Onboarding for new users (tooltips, walkthroughs)
- Searchable documentation
- FAQ for common issues
- Empty states that educate ("No projects yet. Create your first project to get started.")

## Information Architecture

### Card Sorting

Discover how users categorize information:

1. **Open sort:** Users group items and name the groups
2. **Closed sort:** Users sort items into pre-defined categories
3. **Hybrid:** Pre-defined categories + users can create new ones

Use results to structure navigation, categorize content, and label sections.

### Navigation Patterns

Choose based on content structure:

| Pattern | When to Use | Example |
|---------|------------|---------|
| **Top nav** | 5-7 primary sections | Marketing sites |
| **Side nav** | Many sections, deep hierarchy | Admin dashboards, docs |
| **Tab bar** | 3-5 equal top-level areas | Mobile apps |
| **Breadcrumbs** | Deep hierarchy, users need context | E-commerce, file systems |
| **Hub & spoke** | Independent task-based sections | Settings, mobile apps |
| **Search-first** | Large content corpus | Knowledge bases, catalogs |

### Content Hierarchy

Structure pages with the inverted pyramid:
1. **Most critical info first** — answer the main question immediately
2. **Supporting details** — context, options, specifics
3. **Background/advanced** — edge cases, related content, help

## Interaction Design Patterns

### Form Design

```
Rules for forms:
1. One column layout (don't put fields side-by-side unless logically paired like first/last name)
2. Label above input (not placeholder-only, not to the left)
3. Group related fields with fieldsets
4. Mark optional fields, not required ones (most fields should be required)
5. Inline validation after field loses focus (not while typing)
6. Clear error messages next to the field
7. Primary action button left-aligned with fields
8. Destructive actions require confirmation
9. Auto-save when possible
10. Show progress for multi-step forms
```

### Feedback Patterns

| User Action | Feedback | Timing |
|------------|----------|--------|
| Click button | Button state change (pressed) | Immediate |
| Submit form | Loading indicator on button | Immediate |
| Operation completes | Success toast/banner | On completion |
| Error occurs | Inline error + field highlight | On occurrence |
| Long operation | Progress bar with estimate | Continuous |
| Background save | "Saved" indicator | After save |

### Modal and Dialog Guidelines

- **Use modals for:** focused tasks that require completion (confirm delete, quick edit)
- **Don't use modals for:** information display, complex forms, anything that needs scrolling
- Always provide a close button AND clicking outside to dismiss (for non-critical)
- Focus trap inside modal (Tab cycles within modal)
- Return focus to trigger element on close
- Consider a slide-over panel for complex content instead of modal

### Empty States

Empty states are a design opportunity, not an afterthought:

```
Structure:
1. Illustration or icon (optional, adds warmth)
2. Clear heading: "No messages yet"
3. Helpful description: "When you receive messages, they'll appear here"
4. Primary CTA: "Send your first message"
```

## User Research Methods

### When to Use What

| Method | When | Participants | Time |
|--------|------|-------------|------|
| **User interviews** | Exploring problems | 5-8 people | 2-3 weeks |
| **Usability testing** | Evaluating solutions | 5 people | 1-2 weeks |
| **A/B testing** | Comparing options | 1000+ users | 2-4 weeks |
| **Surveys** | Measuring satisfaction | 100+ users | 1-2 weeks |
| **Analytics** | Understanding behavior | All users | Ongoing |
| **Card sorting** | Organizing content | 15-30 people | 1 week |

### The 5-User Rule

Jakob Nielsen found that **5 users find ~85% of usability problems.** Test early with 5, fix issues, then test again with 5. Two rounds of 5 > one round of 10.

### Jobs to Be Done (JTBD)

Frame features around user goals:

```
When I [situation],
I want to [motivation],
So I can [expected outcome].

Example:
When I'm reviewing my team's work at the end of the week,
I want to see a summary of completed tasks,
So I can report progress to stakeholders without asking each person.
```

## Design System Foundations

### Spacing Scale

Use a consistent scale (multiples of 4px or 8px):

```
4 → 8 → 12 → 16 → 24 → 32 → 48 → 64 → 96 → 128
```

Apply systematically:
- **4-8px:** Inside components (padding in buttons, between icon and label)
- **12-16px:** Between related elements
- **24-32px:** Between sections
- **48-96px:** Page sections, major visual breaks

### Component API Design

Design components for reuse:

```
Button variants: primary | secondary | ghost | danger
Button sizes: sm | md | lg
Button states: default | hover | active | focus | disabled | loading

Don't make variants for every use case.
If you need 10+ variants, your component is doing too much.
```

### Design Tokens

Abstract decisions into named tokens:

```
color.text.primary → #1a1a2e
color.text.secondary → #6b7280
color.bg.surface → #ffffff
color.bg.muted → #f9fafb
color.border.default → #e5e7eb
space.sm → 8px
space.md → 16px
space.lg → 32px
radius.sm → 4px
radius.md → 8px
radius.full → 9999px
```

## Mobile Design Guidelines

- **Touch targets:** minimum 44×44px with adequate spacing
- **Thumb zone:** primary actions in easy-reach area (bottom of screen)
- **Bottom sheets** over modals for mobile
- **Swipe gestures** as shortcuts, never the only way
- **Reduce typing:** autofill, suggestions, voice input
- **Offline states:** clearly indicate when offline, cache when possible
- **One-handed use:** consider reachability for large screens
