---
name: 1password
description: Use the 1Password CLI for secret lookup, injection, account checks, and secure command execution.
---

# 1Password

Use when work involves `op`, 1Password vaults, signing in, reading secret references, injecting environment variables, or running commands with secrets.

Prefer scoped, read-only secret access. Never print secret values. Confirm the active account, vault, and item path before using secrets in commands.
