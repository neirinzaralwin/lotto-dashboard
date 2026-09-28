-- Mobile reads published recommendations anon-side with an embedded
-- `algorithms(name)` lookup for the ticket meta line. Without a public
-- SELECT policy the join resolves to null, so expose algorithm rows
-- read-only to anon + authenticated (writes stay authenticated-only).
create policy "Public read algorithms"
    on public.algorithms
    for select
    to anon, authenticated
    using (true);
