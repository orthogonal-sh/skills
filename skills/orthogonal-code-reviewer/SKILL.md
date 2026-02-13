---
name: code-reviewer
description: Review code with AI - find bugs, suggest improvements, check best practices
---

# Code Reviewer - AI-Powered Code Review

Review code for bugs, security issues, performance problems, and best practices.

## Workflow

### Step 1: Fetch Code from Repository
Get code from GitHub or other sources:

```bash
orth api run linkup /fetch --body '{"url": "https://raw.githubusercontent.com/user/repo/main/file.py"}'
```

### Step 2: Get AI Code Review
Use Perplexity for comprehensive review:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Review this Python code for bugs, security issues, and improvements:\n\n```python\ndef process_user_input(data):\n    query = f\"SELECT * FROM users WHERE id = {data['\''id'\'']}\"\n    return db.execute(query)\n```"
  }]
}'
```

### Step 3: Check for Best Practices
Research language-specific best practices:

```bash
orth api run tavily /search --body '{
  "query": "Python best practices security SQL injection prevention 2024",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 4: Find Similar Solutions
Look for better implementations:

```bash
orth api run exa /search --body '{
  "query": "Python parameterized queries SQL best implementation example",
  "num_results": 10,
  "contents": {"text": true}
}'
```

### Step 5: Security Audit
Check for known vulnerabilities:

```bash
orth api run olostep /v1/answers --body '{
  "task": "What are the OWASP Top 10 vulnerabilities to check for in Python web applications?"
}'
```

## Example Usage

```bash
# Review code snippet
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Review this JavaScript code for performance and security: [paste code]"}]
}'

# Find best practices
orth api run tavily /search --body '{
  "query": "React hooks best practices common mistakes 2024",
  "include_answer": true
}'

# Get improvement suggestions
orth api run exa /search --body '{
  "query": "how to optimize Python asyncio code patterns",
  "num_results": 10
}'
```

## Common Checks

1. **Security**: SQL injection, XSS, authentication
2. **Performance**: Loops, memory usage, async/await
3. **Best Practices**: Naming, structure, documentation
4. **Error Handling**: Try/catch, validation, logging
5. **Testing**: Test coverage, edge cases

## Discover More

For full endpoint details and parameters:

```bash
orth api show exa
orth api show linkup
orth api show olostep
orth api show perplexity
orth api show tavily 
```
