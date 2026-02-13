---
name: bug-reporter
description: Create detailed bug reports - reproduction steps, environment info, expected behavior
---

# Bug Reporter - Comprehensive Bug Reports

Create detailed, actionable bug reports with all necessary information for debugging.

## Workflow

### Step 1: Research the Issue
Search for related issues or solutions:

```bash
orth api run tavily /search --body '{
  "query": "React useState not updating TypeError common causes solutions",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Find Similar Issues
Check if issue is known:

```bash
orth api run exa /search --body '{
  "query": "site:github.com/issues React useState batch updates bug",
  "num_results": 20
}'
```

### Step 3: Get Environment Info
Research version compatibility:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "What are common compatibility issues between React 18 and older npm packages? What environment info should I include in a bug report?"
  }]
}'
```

### Step 4: Generate Bug Report
Create comprehensive bug report:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Help me write a detailed GitHub bug report for this issue:\n\nProblem: Button click doesn'\''t update state\nWhat I tried: useState, useReducer\nExpected: State updates on click\nActual: Nothing happens\n\nInclude: summary, environment, steps to reproduce, expected vs actual, possible causes"
  }]
}'
```

### Step 5: Find Workarounds
Search for temporary fixes:

```bash
orth api run olostep /v1/answers --body '{
  "task": "What are workarounds for React state not updating on click events?"
}'
```

## Bug Report Template

```markdown
## Summary
[One-line description of the bug]

## Environment
- OS: [e.g., macOS 14.0]
- Browser/Runtime: [e.g., Chrome 120]
- Package Version: [e.g., react@18.2.0]

## Steps to Reproduce
1. [First step]
2. [Second step]
3. [Third step]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Code Sample
```[language]
// Minimal reproduction code
```

## Additional Context
[Screenshots, logs, related issues]
```

## Example Usage

```bash
# Research bug
orth api run tavily /search --body '{
  "query": "Node.js memory leak EventEmitter common causes",
  "include_answer": true
}'

# Find existing issues
orth api run exa /search --body '{
  "query": "site:github.com memory leak issue EventEmitter",
  "num_results": 15
}'

# Generate report
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Write a bug report for: Server crashes after 24 hours with out of memory error"}]
}'
```

## Discover More

For full endpoint details and parameters:

```bash
orth api show exa
orth api show olostep
orth api show perplexity
orth api show tavily 
```
