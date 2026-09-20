# State Management — Lotto Fullstack

## Server / persistent state

- **PostgreSQL (Supabase)** is the source of truth for draws, algorithms, recommendations, notification records.
- Use migrations for schema changes — no ad-hoc production DDL from the dashboard.

## Auth state

- Admin: Supabase Auth session (SSR cookie helpers in `lib/supabase/server.ts`).
- Mobile: no user auth; public read of published rows.

## Client state (admin)

- Prefer React Server Components + server fetches.
- Local UI state: React `useState` / URL search params.
- Do not introduce Redux / Zustand unless a clear multi-screen client store is required.

## Realtime (optional later)

- Supabase Realtime can refresh admin tables; keep subscriptions in client components or hooks, not in repositories mixed with write logic.
