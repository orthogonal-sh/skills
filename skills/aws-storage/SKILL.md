---
name: aws-storage
description: Work with AWS storage services including S3, EBS, EFS, backups, lifecycle, encryption, and access
---

# AWS Storage

Use this skill when designing, debugging, or operating AWS storage.

## Workflow

1. Identify the storage service, workload, access pattern, durability needs, and cost constraints.
2. Review encryption, IAM, bucket policies, network access, retention, and backup posture.
3. Configure lifecycle, versioning, replication, snapshots, or tiering as appropriate.
4. Test read, write, restore, and failure paths with representative data.
5. Document recovery objectives, ownership, and operational alerts.

## Checks

- Avoid public access unless it is intentional and reviewed.
- Treat deletion, overwrite, and retention changes as high risk.
- Verify region, account, and KMS key assumptions.
- Monitor cost drivers such as requests, retrieval, transfer, and snapshots.
