---
name: local-rag-search
description: Build and query local retrieval indexes over markdown, code, PDFs, and project documentation.
---

# Local RAG Search

Use this skill when the agent needs semantic or hybrid search over local files without sending private content to hosted services.

## Workflow

1. Select the corpus and exclude secrets, generated files, and irrelevant dependencies.
2. Build or refresh a local index with embeddings, keyword search, or both.
3. Retrieve focused excerpts with filenames and line references.
4. Answer using cited local context and note index freshness.
