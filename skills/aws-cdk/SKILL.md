---
name: aws-cdk
description: Design, review, and deploy AWS CDK stacks with constructs, environments, security, and diff checks
---

# AWS CDK

Use this skill when working with AWS Cloud Development Kit projects.

## Workflow

1. Identify the app language, stacks, environments, accounts, regions, and deployment pipeline.
2. Review constructs, IAM policies, networking, storage, secrets, and resource lifecycles.
3. Use synth and diff to inspect generated CloudFormation before deployment.
4. Add tests for construct behavior and configuration invariants.
5. Document bootstrap, context values, permissions, and rollback expectations.

## Checks

- Keep least-privilege IAM explicit.
- Avoid accidental resource replacement or data loss.
- Separate dev, staging, and production configuration.
- Capture generated diffs in review for risky infrastructure changes.
