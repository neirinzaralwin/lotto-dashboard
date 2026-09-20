# Supabase Rules — Lotto Fullstack

## Migrations

- Add new SQL under `supabase/migrations/` with timestamp prefixes.
- Never edit applied production migrations in place — add a follow-up migration.
- Local: `supabase start` then `supabase db reset` (or `migration up`) as documented in SETUP.md.

## RLS

- Enable RLS on every public table that stores product data.
- **Anon** may `SELECT` only `is_published = true` draws/recommendations.
- Admin writes: authenticated policies and/or service role on the server.
- Never ship the service role key to Flutter or browser bundles.

## Edge Functions

- Algorithm execution lives in `supabase/functions/*`.
- Validate caller (JWT / secret) before mutating data.
- Write recommendations with explicit publish flags; mobile only sees published rows.

## Storage (optional)

- Use Supabase Storage only if Excel originals or assets need retention.
- Prefer private buckets + signed URLs for admin; do not expose raw service credentials.

## Auth

- Dashboard staff use Supabase Auth (email/password or providers as agreed).
- Mobile does not create end-user accounts.
