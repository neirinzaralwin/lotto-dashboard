# Coding Rules — Lotto Fullstack

## Naming

- Files: `kebab-case` for components/pages; `snake_case` SQL migrations with timestamp prefix
- React components: `PascalCase`
- Functions / variables: `camelCase`
- DB columns: `snake_case`

## Lint / types

- Run `npm run lint` and `npm run check-types` in the touched workspace before finishing.
- Prefer `@repo/eslint-config` and `@repo/typescript-config`.
- Prettier: 4-space indent, single quotes, trailing commas (root `.prettierrc`).

## Next.js

- App Router only.
- Prefer Server Components by default; mark `"use client"` only when needed.
- Env: `NEXT_PUBLIC_*` for browser; secrets without that prefix stay server-only.

## Icons (admin-dashboard)

- **Lucide only** (`lucide-react`) — global standard for `apps/admin-dashboard`.
- Import icons from `lucide-react` and render via `AppIcon` in `components/ui/icon.tsx`.
- Do not add Material Icons, Heroicons, Font Awesome, or emoji as UI icons.
- Documented in `docs/design-system.md`.

## Errors

- Surface actionable messages in the admin UI for validation / import failures.
- Do not swallow Supabase errors silently.
