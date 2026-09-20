# TypeScript Rules — Lotto Fullstack

## Compiler policy

- `strict: true` via `@repo/typescript-config`
- Prefer `noUncheckedIndexedAccess` in shared packages
- Avoid `any`; prefer unknown + narrowing
- Forbidden: chained assertions (`as unknown as T`) — use validators / type guards

## Shared types

- Domain wire types live in `@repo/types` (draws, algorithms, notifications)
- Keep dashboard form schemas (zod) in `apps/admin-dashboard/validation/` when added
- DB snake_case ↔ TS camelCase mapping happens in services, not in random components

## ESLint

- Use shared strict TypeScript rules from `@repo/eslint-config/strict-typescript` when configuring typed lint.
