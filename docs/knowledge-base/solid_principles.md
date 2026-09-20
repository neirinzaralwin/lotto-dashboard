# SOLID Principles — Lotto Fullstack

## SRP

| Unit          | Responsibility                          |
| ------------- | --------------------------------------- |
| Page          | Compose UI for one route                |
| Component     | Presentational UI                       |
| Service       | Orchestrate Supabase calls for a domain |
| Migration     | One coherent schema change              |
| Edge Function | One algorithm-run (or related) job      |

## OCP / DIP

- Shared contracts in `@repo/types` so Flutter and Edge Functions can evolve behind stable shapes.
- Swap Supabase env (local vs cloud) without changing feature code.

## ISP

- Keep services thin (`draws-service`, `import-service`) rather than one mega API module.

## LSP

- Typed helpers should honor their contracts; mocks in tests must satisfy the same shapes.
