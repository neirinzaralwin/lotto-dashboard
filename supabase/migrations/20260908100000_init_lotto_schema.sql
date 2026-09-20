-- Starter schema for Lotto draws, algorithms, recommendations, and notification records.
-- Refine RLS and columns as product rules firm up.

create extension if not exists "pgcrypto";

create type public.lottery_type as enum ('lotto6', 'lotto7');

create table public.draws (
    id uuid primary key default gen_random_uuid(),
    lottery_type public.lottery_type not null,
    draw_number text not null,
    draw_date date not null,
    winning_numbers integer[] not null,
    bonus_numbers integer[] not null default '{}',
    prize_info text,
    is_published boolean not null default false,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    unique (lottery_type, draw_number)
);

create table public.algorithms (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    description text,
    lottery_type public.lottery_type not null,
    is_enabled boolean not null default true,
    parameters jsonb not null default '{}'::jsonb,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table public.recommendations (
    id uuid primary key default gen_random_uuid(),
    algorithm_id uuid not null references public.algorithms (id) on delete cascade,
    lottery_type public.lottery_type not null,
    numbers integer[] not null,
    generated_at timestamptz not null default now(),
    is_published boolean not null default false
);

create table public.notification_records (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    body text not null,
    target text not null check (target in ('lotto6', 'lotto7', 'all')),
    sent_at timestamptz,
    created_at timestamptz not null default now()
);

alter table public.draws enable row level security;
alter table public.algorithms enable row level security;
alter table public.recommendations enable row level security;
alter table public.notification_records enable row level security;

-- Public mobile app: read published draws / recommendations only (anon key).
create policy "Public read published draws"
    on public.draws
    for select
    to anon, authenticated
    using (is_published = true);

create policy "Public read published recommendations"
    on public.recommendations
    for select
    to anon, authenticated
    using (is_published = true);

-- Staff writes go through authenticated admin roles / service role (refine later).
create policy "Authenticated read all draws"
    on public.draws
    for select
    to authenticated
    using (true);

create policy "Authenticated manage draws"
    on public.draws
    for all
    to authenticated
    using (true)
    with check (true);

create policy "Authenticated manage algorithms"
    on public.algorithms
    for all
    to authenticated
    using (true)
    with check (true);

create policy "Authenticated manage recommendations"
    on public.recommendations
    for all
    to authenticated
    using (true)
    with check (true);

create policy "Authenticated manage notifications"
    on public.notification_records
    for all
    to authenticated
    using (true)
    with check (true);
