-- Notifications: draft/sent status, updated_at, and persistent auto-notify settings.

alter table public.notification_records
    add column if not exists status text;

update public.notification_records
set status = case when sent_at is not null then 'sent' else 'draft' end
where status is null;

alter table public.notification_records
    alter column status set default 'draft';

alter table public.notification_records
    alter column status set not null;

do $$
begin
    if not exists (
        select 1
        from pg_constraint
        where conname = 'notification_records_status_check'
    ) then
        alter table public.notification_records
            add constraint notification_records_status_check
            check (status in ('draft', 'sent'));
    end if;
end $$;

alter table public.notification_records
    add column if not exists updated_at timestamptz;

update public.notification_records
set updated_at = coalesce(sent_at, created_at, now())
where updated_at is null;

alter table public.notification_records
    alter column updated_at set default now();

alter table public.notification_records
    alter column updated_at set not null;

create table if not exists public.notification_settings (
    id uuid primary key default gen_random_uuid(),
    auto_notify_lotto6 boolean not null default true,
    auto_notify_lotto7 boolean not null default true,
    updated_at timestamptz not null default now()
);

insert into public.notification_settings (auto_notify_lotto6, auto_notify_lotto7)
select true, true
where not exists (select 1 from public.notification_settings);

alter table public.notification_settings enable row level security;

do $$
begin
    if not exists (
        select 1
        from pg_policies
        where schemaname = 'public'
          and tablename = 'notification_settings'
          and policyname = 'Authenticated manage notification settings'
    ) then
        create policy "Authenticated manage notification settings"
            on public.notification_settings
            for all
            to authenticated
            using (true)
            with check (true);
    end if;
end $$;
