---
name: react-best-practices
description: React and Next.js performance optimization, component patterns, and anti-patterns to avoid.
---

# React & Next.js Best Practices

Comprehensive guide to building performant, maintainable React and Next.js applications. Use this when writing React code, reviewing components, or optimizing performance.

## Component Design Patterns

### Composition Over Configuration

Prefer composable components over prop-heavy monoliths:

```tsx
// ❌ Prop explosion
<Card
  title="Hello"
  titleSize="lg"
  titleColor="blue"
  subtitle="World"
  showFooter
  footerAlign="right"
  footerContent={<Button>Save</Button>}
/>

// ✅ Composition
<Card>
  <Card.Header>
    <Card.Title size="lg" color="blue">Hello</Card.Title>
    <Card.Subtitle>World</Card.Subtitle>
  </Card.Header>
  <Card.Footer align="right">
    <Button>Save</Button>
  </Card.Footer>
</Card>
```

### Container/Presentational Split

Separate data logic from rendering:

```tsx
// Container: handles data
function UserProfileContainer({ userId }: { userId: string }) {
  const { data: user, isLoading } = useQuery(['user', userId], () => fetchUser(userId));
  if (isLoading) return <ProfileSkeleton />;
  return <UserProfile user={user} />;
}

// Presentational: pure rendering, easy to test
function UserProfile({ user }: { user: User }) {
  return (
    <div className="flex gap-4">
      <Avatar src={user.avatar} alt={user.name} />
      <div>
        <h2>{user.name}</h2>
        <p>{user.bio}</p>
      </div>
    </div>
  );
}
```

### Custom Hooks for Reusable Logic

Extract complex logic into hooks:

```tsx
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value);
  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(handler);
  }, [value, delay]);
  return debouncedValue;
}

function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(false);
  useEffect(() => {
    const media = window.matchMedia(query);
    setMatches(media.matches);
    const listener = (e: MediaQueryListEvent) => setMatches(e.matches);
    media.addEventListener('change', listener);
    return () => media.removeEventListener('change', listener);
  }, [query]);
  return matches;
}
```

## Performance Optimization

### Preventing Unnecessary Re-renders

```tsx
// ❌ Creates new object every render, children always re-render
function Parent() {
  const style = { color: 'red' };
  return <Child style={style} />;
}

// ✅ Stable reference
function Parent() {
  const style = useMemo(() => ({ color: 'red' }), []);
  return <Child style={style} />;
}

// ❌ Inline function creates new reference
<Button onClick={() => handleClick(id)} />

// ✅ Stable callback
const handleButtonClick = useCallback(() => handleClick(id), [id]);
<Button onClick={handleButtonClick} />
```

### When to Use React.memo

Use `React.memo` when:
- Component renders often with same props
- Component is expensive to render
- Parent re-renders frequently but child props don't change

Don't use when:
- Props change on almost every render
- Component is cheap to render
- You're prematurely optimizing

```tsx
const ExpensiveList = React.memo(function ExpensiveList({ items }: { items: Item[] }) {
  return (
    <ul>
      {items.map(item => (
        <li key={item.id}>{expensiveTransform(item)}</li>
      ))}
    </ul>
  );
});
```

### Virtualization for Large Lists

```tsx
import { useVirtualizer } from '@tanstack/react-virtual';

function VirtualList({ items }: { items: Item[] }) {
  const parentRef = useRef<HTMLDivElement>(null);
  const virtualizer = useVirtualizer({
    count: items.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
  });

  return (
    <div ref={parentRef} style={{ height: '400px', overflow: 'auto' }}>
      <div style={{ height: `${virtualizer.getTotalSize()}px`, position: 'relative' }}>
        {virtualizer.getVirtualItems().map(virtualRow => (
          <div
            key={virtualRow.key}
            style={{
              position: 'absolute',
              top: 0,
              transform: `translateY(${virtualRow.start}px)`,
              height: `${virtualRow.size}px`,
            }}
          >
            {items[virtualRow.index].name}
          </div>
        ))}
      </div>
    </div>
  );
}
```

### Code Splitting

```tsx
// Route-level splitting
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Settings = lazy(() => import('./pages/Settings'));

// Component-level splitting for heavy components
const HeavyChart = lazy(() => import('./components/HeavyChart'));

function App() {
  return (
    <Suspense fallback={<PageSkeleton />}>
      <Routes>
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/settings" element={<Settings />} />
      </Routes>
    </Suspense>
  );
}
```

## Next.js Specific

### Rendering Strategies

**Use Static Generation (SSG) when:**
- Content doesn't change per-request (blog posts, docs, marketing pages)
- Data can be fetched at build time

**Use Server-Side Rendering (SSR) when:**
- Content changes per-request (personalized dashboards, search results)
- You need request-time data (cookies, headers)

**Use Incremental Static Regeneration (ISR) when:**
- Content changes but not on every request
- You want static performance with fresh data

```tsx
// App Router - Static by default
export default async function BlogPost({ params }: { params: { slug: string } }) {
  const post = await getPost(params.slug); // cached automatically
  return <Article post={post} />;
}

// Opt into dynamic rendering
export const dynamic = 'force-dynamic';

// ISR with revalidation
export const revalidate = 3600; // revalidate every hour
```

### Server Components vs Client Components

```tsx
// Server Component (default in App Router) - no "use client" directive
// ✅ Can: access DB, read files, use secrets, zero JS sent to client
// ❌ Cannot: use state, effects, browser APIs, event handlers
async function ProductPage({ id }: { id: string }) {
  const product = await db.product.findUnique({ where: { id } });
  return (
    <div>
      <h1>{product.name}</h1>
      <p>{product.description}</p>
      <AddToCartButton productId={id} /> {/* Client component */}
    </div>
  );
}

// Client Component - needs interactivity
'use client';
function AddToCartButton({ productId }: { productId: string }) {
  const [loading, setLoading] = useState(false);
  return (
    <button onClick={() => addToCart(productId)} disabled={loading}>
      Add to Cart
    </button>
  );
}
```

**Rule of thumb:** Keep client boundaries as small and as low in the tree as possible. Don't make a whole page "use client" because one button needs onClick.

### Data Fetching Patterns

```tsx
// Parallel data fetching - don't waterfall
async function Dashboard() {
  // ❌ Sequential - slow
  const user = await getUser();
  const orders = await getOrders();
  const analytics = await getAnalytics();

  // ✅ Parallel - fast
  const [user, orders, analytics] = await Promise.all([
    getUser(),
    getOrders(),
    getAnalytics(),
  ]);

  return <DashboardView user={user} orders={orders} analytics={analytics} />;
}
```

### Image Optimization

```tsx
import Image from 'next/image';

// ✅ Always use next/image for automatic optimization
<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={630}
  priority // for above-the-fold images (skips lazy loading)
  placeholder="blur"
  blurDataURL={blurHash}
/>

// For dynamic/unknown sizes
<Image src={url} alt={alt} fill className="object-cover" sizes="(max-width: 768px) 100vw, 50vw" />
```

## Common Anti-Patterns

### State Management

```tsx
// ❌ Storing derived state
const [items, setItems] = useState([]);
const [filteredItems, setFilteredItems] = useState([]);
const [searchTerm, setSearchTerm] = useState('');

useEffect(() => {
  setFilteredItems(items.filter(i => i.name.includes(searchTerm)));
}, [items, searchTerm]);

// ✅ Derive during render
const [items, setItems] = useState([]);
const [searchTerm, setSearchTerm] = useState('');
const filteredItems = useMemo(
  () => items.filter(i => i.name.includes(searchTerm)),
  [items, searchTerm]
);
```

```tsx
// ❌ useEffect for event handling
useEffect(() => {
  if (submitted) {
    sendAnalytics();
    setSubmitted(false);
  }
}, [submitted]);

// ✅ Just call it in the event handler
function handleSubmit() {
  submitForm();
  sendAnalytics();
}
```

### Key Mistakes

```tsx
// ❌ Index as key when list can reorder/filter
{items.map((item, index) => <Item key={index} data={item} />)}

// ✅ Stable unique identifier
{items.map(item => <Item key={item.id} data={item} />)}
```

## Bundle Optimization

- **Analyze your bundle:** `npx @next/bundle-analyzer` or `npx source-map-explorer`
- **Tree-shake imports:** `import { debounce } from 'lodash-es'` not `import _ from 'lodash'`
- **Dynamic imports for heavy libraries:** `const Plotly = dynamic(() => import('react-plotly.js'), { ssr: false })`
- **Use `next/dynamic` with `ssr: false`** for browser-only libraries (charts, maps, editors)
- **Check package sizes** before adding dependencies: `npx bundlephobia <package>`
- **Prefer native APIs:** `URLSearchParams` over `qs`, `fetch` over `axios`, `structuredClone` over `lodash.cloneDeep`

## TypeScript Patterns

```tsx
// Discriminated unions for component variants
type ButtonProps =
  | { variant: 'link'; href: string; onClick?: never }
  | { variant: 'button'; onClick: () => void; href?: never };

// Generic components
function Select<T extends { id: string; label: string }>({
  items,
  onSelect,
}: {
  items: T[];
  onSelect: (item: T) => void;
}) {
  return (
    <ul>
      {items.map(item => (
        <li key={item.id} onClick={() => onSelect(item)}>{item.label}</li>
      ))}
    </ul>
  );
}

// Polymorphic components
type BoxProps<C extends React.ElementType> = {
  as?: C;
} & React.ComponentPropsWithoutRef<C>;

function Box<C extends React.ElementType = 'div'>({ as, ...props }: BoxProps<C>) {
  const Component = as || 'div';
  return <Component {...props} />;
}
```
