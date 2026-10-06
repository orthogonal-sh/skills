---
name: curl-http
description: Use curl for HTTP debugging, headers, auth, payloads, redirects, retries, downloads, and API smoke tests.
---

# Curl HTTP

Use this skill when a task involves inspecting or debugging HTTP endpoints with curl, including APIs, webhooks, headers, auth, and response behavior.

## Workflow

- Identify method, URL, headers, auth, payload, expected status, and safety of the request.
- Start with read-only requests where possible and avoid logging secrets.
- Capture status, headers, redirects, timing, and response excerpts relevant to the problem.
- Convert successful probes into reproducible commands or implementation notes.
