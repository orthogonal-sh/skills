---
name: changelog-writer
description: Write changelogs from commits, PRs, and releases - formatted and categorized
---

# Changelog Writer - Automated Release Notes

Generate professional changelogs from git commits, PRs, and release information.

## Workflow

### Step 1: Fetch Commit History
Get recent commits from GitHub:

```bash
orth api run linkup /fetch --body '{"url": "https://github.com/user/repo/commits/main"}'
```

### Step 2: Extract PR Information
Get PR details and descriptions:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://github.com/user/repo/pulls?state=closed",
  "user_prompt": "Extract PR titles, numbers, descriptions, and labels for recently merged PRs"
}'
```

### Step 3: Generate Changelog
Use AI to write formatted changelog:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Write a professional changelog entry for version 2.1.0 based on these commits:\n\n- feat: add OAuth support\n- fix: resolve memory leak in parser\n- docs: update API documentation\n- chore: upgrade dependencies\n\nUse Keep a Changelog format with categories: Added, Changed, Fixed, Removed"
  }]
}'
```

### Step 4: Research Changelog Standards
Find best practices:

```bash
orth api run tavily /search --body '{
  "query": "changelog best practices keepachangelog semantic versioning",
  "include_answer": true
}'
```

### Step 5: Find Good Examples
Learn from other projects:

```bash
orth api run exa /search --body '{
  "query": "excellent open source project changelog examples CHANGELOG.md",
  "num_results": 10
}'
```

## Example Usage

```bash
# Generate from commit list
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Generate a changelog for v3.0.0 from these changes:\n- Breaking: renamed API endpoints\n- Added: dark mode support\n- Fixed: login timeout issues\n- Improved: 50% faster load times\n\nFormat with clear categories and user-friendly descriptions"}]
}'

# Extract release notes
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://github.com/facebook/react/releases",
  "user_prompt": "Extract the latest release notes including version, date, and all changes"
}'
```

## Changelog Categories

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Features to be removed
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security fixes

## Discover More

For full endpoint details and parameters:

```bash
orth api show exa
orth api show linkup
orth api show perplexity
orth api show scrapegraph
orth api show tavily 
```
