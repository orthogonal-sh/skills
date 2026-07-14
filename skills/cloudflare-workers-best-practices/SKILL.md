---
name: cloudflare-workers-best-practices
description: Build, test, deploy, and debug Cloudflare Workers, Pages Functions, bindings, Durable Objects, KV, D1, and R2.
---

# Cloudflare Workers Best Practices

Use this skill when working with Cloudflare Workers or related edge runtime services.

## Workflow

- Inspect `wrangler.toml`, bindings, compatibility date, environment overrides, and deployment scripts.
- Keep runtime code compatible with the Workers environment.
- Use local or preview deployments for verification when available.
- Treat secrets, KV, D1, R2, Queues, and Durable Objects as explicit bindings.

## Watch For

- Node-only APIs in edge code.
- Missing environment bindings.
- Cache behavior differences.
- Durable Object migration requirements.
