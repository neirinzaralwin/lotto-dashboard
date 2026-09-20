-- Phase 1: keep draws unique + published RLS; add updated_at trigger for upserts.

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists draws_set_updated_at on public.draws;

create trigger draws_set_updated_at
before update on public.draws
for each row
execute function public.set_updated_at();
