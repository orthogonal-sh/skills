---
name: pymupdf-pdf
description: Parse PDFs locally with PyMuPDF for text, images, tables, metadata, and page analysis
---

# PyMuPDF PDF

Use this skill when the user needs fast local PDF extraction, page inspection, metadata, images, tables, annotations, or conversion to Markdown/JSON.

## Workflow

1. Inspect page count, metadata, encryption, and text availability.
2. Use PyMuPDF for local extraction before sending content to remote APIs.
3. Extract text with page numbers and preserve reading order when possible.
4. Pull images, links, annotations, and bounding boxes when requested.
5. Flag scanned pages that need OCR.

## Output

- Include page references for extracted facts.
- Keep generated files near the source document unless the user asks otherwise.
