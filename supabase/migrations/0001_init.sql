create table if not exists ideas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  pitch text not null,
  core_action_label text not null,
  demand_score numeric default 0,
  sellability_flag text default 'unscored',
  scalability_flag text default 'unscored',
  ai_summary text,
  ai_summary_source text,
  ai_summary_confidence numeric,
  ai_summary_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table ideas enable row level security;
drop policy if exists "ideas_v1_read" on ideas;
create policy "ideas_v1_read" on ideas for select using (true);
drop policy if exists "ideas_v1_write" on ideas;
create policy "ideas_v1_write" on ideas for all using (true) with check (true);

create table if not exists signups (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  idea_id uuid,
  name text not null,
  email text not null,
  intent text,
  referral_source text,
  created_at timestamptz not null default now()
);

alter table signups enable row level security;
drop policy if exists "signups_v1_read" on signups;
create policy "signups_v1_read" on signups for select using (true);
drop policy if exists "signups_v1_write" on signups;
create policy "signups_v1_write" on signups for all using (true) with check (true);

create table if not exists core_actions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  idea_id uuid,
  signup_id uuid,
  action_label text not null,
  action_data jsonb,
  completed_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table core_actions enable row level security;
drop policy if exists "core_actions_v1_read" on core_actions;
create policy "core_actions_v1_read" on core_actions for select using (true);
drop policy if exists "core_actions_v1_write" on core_actions;
create policy "core_actions_v1_write" on core_actions for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  idea_id uuid,
  event_type text not null,
  entity_type text,
  entity_id uuid,
  metadata jsonb,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  action text not null,
  entity_type text,
  entity_id uuid,
  payload jsonb,
  created_at timestamptz not null default now()
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into ideas (id, title, pitch, core_action_label, demand_score, sellability_flag) values
  ('a1b2c3d4-0001-0001-0001-000000000001', 'QuickDesk', 'Instant customer support chat for solo founders — no setup, no monthly fee.', 'Start my free trial', 14, 'Signal detected'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'FounderFit', 'Daily 10-min workouts built for people who sit at a desk all day.', 'Get my first workout', 7, 'Early signal'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'ShipLog', 'A simple shipping tracker that texts your customers automatically.', 'Track my first order', 3, 'unscored');

insert into signups (id, idea_id, name, email, intent, referral_source) values
  (gen_random_uuid(), 'a1b2c3d4-0001-0001-0001-000000000001', 'Maya Patel', 'maya@example.com', 'I need this for my Shopify store', 'Twitter'),
  (gen_random_uuid(), 'a1b2c3d4-0001-0001-0001-000000000001', 'Luca Romano', 'luca@example.com', 'Tired of Intercom pricing', 'Friend referral'),
  (gen_random_uuid(), 'a1b2c3d4-0001-0001-0001-000000000001', 'Aisha Okonkwo', 'aisha@example.com', 'Just curious', 'Google'),
  (gen_random_uuid(), 'a1b2c3d4-0002-0002-0002-000000000002', 'Tom Briggs', 'tom@example.com', 'Need to stay healthy while building', 'ProductHunt'),
  (gen_random_uuid(), 'a1b2c3d4-0003-0003-0003-000000000003', 'Sara Kim', 'sara@example.com', 'We ship 50 orders a week', 'LinkedIn');

insert into core_actions (id, idea_id, action_label, action_data) values
  (gen_random_uuid(), 'a1b2c3d4-0001-0001-0001-000000000001', 'Start my free trial', '{"plan":"starter","source":"landing"}'),
  (gen_random_uuid(), 'a1b2c3d4-0001-0001-0001-000000000001', 'Start my free trial', '{"plan":"starter","source":"landing"}'),
  (gen_random_uuid(), 'a1b2c3d4-0002-0002-0002-000000000002', 'Get my first workout', '{"goal":"energy","level":"beginner"}');