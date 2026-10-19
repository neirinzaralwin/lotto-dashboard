-- Fix for 20261019000000: PL/pgSQL cannot `RETURN QUERY INSERT ... RETURNING`
-- ("cannot open INSERT query as cursor"). Insert into variables, then return.
-- Same signature, so `create or replace` is enough for databases that already
-- ran the first migration.
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
    v_id uuid;
    v_generated timestamptz;
begin
    perform pg_advisory_xact_lock(hashtext(p_algorithm_id::text || ':' || p_lottery_type::text));

    select * into prev
    from public.recommendations r
    where r.algorithm_id = p_algorithm_id
      and r.lottery_type = p_lottery_type
      and r.is_published
    for update;

    if not found then
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

    insert into public.recommendations (
        algorithm_id, lottery_type, numbers, bonus_numbers, is_published,
        numbers_changed_at, previous_numbers, previous_bonus_numbers
    )
    values (
        p_algorithm_id, p_lottery_type, p_numbers, coalesce(p_bonus_numbers, '{}'), true,
        v_changed_at, v_prev_numbers, v_prev_bonus
    )
    returning recommendations.id, recommendations.generated_at
    into v_id, v_generated;

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

    return query
    select v_id, v_changed, v_generated, v_changed_at, v_prev_numbers, v_prev_bonus;
end;
$$;

revoke all on function public.publish_recommendation(uuid, public.lottery_type, integer[], integer[]) from public, anon;
grant execute on function public.publish_recommendation(uuid, public.lottery_type, integer[], integer[]) to authenticated;
