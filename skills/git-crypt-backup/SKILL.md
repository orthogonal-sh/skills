---
name: git-crypt-backup
description: Audit and maintain git-crypt encrypted files, keys, backups, collaborators, and recovery docs.
---

# git-crypt-backup

Use this skill when a repository uses git-crypt or encrypted tracked files and needs setup review, backup, collaborator access, or recovery planning.

## Workflow

- Inspect encrypted file patterns, key status, collaborator access, and whether secrets are accidentally plaintext.
- Verify backup locations, recovery instructions, and key export/import procedures.
- Avoid printing secret contents; work with metadata and checksums where possible.
- Provide a safe operational checklist for adding users, rotating keys, testing recovery, and documenting the setup.
