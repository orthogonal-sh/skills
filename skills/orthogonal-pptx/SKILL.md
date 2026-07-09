---
name: pptx
description: Create, edit, and analyze PowerPoint presentations (.pptx)
---

# PowerPoint Presentation Builder

Create professional PowerPoint presentations from scratch or edit existing ones.

## When to Use

- User wants to create a slide deck or presentation
- User needs to edit an existing .pptx file
- User asks to convert content into slides
- User needs presentation design help

## How It Works

Uses `pptxgenjs` (npm) for creation and `markitdown` (Python) for reading existing presentations. Supports templates, custom themes, charts, images, and professional layouts.

## Source

Based on [anthropics/skills/pptx](https://skills.sh/anthropics/skills/pptx) (13K+ installs)

## Setup

```bash
npm install -g pptxgenjs
pip install markitdown
```

## Usage

### Read Existing Presentation
```bash
python -m markitdown presentation.pptx
```

### Create New Presentation
Use pptxgenjs via Node.js script - see source skill for full creation guide including color palettes, typography, and layout patterns.

## Key Features

- Read/analyze existing .pptx files
- Create from scratch with professional themes
- Edit existing presentations (unpack → modify → repack)
- Support for charts, images, tables, and custom layouts
- Design-focused with color palette and typography guidance
