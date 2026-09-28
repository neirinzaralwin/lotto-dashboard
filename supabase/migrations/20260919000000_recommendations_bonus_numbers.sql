-- Favorite picks need main + bonus numbers (Lotto 6: 6+1, Lotto 7: 7+2).
-- Mobile reads published rows; admin publishes both arrays per slot.
alter table public.recommendations
    add column if not exists bonus_numbers integer[] not null default '{}';
