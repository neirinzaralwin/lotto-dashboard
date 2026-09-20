# Folder Structure — Lotto Fullstack

```
lotto_fullstack/
├── apps/admin-dashboard/
│   ├── app/                    # App Router pages
│   │   ├── page.tsx            # Overview
│   │   ├── draws/
│   │   ├── import/
│   │   ├── algorithms/
│   │   └── notifications/
│   ├── components/             # UI components
│   ├── lib/supabase/           # browser + server clients
│   ├── services/               # domain services (add as features land)
│   └── validation/             # zod schemas when forms are added
├── packages/types/src/         # shared wire types
└── supabase/
    ├── migrations/
    └── functions/<name>/index.ts
```

## Placement rules

- New admin screens → `apps/admin-dashboard/app/<route>/page.tsx`
- Reusable UI → `components/`
- Supabase client helpers → `lib/supabase/` only
- Shared TS contracts → `packages/types`
- Schema changes → new file under `supabase/migrations/`
- Algorithm runners → `supabase/functions/`
