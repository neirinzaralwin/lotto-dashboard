# Design System — Lotto Admin

**Calm Intelligence** — Soft Swiss / Editorial Bento Dashboard, with a **workspace shell** (icon rail + search + tabs + metric cards).

Complex lottery admin data presented with editorial calm — not dense SaaS chrome, not marketing fluff.

## Ideology

| Pillar | Practice |
| --- | --- |
| Soft Swiss / Editorial | Strong type hierarchy, generous whitespace, intentional placement, near-monochrome |
| Workspace layout | Slim Lucide icon sidebar, pill search, breadcrumbs, underline tabs, bordered metric cards |
| Bento grid | Independent modules that compose as one surface |
| Soft Brutalism | Simple geometry, almost no shadows, high contrast, large rounded corners |
| Quiet color | 90% neutral + 10% semantic pastel accents (peach / sage) |
| Data minimalism | Big numbers, delta pills, dots — not chart clutter |

Hierarchy: **Number → status → context**.

## Layout (admin shell)

```
┌────┬──────────────────────────────────────┐
│ ⬤  │  [ 🔍 Search…                    ]   │
│ ⬤  ├──────────────────────────────────────┤
│ ⬤  │  crumbs · page title · mark           │
│ ⬤  │  metric · metric · metric             │
│ ⬤  │  tabs ───────────────────────────     │
│    │  content cards / composer             │
└────┴──────────────────────────────────────┘
```

- Sidebar: `components/app-shell.tsx` — Lucide icons, soft active tile
- Search: global via `ShellSearchProvider` / `useShellSearch()`
- Page chrome: `PageHeader`, `MetricCard`, `UnderlineTabs` in `components/layout/`

## Icons (global standard)

**Use [Lucide](https://lucide.dev) (`lucide-react`) for all admin-dashboard icons.**

| Rule | Detail |
| --- | --- |
| Package | `lucide-react` |
| Wrapper | `components/ui/icon.tsx` → `AppIcon` |
| Defaults | size `18`, strokeWidth `1.75` |
| Style | Outline only; no emoji / Material / Heroicons mix |

```tsx
import { Bell } from 'lucide-react';
import { AppIcon } from '@/components/ui/icon';

<AppIcon icon={Bell} size={16} />
```

## Tokens (`app/globals.css`)

| Token | Value | Role |
| --- | --- | --- |
| `--lotto-bg` | `#FFFFFF` | Workspace ground |
| `--lotto-sidebar` | `#F4F4F5` | Icon rail |
| `--lotto-surface` | `#FFFFFF` | Cards |
| `--lotto-border` | `#E5E5E5` | Thin module edges |
| `--lotto-fg` | `#111111` | Primary information |
| `--lotto-muted` | `#707070` | Secondary text |
| `--lotto-excellent-soft` | peach | Soft accent |
| `--lotto-strong-soft` / `--lotto-delta-bg` | sage | Positive / sent |
| `--lotto-radius` | `24px` | Soft modules |

Typography: **DM Sans**. Medium/bold headings, quiet labels, oversized numerals.

## Components

- `components/app-shell.tsx` — sidebar + search shell
- `components/layout/*` — `PageHeader`, `MetricCard`, `UnderlineTabs`, `TablePagination`, `SlideOver`, `shell-search`
- `components/ui/icon.tsx` — Lucide `AppIcon`
- `components/bento/primitives.tsx` — Soft Swiss modules
- `components/notifications/notifications-manager.tsx` — notification CRUD

## Notifications UI

`/notifications`:

- Metrics + tabs: **All / Drafts / Sent / Settings**
- Full-width **data table** (20 / page) — click title to open **right slide-over** detail
- Create / edit in the same sheet; no side composer
- **No audience targeting** — pushes go to all active users
- Settings: two auto-notify switches — Lotto 6 / Lotto 7 results out → push to all active users
- Header search is minimal and right-aligned

## UI principles

- One job per page; Overview keeps the densest bento composition.
- Prefer thin borders over shadows; white ground over cream washes.
- Do not copy Savior burgundy/gold ministry branding.
- Keep navigation in `components/app-shell.tsx`.
- Wire Supabase / FCM when ready; current notification CRUD is in-browser.
