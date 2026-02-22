---
name: supabase-postgres
description: Supabase and PostgreSQL best practices for schema design, RLS policies, edge functions, migrations, and performance.
---

# Supabase & PostgreSQL

Best practices for building with Supabase and PostgreSQL. Covers schema design, Row Level Security, edge functions, migrations, and performance optimization.

## Schema Design

### Use Proper Data Types

```sql
-- ❌ Common mistakes
CREATE TABLE users (
  id serial PRIMARY KEY,           -- use uuid instead
  email varchar(255),              -- use text (no practical advantage to varchar in pg)
  age varchar(3),                  -- use integer
  price float,                     -- use numeric for money
  metadata text,                   -- use jsonb
  created_at varchar(30)           -- use timestamptz
);

-- ✅ Proper types
CREATE TABLE users (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  email text UNIQUE NOT NULL,
  age integer CHECK (age > 0 AND age < 200),
  balance numeric(12, 2) NOT NULL DEFAULT 0,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now() NOT NULL,
  updated_at timestamptz DEFAULT now() NOT NULL
);
```

### Naming Conventions

- **Tables:** plural, snake_case (`team_members`, `order_items`)
- **Columns:** snake_case (`first_name`, `created_at`)
- **Primary keys:** `id` (uuid)
- **Foreign keys:** `<singular_table>_id` (e.g., `user_id`, `team_id`)
- **Booleans:** prefix with `is_` or `has_` (`is_active`, `has_verified_email`)
- **Timestamps:** suffix with `_at` (`created_at`, `deleted_at`)
- **Indexes:** `idx_<table>_<columns>` (`idx_users_email`)

### Common Patterns

```sql
-- Soft deletes
ALTER TABLE posts ADD COLUMN deleted_at timestamptz;
CREATE INDEX idx_posts_active ON posts (id) WHERE deleted_at IS NULL;

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- Enum as check constraint (more flexible than pg enums for Supabase)
CREATE TABLE orders (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  status text NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
);

-- Multi-tenant with organization_id
CREATE TABLE projects (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id uuid REFERENCES organizations(id) NOT NULL,
  name text NOT NULL,
  created_at timestamptz DEFAULT now() NOT NULL
);
CREATE INDEX idx_projects_org ON projects (organization_id);
```

## Row Level Security (RLS)

### Fundamentals

Always enable RLS on tables that store user data:

```sql
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Users can read their own posts
CREATE POLICY "Users read own posts"
  ON posts FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own posts
CREATE POLICY "Users create own posts"
  ON posts FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own posts
CREATE POLICY "Users update own posts"
  ON posts FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Users can delete their own posts
CREATE POLICY "Users delete own posts"
  ON posts FOR DELETE
  USING (auth.uid() = user_id);
```

### Team/Organization Access

```sql
-- Helper function to check team membership
CREATE OR REPLACE FUNCTION is_team_member(team_uuid uuid)
RETURNS boolean AS $$
  SELECT EXISTS (
    SELECT 1 FROM team_members
    WHERE team_id = team_uuid
    AND user_id = auth.uid()
  );
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Team members can read team projects
CREATE POLICY "Team members read projects"
  ON projects FOR SELECT
  USING (is_team_member(team_id));

-- Only team admins can modify projects
CREATE OR REPLACE FUNCTION is_team_admin(team_uuid uuid)
RETURNS boolean AS $$
  SELECT EXISTS (
    SELECT 1 FROM team_members
    WHERE team_id = team_uuid
    AND user_id = auth.uid()
    AND role = 'admin'
  );
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE POLICY "Team admins manage projects"
  ON projects FOR ALL
  USING (is_team_admin(team_id))
  WITH CHECK (is_team_admin(team_id));
```

### RLS Performance Tips

- **Use `SECURITY DEFINER` functions** for complex permission checks (avoids RLS recursion)
- **Add indexes** on columns used in RLS policies (e.g., `user_id`, `team_id`)
- **Keep policies simple** — complex subqueries in USING clauses hurt performance
- **Use `auth.uid()` directly** when possible (it's indexed internally)
- **Avoid `IN (SELECT ...)` in policies** — use helper functions instead

```sql
-- ❌ Slow: subquery in every row check
CREATE POLICY "slow_policy" ON documents FOR SELECT
USING (
  team_id IN (
    SELECT team_id FROM team_members WHERE user_id = auth.uid()
  )
);

-- ✅ Fast: helper function (cached per transaction)
CREATE POLICY "fast_policy" ON documents FOR SELECT
USING (is_team_member(team_id));
```

### Public Access Patterns

```sql
-- Public read, authenticated write
CREATE POLICY "Anyone can read published posts"
  ON posts FOR SELECT
  USING (published = true);

CREATE POLICY "Authenticated users create posts"
  ON posts FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');
```

## Edge Functions

### Structure

```typescript
// supabase/functions/my-function/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    // Create client with user's auth context
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! },
        },
      }
    );

    // Get authenticated user
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Business logic here
    const { data, error } = await supabase
      .from('posts')
      .select('*')
      .eq('user_id', user.id);

    return new Response(JSON.stringify({ data }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
```

### When to Use Edge Functions vs RLS + Client

- **Use client + RLS** for simple CRUD operations
- **Use edge functions** for:
  - Third-party API calls (keep secrets server-side)
  - Complex business logic that spans multiple tables
  - Webhook handlers
  - Operations that need service_role access
  - Rate limiting, validation beyond what DB constraints handle

## Migrations

### Structure

```
supabase/
  migrations/
    20240101000000_create_users.sql
    20240102000000_add_posts.sql
    20240103000000_add_rls_policies.sql
  seed.sql
```

### Best Practices

```sql
-- Always use IF NOT EXISTS / IF EXISTS for idempotency
CREATE TABLE IF NOT EXISTS users ( ... );
DROP INDEX IF EXISTS idx_users_email;

-- Wrap in transactions
BEGIN;
  ALTER TABLE posts ADD COLUMN slug text;
  UPDATE posts SET slug = lower(replace(title, ' ', '-'));
  ALTER TABLE posts ALTER COLUMN slug SET NOT NULL;
  CREATE UNIQUE INDEX idx_posts_slug ON posts (slug);
COMMIT;

-- Add columns as nullable first, then backfill, then add constraint
-- This avoids locking the table for long periods
ALTER TABLE users ADD COLUMN display_name text;
-- Backfill in batches
UPDATE users SET display_name = email WHERE display_name IS NULL;
ALTER TABLE users ALTER COLUMN display_name SET NOT NULL;
```

### Generating Migrations

```bash
# Create a new migration
supabase migration new add_comments_table

# Apply migrations locally
supabase db reset

# Push to remote
supabase db push

# Pull remote changes (if schema was modified in dashboard)
supabase db pull
```

## Performance

### Indexing Strategy

```sql
-- Index columns used in WHERE, JOIN, ORDER BY
CREATE INDEX idx_posts_user_id ON posts (user_id);
CREATE INDEX idx_posts_created_at ON posts (created_at DESC);

-- Composite index for common query patterns
CREATE INDEX idx_posts_user_status ON posts (user_id, status);

-- Partial index for common filters
CREATE INDEX idx_posts_published ON posts (created_at DESC) WHERE published = true;

-- GIN index for JSONB queries
CREATE INDEX idx_users_metadata ON users USING gin (metadata);

-- GIN index for full-text search
ALTER TABLE posts ADD COLUMN fts tsvector
  GENERATED ALWAYS AS (to_tsvector('english', title || ' ' || body)) STORED;
CREATE INDEX idx_posts_fts ON posts USING gin (fts);
```

### Query Optimization

```sql
-- Use EXPLAIN ANALYZE to understand query plans
EXPLAIN ANALYZE
SELECT * FROM posts WHERE user_id = 'xxx' ORDER BY created_at DESC LIMIT 20;

-- Pagination: use cursor-based, not OFFSET
-- ❌ Slow for deep pages
SELECT * FROM posts ORDER BY created_at DESC LIMIT 20 OFFSET 1000;

-- ✅ Cursor-based pagination
SELECT * FROM posts
WHERE created_at < '2024-01-15T10:30:00Z'
ORDER BY created_at DESC
LIMIT 20;
```

### Supabase Client Performance

```typescript
// Select only needed columns
const { data } = await supabase
  .from('posts')
  .select('id, title, created_at')  // not select('*')
  .eq('published', true)
  .order('created_at', { ascending: false })
  .limit(20);

// Use count option instead of fetching all rows
const { count } = await supabase
  .from('posts')
  .select('*', { count: 'exact', head: true })
  .eq('user_id', userId);

// Batch related queries
const [postsResult, profileResult] = await Promise.all([
  supabase.from('posts').select('*').eq('user_id', id),
  supabase.from('profiles').select('*').eq('id', id).single(),
]);
```

### Realtime Optimization

```typescript
// Subscribe to specific rows, not entire tables
const channel = supabase
  .channel('room-messages')
  .on(
    'postgres_changes',
    {
      event: 'INSERT',
      schema: 'public',
      table: 'messages',
      filter: `room_id=eq.${roomId}`,  // filter server-side
    },
    (payload) => handleNewMessage(payload.new)
  )
  .subscribe();

// Clean up subscriptions
return () => {
  supabase.removeChannel(channel);
};
```

## Auth Patterns

```typescript
// Protect API routes (Next.js example)
import { createServerClient } from '@supabase/ssr';

export async function middleware(request: NextRequest) {
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    { cookies: { /* cookie handlers */ } }
  );

  const { data: { user } } = await supabase.auth.getUser();

  if (!user && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
}
```

## Storage

```typescript
// Upload with proper content type
const { error } = await supabase.storage
  .from('avatars')
  .upload(`${userId}/avatar.png`, file, {
    contentType: 'image/png',
    upsert: true,  // overwrite existing
  });

// Get public URL
const { data } = supabase.storage
  .from('avatars')
  .getPublicUrl(`${userId}/avatar.png`);

// Storage RLS via policies on storage.objects
CREATE POLICY "Users manage own avatars"
  ON storage.objects FOR ALL
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);
```
