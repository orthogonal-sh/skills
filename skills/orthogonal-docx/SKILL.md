---
name: docx
description: Create, edit, and analyze Word documents (.docx)
---

# Word Document Builder

Create and edit Word documents programmatically.

## When to Use

- User wants to create a Word document
- User needs to edit an existing .docx file
- User asks to generate reports, proposals, or formal documents
- User needs document format conversion

## How It Works

Uses `docx` npm package for creation and `pandoc` for reading/conversion. Supports styles, headers, footers, tables, images, and tracked changes.

## Source

Based on [anthropics/skills/docx](https://skills.sh/anthropics/skills/docx) (12.1K+ installs)

## Setup

```bash
npm install -g docx
# pandoc for reading
brew install pandoc
```

## Usage

### Read Existing Document
```bash
pandoc --track-changes=all document.docx -o output.md
```

### Create New Document
Use the `docx` npm package - supports headings, lists, tables, images, headers/footers, page numbers, and table of contents.

## Key Features

- Create professional documents with custom styles
- Read and extract content from .docx files
- Support for tracked changes
- Tables, images, headers, footers, page numbers
- Convert between formats (doc → docx, docx → pdf)
