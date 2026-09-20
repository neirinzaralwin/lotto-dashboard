# Module Boundaries — Lotto Fullstack

## Workspace

| Package                   | Public surface                          | Private                         |
| ------------------------- | --------------------------------------- | ------------------------------- |
| `admin-dashboard`         | HTTP UI on Vercel                       | `lib/`, `components/` internals |
| `@repo/types`             | exported types from `src/index.ts`      | implementation details in dist  |
| `@repo/eslint-config`     | `./base`, `./next-js`, etc.             | —                               |
| `@repo/typescript-config` | JSON configs                            | —                               |
| `supabase/`               | migrations + functions deployed via CLI | local `.temp`                   |

## Rules

- Apps must not import each other's source (there is only one app today).
- Admin must not import Edge Function source; invoke via HTTP / `supabase.functions.invoke`.
- Do not import `@repo/types` deep paths — use package root export.
- Keep service-role usage on the **server** only (Route Handlers / Edge Functions), never in client components.
