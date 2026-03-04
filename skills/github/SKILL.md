---
name: github
description: Create issues, pull requests, and manage GitHub repositories. Use when asked to create GitHub issues, open PRs, list repositories, or star repos.
---

# GitHub

Create issues, pull requests, and manage repositories on GitHub. Connect your GitHub account to interact with repos, create issues, open PRs, and manage your GitHub workflow.

## Requirements

- Install the `orth` CLI
- Connect your GitHub account at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Create Issue

Create a new issue in a GitHub repository.

```bash
orth run github /create-issue --body '{
  "owner": "username",
  "repo": "repository-name",
  "title": "Bug: Login form validation error",
  "body": "When submitting invalid email, no error message appears."
}'
```

**Parameters:**
- `owner` (required) - Repository owner username or organization
- `repo` (required) - Repository name
- `title` (required) - Issue title
- `body` - Issue description and details
- `labels` - Array of label names to apply
- `assignees` - Array of usernames to assign
- `milestone` - Milestone number to associate with

### List Repositories

Get a list of repositories for the authenticated user or organization.

```bash
orth run github /list-repos --body '{
  "type": "owner",
  "sort": "updated",
  "per_page": 20
}'
```

**Parameters:**
- `sort` - Sort repositories by (created, updated, pushed, full_name)
- `type` - Repository type (all, owner, public, private, member)
- `direction` - Sort direction (asc, desc)
- `per_page` - Number of repositories per page
- `page` - Page number for pagination
- `since` - Only repos updated after this date
- `before` - Only repos updated before this date
- `raw_response` - Return raw GitHub API response (true/false)

### Create Pull Request

Open a new pull request between branches.

```bash
orth run github /create-pr --body '{
  "owner": "username",
  "repo": "repository-name",
  "head": "feature-branch",
  "base": "main",
  "title": "Add new feature",
  "body": "This PR adds the requested feature with tests."
}'
```

**Parameters:**
- `owner` (required) - Repository owner username or organization
- `repo` (required) - Repository name
- `head` (required) - Branch containing changes (source branch)
- `base` (required) - Branch to merge into (target branch)
- `title` - Pull request title
- `body` - Pull request description
- `draft` - Create as draft PR (true/false)
- `issue` - Issue number to convert to PR
- `head_repo` - Repository containing head branch (for forks)
- `maintainer_can_modify` - Allow maintainers to edit (true/false)

### Star Repository

Star a GitHub repository to bookmark it.

```bash
orth run github /star-repo --body '{
  "owner": "octocat",
  "repo": "Hello-World"
}'
```

**Parameters:**
- `owner` (required) - Repository owner username or organization
- `repo` (required) - Repository name to star

## Usage Examples

**Create bug report:**
```bash
orth run github /create-issue -b '{"owner":"myorg","repo":"webapp","title":"Login button not working","body":"Steps to reproduce:\n1. Go to login page\n2. Click login button\n3. Nothing happens","labels":["bug","frontend"]}'
```

**Create feature request:**
```bash
orth run github /create-issue -b '{"owner":"team","repo":"api","title":"Add user authentication","body":"We need JWT-based authentication for the API","labels":["enhancement"],"assignees":["developer1"]}'
```

**List your repositories:**
```bash
orth run github /list-repos -b '{"type":"owner","sort":"updated","per_page":10}'
```

**Create pull request:**
```bash
orth run github /create-pr -b '{"owner":"myorg","repo":"project","head":"fix/login-bug","base":"main","title":"Fix login validation bug","body":"Resolves #123\n\nFixed validation logic for email input field."}'
```

**Create draft PR:**
```bash
orth run github /create-pr -b '{"owner":"team","repo":"app","head":"feature/new-ui","base":"develop","title":"New UI components","draft":true}'
```

**Star useful repository:**
```bash
orth run github /star-repo -b '{"owner":"microsoft","repo":"vscode"}'
```

## Error Handling

- **HTTP 428** - GitHub integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your account
- **400 Bad Request** - Invalid parameters or malformed request
- **401 Unauthorized** - Invalid or expired GitHub token
- **403 Forbidden** - Insufficient permissions for repository or action
- **404 Not Found** - Repository, branch, or resource does not exist
- **409 Conflict** - Pull request already exists for this branch combination
- **422 Unprocessable Entity** - Validation failed (invalid labels, assignees, etc.)
- **429 Rate Limited** - GitHub API rate limit exceeded

## Tips

- Repository names are case-sensitive
- Use organization name as owner for organization repos
- Labels must already exist in the repository or be valid GitHub default labels
- Assignees must have repository access to be assigned to issues
- Pull request head/base branches must exist in the repository
- Draft PRs can be marked ready for review later
- Star repositories to bookmark them for later reference
- Use descriptive titles and detailed bodies for better collaboration
- Check repository permissions before creating issues or PRs