---
name: test-driven-development
description: TDD workflow, test strategies, red-green-refactor, mocking, and testing best practices.
---

# Test-Driven Development

Guide for writing tests first, designing testable code, and choosing the right testing strategy. Apply these practices to produce reliable, maintainable software.

## The Red-Green-Refactor Cycle

```
1. RED    → Write a failing test for the behavior you want
2. GREEN  → Write the minimum code to make the test pass
3. REFACTOR → Clean up the code while keeping tests green
4. REPEAT
```

### Key Principles

- **Write the test FIRST** — not after. This drives your API design.
- **One behavior per test** — if a test name has "and" in it, split it.
- **Minimum code to pass** — resist the urge to write the "full" implementation.
- **Refactor with confidence** — green tests mean you haven't broken anything.

### Example: Building a Price Calculator

```typescript
// Step 1: RED — write the failing test
describe('PriceCalculator', () => {
  it('returns base price for single item', () => {
    const calc = new PriceCalculator();
    expect(calc.total([{ price: 10, quantity: 1 }])).toBe(10);
  });
});

// Step 2: GREEN — minimum code
class PriceCalculator {
  total(items: Array<{ price: number; quantity: number }>): number {
    return items[0].price;
  }
}

// Step 3: RED — next test forces better implementation
it('sums multiple items', () => {
  const calc = new PriceCalculator();
  expect(calc.total([
    { price: 10, quantity: 1 },
    { price: 20, quantity: 2 },
  ])).toBe(50);
});

// Step 4: GREEN — generalize
total(items: Array<{ price: number; quantity: number }>): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

// Step 5: RED — add discount behavior
it('applies 10% discount for orders over $100', () => {
  const calc = new PriceCalculator();
  expect(calc.total([{ price: 50, quantity: 3 }])).toBe(135); // 150 * 0.9
});

// Continue the cycle...
```

## Test Structure: AAA Pattern

Every test should follow **Arrange, Act, Assert:**

```typescript
it('sends welcome email when user signs up', async () => {
  // Arrange — set up preconditions
  const emailService = new MockEmailService();
  const userService = new UserService(emailService);

  // Act — perform the action
  await userService.signup({ email: 'test@example.com', name: 'Alice' });

  // Assert — verify the result
  expect(emailService.sent).toHaveLength(1);
  expect(emailService.sent[0].to).toBe('test@example.com');
  expect(emailService.sent[0].template).toBe('welcome');
});
```

## Test Naming

Test names should describe behavior, not implementation:

```typescript
// ❌ Implementation-focused
it('calls the database query method')
it('sets isLoading to true')

// ✅ Behavior-focused
it('returns user profile when valid ID is provided')
it('shows loading spinner while fetching data')
it('displays error message when email is invalid')

// Pattern: "it [does something] when [condition]"
it('rejects the order when inventory is insufficient')
it('retries the request when the server returns 503')
it('sends notification to all team members when task is completed')
```

## Testing Pyramid

```
        /  E2E  \        Few, slow, expensive
       /─────────\       Test critical user journeys
      / Integration\     Some, medium speed
     /──────────────\    Test component collaboration
    /   Unit Tests   \   Many, fast, cheap
   /──────────────────\  Test individual functions/classes
```

### Unit Tests (70%)

Test individual functions, classes, or components in isolation:

```typescript
// Pure function — easiest to test
function formatCurrency(amount: number, currency = 'USD'): string {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency }).format(amount);
}

test('formats USD by default', () => {
  expect(formatCurrency(1234.5)).toBe('$1,234.50');
});

test('formats EUR when specified', () => {
  expect(formatCurrency(1234.5, 'EUR')).toBe('€1,234.50');
});

test('handles zero', () => {
  expect(formatCurrency(0)).toBe('$0.00');
});

test('handles negative amounts', () => {
  expect(formatCurrency(-50)).toBe('-$50.00');
});
```

### Integration Tests (20%)

Test how components work together:

```typescript
// Test API endpoint with actual database
describe('POST /api/orders', () => {
  beforeEach(async () => {
    await db.migrate.latest();
    await db.seed.run();
  });

  afterEach(async () => {
    await db.migrate.rollback();
  });

  it('creates an order and updates inventory', async () => {
    const response = await request(app)
      .post('/api/orders')
      .send({ productId: 'prod-1', quantity: 2 })
      .set('Authorization', `Bearer ${testToken}`);

    expect(response.status).toBe(201);
    expect(response.body.order.status).toBe('pending');

    // Verify side effect: inventory updated
    const product = await db('products').where('id', 'prod-1').first();
    expect(product.stock).toBe(8); // was 10, ordered 2
  });

  it('returns 400 when insufficient stock', async () => {
    const response = await request(app)
      .post('/api/orders')
      .send({ productId: 'prod-1', quantity: 999 });

    expect(response.status).toBe(400);
    expect(response.body.error).toContain('Insufficient stock');
  });
});
```

### End-to-End Tests (10%)

Test complete user flows:

```typescript
// Playwright E2E test
test('user can sign up and create a project', async ({ page }) => {
  await page.goto('/signup');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'SecurePass123!');
  await page.click('button[type="submit"]');

  // Should redirect to onboarding
  await expect(page).toHaveURL('/onboarding');

  await page.fill('[name="project-name"]', 'My First Project');
  await page.click('text=Create Project');

  // Should show the new project
  await expect(page.locator('h1')).toHaveText('My First Project');
});
```

## Mocking

### When to Mock

**Mock:**
- External services (APIs, databases in unit tests, email, payment)
- Time/dates (use fake timers)
- Random values
- File system in unit tests

**Don't mock:**
- The thing you're testing
- Simple data structures
- Everything (over-mocking makes tests brittle)

### Mocking Patterns

```typescript
// Dependency injection — most testable pattern
class OrderService {
  constructor(
    private readonly inventory: InventoryService,
    private readonly payment: PaymentService,
    private readonly email: EmailService,
  ) {}

  async placeOrder(order: Order): Promise<OrderResult> {
    const available = await this.inventory.check(order.items);
    if (!available) throw new Error('Out of stock');

    const charge = await this.payment.charge(order.total);
    await this.email.send(order.customerEmail, 'order-confirmation', { order });

    return { orderId: charge.id, status: 'confirmed' };
  }
}

// Test with mocks
it('sends confirmation email after successful payment', async () => {
  const inventory = { check: jest.fn().mockResolvedValue(true) };
  const payment = { charge: jest.fn().mockResolvedValue({ id: 'ch_123' }) };
  const email = { send: jest.fn().mockResolvedValue(undefined) };

  const service = new OrderService(inventory, payment, email);
  await service.placeOrder(mockOrder);

  expect(email.send).toHaveBeenCalledWith(
    'customer@test.com',
    'order-confirmation',
    expect.objectContaining({ order: mockOrder })
  );
});

it('does not charge payment when out of stock', async () => {
  const inventory = { check: jest.fn().mockResolvedValue(false) };
  const payment = { charge: jest.fn() };
  const email = { send: jest.fn() };

  const service = new OrderService(inventory, payment, email);
  await expect(service.placeOrder(mockOrder)).rejects.toThrow('Out of stock');

  expect(payment.charge).not.toHaveBeenCalled();
  expect(email.send).not.toHaveBeenCalled();
});
```

### Mocking Time

```typescript
beforeEach(() => {
  jest.useFakeTimers();
  jest.setSystemTime(new Date('2024-01-15T10:00:00Z'));
});

afterEach(() => {
  jest.useRealTimers();
});

it('expires tokens after 24 hours', () => {
  const token = createToken();
  expect(token.isValid()).toBe(true);

  jest.advanceTimersByTime(24 * 60 * 60 * 1000 + 1);
  expect(token.isValid()).toBe(false);
});
```

## React Component Testing

```typescript
import { render, screen, userEvent } from '@testing-library/react';

describe('LoginForm', () => {
  it('submits email and password', async () => {
    const onSubmit = jest.fn();
    render(<LoginForm onSubmit={onSubmit} />);

    await userEvent.type(screen.getByLabelText('Email'), 'test@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'password123');
    await userEvent.click(screen.getByRole('button', { name: 'Sign in' }));

    expect(onSubmit).toHaveBeenCalledWith({
      email: 'test@example.com',
      password: 'password123',
    });
  });

  it('shows validation error for invalid email', async () => {
    render(<LoginForm onSubmit={jest.fn()} />);

    await userEvent.type(screen.getByLabelText('Email'), 'not-an-email');
    await userEvent.click(screen.getByRole('button', { name: 'Sign in' }));

    expect(screen.getByText('Please enter a valid email')).toBeInTheDocument();
  });

  it('disables submit button while loading', () => {
    render(<LoginForm onSubmit={jest.fn()} isLoading />);
    expect(screen.getByRole('button', { name: 'Signing in...' })).toBeDisabled();
  });
});
```

## Test Quality Checklist

- [ ] Tests describe behavior, not implementation
- [ ] Each test is independent (no shared mutable state)
- [ ] Tests are deterministic (no flaky tests)
- [ ] Failures produce clear messages about what went wrong
- [ ] No logic in tests (no conditionals, loops)
- [ ] Test edge cases: empty inputs, null, boundaries, errors
- [ ] Tests run fast (unit tests < 100ms each)
- [ ] Coverage is meaningful (not just line count — test behavior paths)

## Coverage Guidelines

- **Don't chase 100%** — aim for 80%+ on critical business logic
- **Focus on:** public APIs, business rules, error handling, edge cases
- **Skip testing:** trivial getters, framework glue, configuration
- **Branch coverage > line coverage** — make sure all if/else paths are tested
- **Coverage is a compass, not a destination** — high coverage with bad tests is worse than moderate coverage with good tests
