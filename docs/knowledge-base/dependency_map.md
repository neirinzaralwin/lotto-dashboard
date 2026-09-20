# Dependency Map — Lotto Fullstack

## Allowed

```
app/(pages) → components → (optional) services → lib/supabase
services → @repo/types
supabase/functions → Supabase client (Deno) → Postgres
```

## Forbidden

- `components/` → raw `createClient` sprawl (prefer `services/` or `lib/supabase` helpers)
- Client components → `SUPABASE_SERVICE_ROLE_KEY`
- Admin app → Flutter source
- Browser bundle → algorithm implementation (use Edge Functions)
- Cross-package relative imports like `../../../packages/types/src/...` (use `@repo/types`)
