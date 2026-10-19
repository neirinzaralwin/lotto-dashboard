-- How many newest published draws Favorite 3/4 (Date/Time digital-root key)
-- look at. Was a hard-coded 500; admins tune it from the Algorithms page.
alter table public.app_settings
    add column if not exists favorite_key_history_rows integer not null default 20;

do $$
begin
    if not exists (
        select 1 from pg_constraint where conname = 'app_settings_favorite_key_history_rows_range'
    ) then
        alter table public.app_settings
            add constraint app_settings_favorite_key_history_rows_range
            check (favorite_key_history_rows between 5 and 200);
    end if;
end $$;
