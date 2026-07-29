---
name: git-crypt-backup
description: Back up sensitive workspace files to GitHub with git-crypt encryption and restore notes.
---

# Git-Crypt Backup

Use this skill when the user wants encrypted Git-based backups for workspace or configuration files.

## When To Use

- Set up `git-crypt` for private backup repos.
- Add encrypted patterns to `.gitattributes`.
- Commit and push recoverable snapshots.
- Document restore steps.

## Starter Commands

```bash
git-crypt init
git-crypt status
git-crypt export-key ./git-crypt-key
```

## Safety

- Never commit raw secrets before encryption rules are active.
- Store exported keys outside the repo.
- Verify `git-crypt status` before pushing.
