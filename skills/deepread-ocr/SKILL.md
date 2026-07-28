---
name: deepread-ocr
description: Extract text and structured data from PDFs and scanned documents with quality checks
---

# Deepread OCR

Use this skill when the user provides PDFs, scans, receipts, forms, contracts, statements, or images and needs reliable OCR, structured extraction, or document QA.

## Workflow

1. Determine the output format: plain text, Markdown, CSV, JSON, or field schema.
2. Run OCR with page-level confidence or quality signals when supported.
3. Flag pages with low confidence, rotation, handwriting, tables, or missing text.
4. Validate extracted totals, dates, names, and identifiers against the source.
5. Return the extracted content plus a short list of uncertain fields.

## Tips

- Use a schema for invoices, IDs, forms, and statements.
- For sensitive documents, keep processing local unless the user approves a remote OCR API.
