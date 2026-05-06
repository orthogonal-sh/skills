---
name: github-to-linkedin
description: Convert GitHub usernames to LinkedIn profiles with contact emails
---

# GitHub to LinkedIn - Developer Sourcing

Convert GitHub usernames to LinkedIn profiles and extract work emails. Ideal for sourcing open-source contributors, mapping GitHub communities, and building developer talent pipelines.

## Workflow

### Step 1: Single Lookup (1-5 people)
For quick lookups, use the synchronous endpoint:

```bash
orth api run fiber /v1/github-to-linkedin/single --body '{"githubUsername": "torvalds", "outputType": "both"}'
```

Parameters:
- **githubUsername** (required) - GitHub username only (NOT a URL)
- **outputType** - `linkedin` (find LinkedIn), `email` (extract work emails from commits), `both` (default)

Returns: `linkedInUrl`, `linkedInSlug`, `confidenceOutOf10`, `matchSource`, `extractedEmails[]`, `githubProfile` (name, company, bio).

### Step 2: Batch Lookup (6-1000 people)
For larger lists, use the async batch endpoint:

```bash
orth api run fiber /v1/github-to-linkedin/trigger --body '{
  "people": [
    {"githubUsername": "torvalds"},
    {"githubUsername": "gaearon"},
    {"githubUsername": "sindresorhus"}
  ],
  "outputType": "linkedin",
  "overallContext": "Top open source maintainers"
}'
```

The `overallContext` field helps disambiguate — describe what the people have in common.

### Step 3: Poll Batch Results
Poll until results are ready:

```bash
orth api run fiber /v1/github-to-linkedin/polling --body '{"githubAgentRunId": "RUN_ID_FROM_TRIGGER", "pageSize": 50}'
```

Use `cursor` from the response to paginate through large result sets.

### Step 4: Enrich High-Confidence Matches
For matches with high confidence scores, get full LinkedIn profiles:

```bash
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/SLUG_FROM_RESULTS"}'
```

### Step 5: Get Contact Info
Find emails for outreach:

```bash
orth api run hunter /v2/email-finder --query 'domain=company.com&first_name=Linus&last_name=Torvalds'
```

## Example Usage

```bash
# Find LinkedIn for a single GitHub user
orth api run fiber /v1/github-to-linkedin/single --body '{"githubUsername": "antirez", "outputType": "linkedin"}'

# Batch resolve contributors to a repo
orth api run fiber /v1/github-to-linkedin/trigger --body '{
  "people": [
    {"githubUsername": "user1"},
    {"githubUsername": "user2"},
    {"githubUsername": "user3"}
  ],
  "outputType": "both",
  "overallContext": "Contributors to kubernetes/kubernetes"
}'

# Extract only emails (cheaper, no LinkedIn lookup)
orth api run fiber /v1/github-to-linkedin/single --body '{"githubUsername": "jessfraz", "outputType": "email"}'
```

## Tips

- Use `outputType: "linkedin"` if you only need profiles (cheaper — 5 credits vs 8 for "both")
- Use `outputType: "email"` if you only need emails from commit history (3 credits)
- `overallContext` significantly improves batch accuracy — always include it
- Confidence scores range 0-10; treat 7+ as reliable matches
- For batch jobs, poll every 5-10 seconds until results appear
- Combine with people-search to find more devs at the same companies

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
orth api show hunter
```

Example: `orth api show fiber /v1/github-to-linkedin/single` for endpoint parameters.
