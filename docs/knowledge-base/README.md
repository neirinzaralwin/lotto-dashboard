# Knowledge Base — Lotto (fullstack)

Authoritative rules for AI agents working on this codebase. Root `.cursorrules` and `CLAUDE.md` point here.

## Read These In Order

1. [architecture_overview.md](architecture_overview.md) — clients, Supabase, admin dashboard
2. [folder_structure.md](folder_structure.md) — where every new file goes
3. [module_boundaries.md](module_boundaries.md) — workspace + folder public surfaces
4. [dependency_map.md](dependency_map.md) — allowed import directions
5. [coding_rules.md](coding_rules.md) — naming, lint, Next patterns
6. [typescript_rules.md](typescript_rules.md) — strict TS policy
7. [state_management.md](state_management.md) — Postgres, Auth, client state
8. [solid_principles.md](solid_principles.md) — SOLID for Next + Supabase
9. [supabase-rules.md](supabase-rules.md) — migrations, RLS, Edge Functions, Storage
10. [excel-import-rules.md](excel-import-rules.md) — SheetJS import pipeline

**Admin UI:** [design-system.md](../design-system.md)

Product SOW (parent folder): `../../docs/Lotto-app-contract.md`

## Hard Rules

- Follow architecture, boundaries, and dependency direction exactly.
- Never commit service-role keys; never put them in the Flutter app.
- Mobile reads only **published** rows via anon key + RLS.
- Algorithms run in **Supabase Edge Functions**, not in the Next.js browser bundle.
- Excel import uses **SheetJS (`xlsx`)** with preview → validate → confirm.
- Run `npm run lint` and `npm run check-types` before finishing changes.
- Prefer improving existing structure over inventing new patterns.
