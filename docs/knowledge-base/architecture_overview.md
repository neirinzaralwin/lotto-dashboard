# Architecture Overview — Lotto Fullstack

## System

```
Flutter (public)  --anon+RLS-->  Supabase (Postgres / Auth / Storage / Edge Functions)
Admin Dashboard   --Auth+CRUD-->  Supabase
Edge Functions    --service-->    algorithms → recommendations
FCM               --push-->       Flutter
Vercel            --hosts-->      Admin Dashboard
```

- **No NestJS API.** Supabase is the backend.
- **No Docker Compose** for app runtime; use Supabase CLI (`supabase start`) for local stack.
- Mobile users do **not** sign in. Admin staff **do** (Supabase Auth).

## Workspace topology

```
lotto_fullstack/
├── apps/admin-dashboard/   # Next.js App Router admin (Vercel)
├── packages/
│   ├── types/              # Shared draw / algorithm / notification types
│   ├── eslint-config/
│   └── typescript-config/
└── supabase/
    ├── migrations/
    ├── functions/          # e.g. run-algorithms
    └── config.toml
```

## Admin app layers

| Layer                  | Location                              | Responsibility                 |
| ---------------------- | ------------------------------------- | ------------------------------ |
| Presentation           | `app/`, `components/`                 | UI only                        |
| Domain / orchestration | `services/`, hooks                    | Business flows, calls Supabase |
| Data                   | `lib/supabase/*`, Edge Functions, SQL | Persistence, RLS, algorithms   |

## Feature areas (dashboard)

| Area          | Route stub       | Notes                         |
| ------------- | ---------------- | ----------------------------- |
| Overview      | `/`              | Counts, latest uploads        |
| Draws         | `/draws`         | CRUD + publish                |
| Excel Import  | `/import`        | SheetJS pipeline              |
| Algorithms    | `/algorithms`    | Config + invoke Edge Function |
| Notifications | `/notifications` | FCM compose / send records    |
