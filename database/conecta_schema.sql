-- CONECTA Surpresa: aplicar somente em projeto Supabase exclusivo
create extension if not exists pgcrypto;
create table if not exists public.conecta_admins (
 user_id uuid primary key references auth.users(id) on delete cascade
);
create table if not exists public.conecta_orders (
 id uuid primary key default gen_random_uuid(),
 tier text not null check (tier in ('mini','magic','premium')),
 status text not null default 'draft' check (status in ('draft','ready','delivered','cancelled')),
 created_at timestamptz not null default now()
);
create table if not exists public.conecta_experiences (
 id uuid primary key default gen_random_uuid(),
 order_id uuid unique not null references public.conecta_orders(id) on delete cascade,
 recipient_name text not null check (char_length(recipient_name)<=70),
 sender_name text not null check (char_length(sender_name)<=70),
 occasion text not null,
 message text not null check (char_length(message)<=900),
 question text,
 choice_a text,
 choice_b text,
 memory text,
 created_at timestamptz not null default now()
);
create table if not exists public.conecta_share_links (
 id uuid primary key default gen_random_uuid(),
 experience_id uuid not null references public.conecta_experiences(id) on delete cascade,
 token_hash text not null unique,
 expires_at timestamptz not null,
 revoked_at timestamptz,
 created_at timestamptz not null default now()
);
create table if not exists public.conecta_audit_events (
 id uuid primary key default gen_random_uuid(),
 actor_id uuid references auth.users(id),
 action text not null,
 object_id uuid,
 created_at timestamptz not null default now()
);
alter table public.conecta_admins enable row level security;
alter table public.conecta_orders enable row level security;
alter table public.conecta_experiences enable row level security;
alter table public.conecta_share_links enable row level security;
alter table public.conecta_audit_events enable row level security;
-- No anon or authenticated policies: deny all client-side table access.
-- A backend using a secret server-side service key must enforce admin
-- authorization and validate share tokens before returning experience data.
revoke all on public.conecta_admins, public.conecta_orders, public.conecta_experiences, public.conecta_share_links, public.conecta_audit_events from anon, authenticated;
