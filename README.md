# Lotto Fullstack

Admin dashboard + Supabase backend for the Lotto 6 & Lotto 7 results platform.

## Stack

| Piece           | Tech                                                        |
| --------------- | ----------------------------------------------------------- |
| Admin dashboard | Next.js + TypeScript (Vercel)                               |
| Backend         | Supabase (Postgres, Auth, Storage optional, Edge Functions) |
| Excel import    | SheetJS (`xlsx`)                                            |
| Shared types    | `@repo/types`                                               |
| Tooling         | Turborepo, Prettier, Husky, Graphify                        |

No Docker Compose / NestJS API — use the Supabase CLI for local backend.

## Sibling layout

```
lotto/
├── docs/                 # shared contract (parent folder, not in this git repo)
├── lotto_flutter/        # mobile app (separate git repo)
└── lotto_fullstack/      # this repo
```

## Quick start

See [SETUP.md](./SETUP.md).

```bash
npm install
npm run dev                 # admin on http://localhost:3000
# In another terminal (after Supabase CLI install):
supabase start
```

## Agent docs

- [`CLAUDE.md`](./CLAUDE.md) / [`.cursorrules`](./.cursorrules)
- [`docs/knowledge-base/`](./docs/knowledge-base/)
- [`GRAPHIFY.md`](./GRAPHIFY.md)
