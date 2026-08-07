---
name: swagger-gen
description: Generate OpenAPI specifications from application routes.
---

# Swagger Generator

Use this skill when the user wants an OpenAPI or Swagger spec generated from code, especially Express-style route definitions.

## Capabilities

- Inspect route files
- Infer endpoints, methods, parameters, and response shapes
- Generate an OpenAPI document
- Flag missing schemas and ambiguous handlers

## Implementation Notes

Stub discovered from the OpenClaw skills ecosystem. Add framework-specific parsers and validation commands before enabling generation.
