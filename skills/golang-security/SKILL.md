---
name: golang-security
description: Review Go services for auth, input validation, crypto, secrets, dependencies, and secure defaults
---

# Go Security

Use this skill when reviewing or hardening Go code.

## Workflow

1. Identify trust boundaries, external inputs, credentials, and privileged operations.
2. Validate request parsing, auth checks, authorization, and error paths.
3. Review cryptography, TLS, random generation, and token handling.
4. Scan dependencies and generated files for known issues.
5. Add tests for rejected input and unauthorized access.

## Checks

- Never log secrets or bearer tokens.
- Keep timeouts on network calls.
- Use constant-time comparison for secrets when needed.
- Prefer standard library crypto over custom implementations.
