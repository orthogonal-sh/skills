---
name: mcp-atlassian
description: Use the Atlassian MCP server for Jira and Confluence search, issue updates, and page workflows.
---

# Atlassian MCP

Use this skill when a task involves Jira issues, Confluence pages, or Atlassian workspace search through MCP.

## When To Use

- Search Confluence for specs, runbooks, decisions, or project docs.
- List, inspect, create, or update Jira issues.
- Link implementation work to Jira tickets.
- Summarize Atlassian project state.

## Setup Pattern

Run the Atlassian MCP server with OAuth or token configuration, often via Docker:

```bash
docker run --rm -i \
  -e ATLASSIAN_SITE_URL="$ATLASSIAN_SITE_URL" \
  -e ATLASSIAN_API_TOKEN="$ATLASSIAN_API_TOKEN" \
  mcp-atlassian
```

## Operating Notes

- Prefer issue keys and page IDs over fuzzy names.
- Quote only short excerpts from private workspace docs.
- Confirm before mutating Jira or Confluence unless the user explicitly asked for the edit.
