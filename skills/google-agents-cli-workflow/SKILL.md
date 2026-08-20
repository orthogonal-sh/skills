---
name: google-agents-cli-workflow
description: Build and run Google Agents CLI workflows
---

# Google Agents CLI Workflow

Use this skill when working with Google Agents CLI workflows, agent orchestration, deployment pipelines, or local workflow tests.

## Workflow

1. Inspect the workflow definition, agent config, tools, and environment requirements.
2. Validate the local CLI version and auth state.
3. Run a minimal local workflow before deployment.
4. Check tool permissions, inputs, outputs, logs, and failure branches.
5. Document exact commands and any cloud-side resources touched.

## Guardrails

- Do not deploy or publish workflows without explicit user intent.
- Do not request or expose API keys.

## Source

Discovered from skills.sh trending: `google/agents-cli`.
