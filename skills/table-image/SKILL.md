---
name: table-image
description: Extract, clean, and verify tables from screenshots, scans, PDFs, and other image sources.
---

# table-image

Use this skill when tabular data is trapped in an image, screenshot, scan, PDF page, or chart-like layout and needs to become structured text.

## Workflow

- Inspect the image for headers, row groups, merged cells, units, footnotes, and rotation or crop issues.
- Extract the table into Markdown, CSV, JSON, or a spreadsheet-friendly format as requested.
- Preserve uncertainty with flags for illegible cells, inferred headers, and ambiguous separators.
- Validate row and column counts against the visual source before returning the result.
