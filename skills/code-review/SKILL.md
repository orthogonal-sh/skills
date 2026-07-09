---
name: code-review
description: Code review best practices, what to look for, how to give feedback, and common anti-patterns.
---

# Code Review

How to conduct effective code reviews: what to look for, how to give constructive feedback, and common patterns to flag. Use this when reviewing PRs or preparing code for review.

## What to Look For

### 1. Correctness

The most important check. Does the code do what it's supposed to?

- Does it handle edge cases? (empty arrays, null, zero, negative numbers, Unicode)
- Does it match the requirements/ticket?
- Are boundary conditions correct? (off-by-one, inclusive vs exclusive ranges)
- Does error handling cover failure modes?
- Are race conditions possible in async code?

### 2. Security

```
Critical checks:
□ No secrets/credentials in code (API keys, passwords, tokens)
□ User input is validated and sanitized
□ SQL queries use parameterized queries (no string concatenation)
□ Authentication/authorization checked on all protected routes
□ No sensitive data in logs or error messages
□ Dependencies don't have known vulnerabilities
□ File uploads validated (type, size, content)
□ CORS configured correctly (not wildcard in production)
□ Rate limiting on public endpoints
□ No eval() or dangerouslySetInnerHTML with user input
```

### 3. Design and Architecture

- Does this change belong in this file/module?
- Is the abstraction level appropriate? (not too abstract, not too concrete)
- Does it follow existing patterns in the codebase?
- Could this be simpler?
- Are there unnecessary dependencies being introduced?
- Is the change isolated enough to revert if needed?

### 4. Readability

- Can you understand the code without the PR description?
- Are variable/function names clear and descriptive?
- Is the code self-documenting, or does it need comments?
- Are complex blocks broken into well-named functions?
- Is the control flow easy to follow?

### 5. Performance

- Any N+1 query patterns? (fetching in a loop)
- Unnecessary re-renders in React? (missing memo, unstable refs)
- Large data sets processed without pagination or streaming?
- Missing indexes on database queries?
- Unnecessary network calls?

### 6. Testing

- Are there tests? (new behavior should have tests)
- Do tests cover the happy path AND error cases?
- Are tests testing behavior, not implementation?
- Would a refactor break the tests? (sign of over-mocking)

## Common Anti-Patterns to Flag

### Logic

```typescript
// ❌ Boolean comparison
if (isActive === true) { ... }
// ✅
if (isActive) { ... }

// ❌ Unnecessary else after return
function getRole(user) {
  if (user.isAdmin) {
    return 'admin';
  } else {
    return 'user';
  }
}
// ✅ Early return
function getRole(user) {
  if (user.isAdmin) return 'admin';
  return 'user';
}

// ❌ Nested ternaries
const label = isAdmin ? 'Admin' : isMod ? 'Moderator' : isVip ? 'VIP' : 'User';
// ✅ Object lookup or switch
const ROLE_LABELS = { admin: 'Admin', mod: 'Moderator', vip: 'VIP' };
const label = ROLE_LABELS[role] ?? 'User';
```

### Error Handling

```typescript
// ❌ Swallowing errors silently
try {
  await saveData();
} catch (e) {
  // do nothing
}

// ❌ Catching everything with generic message
try {
  await saveData();
} catch (e) {
  console.log('Something went wrong');
}

// ✅ Handle specifically, propagate what you can't handle
try {
  await saveData();
} catch (e) {
  if (e instanceof ValidationError) {
    showFieldErrors(e.fields);
  } else if (e instanceof NetworkError) {
    showRetryBanner();
  } else {
    throw e; // let it propagate
  }
}
```

### Async Code

```typescript
// ❌ Sequential when parallel is possible
const users = await getUsers();
const orders = await getOrders();
const analytics = await getAnalytics();

// ✅ Parallel
const [users, orders, analytics] = await Promise.all([
  getUsers(),
  getOrders(),
  getAnalytics(),
]);

// ❌ await in loop (N+1)
for (const id of userIds) {
  const user = await getUser(id);
  results.push(user);
}

// ✅ Batch or parallel
const results = await Promise.all(userIds.map(getUser));
// Or better: batch query
const results = await getUsersByIds(userIds);

// ❌ Missing error handling on promises
someAsyncFunction();

// ✅
someAsyncFunction().catch(handleError);
// or
await someAsyncFunction();
```

### React Specific

```tsx
// ❌ Unstable key
{items.map((item, i) => <Item key={i} {...item} />)}

// ❌ Unnecessary state
const [fullName, setFullName] = useState('');
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// ✅ Derived value
const fullName = `${firstName} ${lastName}`;

// ❌ Missing dependency in useEffect
useEffect(() => {
  fetchData(userId);
}, []); // userId missing from deps

// ❌ Object/array literal in JSX (new reference every render)
<MyComponent style={{ color: 'red' }} items={[1, 2, 3]} />
```

### SQL / Database

```sql
-- ❌ SELECT * in production code
SELECT * FROM users WHERE id = $1;

-- ✅ Select only needed columns
SELECT id, email, name FROM users WHERE id = $1;

-- ❌ String interpolation
const query = `SELECT * FROM users WHERE email = '${email}'`;

-- ✅ Parameterized query
const query = 'SELECT * FROM users WHERE email = $1';
await db.query(query, [email]);

-- ❌ No index on frequently queried column
-- (check if WHERE/JOIN columns have indexes)

-- ❌ N+1 queries
for user in users:
    orders = db.query("SELECT * FROM orders WHERE user_id = ?", user.id)

-- ✅ Single query with JOIN
SELECT u.*, o.* FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE u.id = ANY($1);
```

## How to Give Feedback

### Tone and Approach

1. **Ask questions, don't demand** — "What do you think about...?" not "Change this to..."
2. **Explain why** — "This could cause N+1 queries in production because..." not just "Don't do this"
3. **Distinguish severity:**
   - 🔴 **Blocker:** Must fix before merge (bugs, security, data loss)
   - 🟡 **Suggestion:** Would improve quality, not blocking
   - 💭 **Nit:** Style preference, optional
   - ❓ **Question:** Seeking understanding, not necessarily requesting changes
4. **Praise good code** — "Nice use of discriminated unions here 👍"
5. **Offer alternatives** — don't just say what's wrong, suggest what's better
6. **Be specific** — comment on lines, not just "this file needs work"

### Comment Templates

```
🔴 Bug: This will throw when `items` is empty because we access
`items[0]` without checking length first.

Suggestion: Add an early return:
if (items.length === 0) return null;

---

🟡 Suggestion: This could be simplified using Array.reduce():
const total = items.reduce((sum, item) => sum + item.price, 0);

---

💭 Nit: I'd name this `usersByRole` instead of `data` for clarity,
but not blocking.

---

❓ Question: I'm not familiar with this pattern — is there a reason
we're using a class here instead of a plain function? Happy to learn!
```

### What NOT to Do

- **Don't be a gatekeeper** — reviews should unblock, not block
- **Don't bikeshed** — don't hold up a PR over formatting or naming preferences
- **Don't rewrite in comments** — if the change is large, pair on it instead
- **Don't review when angry or rushed** — take a break first
- **Don't pile on** — if someone else already made a comment, just 👍 it
- **Don't make it personal** — "this code" not "your code", "we" not "you"

## PR Author Checklist

Before requesting review:

- [ ] PR has a clear title and description
- [ ] PR is small (< 400 lines changed ideally, never > 1000)
- [ ] Self-reviewed the diff (you'd be surprised what you catch)
- [ ] Tests pass, new tests added for new behavior
- [ ] No console.logs, commented-out code, or TODOs without tickets
- [ ] No unrelated changes (formatting, refactoring) mixed in
- [ ] Breaking changes are documented
- [ ] Database migrations are reversible
- [ ] Screenshots for UI changes

## Reviewer Checklist

```
First pass (5 min):
□ Read PR description — understand the goal
□ Check file list — right scope? anything unexpected?
□ Check test files — what behaviors are covered?

Deep review:
□ Correctness — does it work for all cases?
□ Security — any vulnerabilities introduced?
□ Design — does it fit the architecture?
□ Readability — can you understand it easily?
□ Performance — any obvious bottlenecks?
□ Edge cases — empty, null, concurrent, large inputs?

Final check:
□ Tests are meaningful and not just for coverage
□ No secrets or credentials
□ Error handling is appropriate
□ Changes are reversible / deployable
```

## Review Turnaround

- **Aim for < 4 hours** during working hours
- **Don't let PRs sit > 24 hours** without at least a first pass
- **Small PRs get faster reviews** — incentivize small, focused changes
- **If you're blocked on review**, ping in Slack. Don't suffer in silence.
- **Stack PRs** when possible — don't wait for PR 1 to merge before starting PR 2
