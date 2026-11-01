create table if not exists public.income_flow_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.income_flow_data enable row level security;
grant select, insert, update, delete on public.income_flow_data to authenticated;
drop policy if exists "income_select_own" on public.income_flow_data;
drop policy if exists "income_insert_own" on public.income_flow_data;
drop policy if exists "income_update_own" on public.income_flow_data;
drop policy if exists "income_delete_own" on public.income_flow_data;
create policy "income_select_own" on public.income_flow_data for select to authenticated using ((select auth.uid())=user_id);
create policy "income_insert_own" on public.income_flow_data for insert to authenticated with check ((select auth.uid())=user_id);
create policy "income_update_own" on public.income_flow_data for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy "income_delete_own" on public.income_flow_data for delete to authenticated using ((select auth.uid())=user_id);
