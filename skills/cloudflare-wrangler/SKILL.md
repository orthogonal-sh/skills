---
name: cloudflare-wrangler
description: Manage Cloudflare Workers, KV, D1, R2, queues, secrets, and deployments with Wrangler.
---

# Cloudflare Wrangler

Use this skill when a task involves Cloudflare Workers or Cloudflare developer platform resources managed through `wrangler`.

## When To Use

- Deploy or inspect Workers.
- Manage KV namespaces, D1 databases, R2 buckets, queues, or secrets.
- Tail Worker logs during debugging.
- Generate or review `wrangler.toml` configuration.

## Starter Commands

```bash
wrangler whoami
wrangler deploy
wrangler tail
wrangler secret list
```

## Safety

- Confirm before deleting resources, rotating secrets, or deploying to production.
- Never print secret values.
- Prefer environment-specific deploy commands when a project has staging and production.
