-- App-level public settings (legal document URLs). Singleton row; read by the
-- mobile app anonymously, managed by authenticated staff in admin dashboard.

create table if not exists public.app_settings (
    id uuid primary key default gen_random_uuid(),
    privacy_policy_url text not null default '',
    terms_of_service_url text not null default '',
    updated_at timestamptz not null default now()
);

insert into public.app_settings (privacy_policy_url, terms_of_service_url)
select
    'https://privacy-policy-win-search-lotto67.blogspot.com/2026/10/privacy-policy-win-search-loto67-last.html',
    'https://privacy-policy-win-search-lotto67.blogspot.com/2026/10/terms-of-service-win-search-loto67-last.html'
where not exists (select 1 from public.app_settings);

alter table public.app_settings enable row level security;

do $$
begin
    if not exists (
        select 1 from pg_policies
        where schemaname = 'public'
          and tablename = 'app_settings'
          and policyname = 'Public read app settings'
    ) then
        create policy "Public read app settings"
            on public.app_settings
            for select
            to anon, authenticated
            using (true);
    end if;

    if not exists (
        select 1 from pg_policies
        where schemaname = 'public'
          and tablename = 'app_settings'
          and policyname = 'Authenticated manage app settings'
    ) then
        create policy "Authenticated manage app settings"
            on public.app_settings
            for all
            to authenticated
            using (true)
            with check (true);
    end if;
end $$;
