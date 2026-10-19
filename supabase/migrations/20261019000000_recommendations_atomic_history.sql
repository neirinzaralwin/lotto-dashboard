-- Favourites: atomic publish, kept history, and "numbers last changed".
--
-- Before: publish = insert new row, then delete the others (two round-trips,
-- no transaction). Two admins / two tabs could leave two live rows, and the
-- delete threw away history so "recalculated" and "changed" were the same.
--
-- After: publish_recommendation() runs in one transaction under an advisory
-- lock, demotes the previous live row to history (is_published = false), and
-- carries numbers_changed_at / previous_* forward when the numbers are equal.

alter table public.recommendations
    add column if not exists numbers_changed_at timestamptz,
    add column if not exists previous_numbers integer[],
    add column if not exists previous_bonus_numbers integer[];

update public.recommendations
set numbers_changed_at = generated_at
where numbers_changed_at is null;

alter table public.recommendations
    alter column numbers_changed_at set default now(),
    alter column numbers_changed_at set not null;

-- Keep only the newest live row per algorithm + type before adding the guard.
with ranked as (
    select id,
           row_number() over (
               partition by algorithm_id, lottery_type
               order by generated_at desc, id desc
           ) as rn
    from public.recommendations
    where is_published
)
update public.recommendations r
set is_published = false
from ranked
where r.id = ranked.id and ranked.rn > 1;

create unique index if not exists recommendations_one_live_per_algorithm
    on public.recommendations (algorithm_id, lottery_type)
    where is_published;

create index if not exists recommendations_algorithm_generated_idx
    on public.recommendations (algorithm_id, lottery_type, generated_at desc);

create or replace function public.publish_recommendation(
    p_algorithm_id uuid,
    p_lottery_type public.lottery_type,
    p_numbers integer[],
    p_bonus_numbers integer[]
)
returns table (
    id uuid,
    changed boolean,
    generated_at timestamptz,
    numbers_changed_at timestamptz,
    previous_numbers integer[],
    previous_bonus_numbers integer[]
)
language plpgsql
security invoker
set search_path = public
as $$
#variable_conflict use_column
declare
    prev public.recommendations%rowtype;
    v_changed boolean;
    v_prev_numbers integer[];
    v_prev_bonus integer[];
    v_changed_at timestamptz;
begin
    perform pg_advisory_xact_lock(hashtext(p_algorithm_id::text || ':' || p_lottery_type::text));

    select * into prev
    from public.recommendations r
    where r.algorithm_id = p_algorithm_id
      and r.lottery_type = p_lottery_type
      and r.is_published
    for update;

    if not found then
        -- First publish (or re-publish after an unpublish): compare with the
        -- latest history row so "changed" stays meaningful.
        select * into prev
        from public.recommendations r
        where r.algorithm_id = p_algorithm_id
          and r.lottery_type = p_lottery_type
        order by r.generated_at desc
        limit 1;
    end if;

    if prev.id is null then
        v_changed := true;
        v_prev_numbers := null;
        v_prev_bonus := null;
        v_changed_at := now();
    elsif prev.numbers is distinct from p_numbers
       or prev.bonus_numbers is distinct from coalesce(p_bonus_numbers, '{}') then
        v_changed := true;
        v_prev_numbers := prev.numbers;
        v_prev_bonus := prev.bonus_numbers;
        v_changed_at := now();
    else
        v_changed := false;
        v_prev_numbers := prev.previous_numbers;
        v_prev_bonus := prev.previous_bonus_numbers;
        v_changed_at := prev.numbers_changed_at;
    end if;

    update public.recommendations r
    set is_published = false
    where r.algorithm_id = p_algorithm_id
      and r.lottery_type = p_lottery_type
      and r.is_published;

    return query
    insert into public.recommendations as r (
        algorithm_id, lottery_type, numbers, bonus_numbers, is_published,
        numbers_changed_at, previous_numbers, previous_bonus_numbers
    )
    values (
        p_algorithm_id, p_lottery_type, p_numbers, coalesce(p_bonus_numbers, '{}'), true,
        v_changed_at, v_prev_numbers, v_prev_bonus
    )
    returning r.id, v_changed, r.generated_at, r.numbers_changed_at,
              r.previous_numbers, r.previous_bonus_numbers;

    -- Bounded history: keep the newest 100 rows per algorithm + type.
    delete from public.recommendations r
    where r.algorithm_id = p_algorithm_id
      and r.lottery_type = p_lottery_type
      and not r.is_published
      and r.id in (
          select h.id from public.recommendations h
          where h.algorithm_id = p_algorithm_id and h.lottery_type = p_lottery_type
          order by h.generated_at desc
          offset 100
      );
end;
$$;

revoke all on function public.publish_recommendation(uuid, public.lottery_type, integer[], integer[]) from public, anon;
grant execute on function public.publish_recommendation(uuid, public.lottery_type, integer[], integer[]) to authenticated;
