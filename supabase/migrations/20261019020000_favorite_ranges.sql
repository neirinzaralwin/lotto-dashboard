-- Per-favorite history range (min–max rows), edited on each Algorithms tab.
--   1, 2 = dynamic window (was hard-coded 7–20)
--   3, 4 = Date/Time key history (was 500, then a single row count)
-- Replaces app_settings.favorite_key_history_rows from 20261019010000.
alter table public.app_settings
    add column if not exists favorite_ranges jsonb not null default
        '{"1":{"min":7,"max":20},"2":{"min":7,"max":20},"3":{"min":15,"max":20},"4":{"min":15,"max":20}}'::jsonb;

alter table public.app_settings
    drop column if exists favorite_key_history_rows;
