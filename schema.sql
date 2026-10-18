-- NaijaMarket starter schema. Review and test policies before production.
create table if not exists public.listings (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 3 and 140),
  description text not null default '',
  category text not null,
  price_ngn numeric(14,2) not null check (price_ngn >= 0),
  state text not null,
  image_paths text[] not null default '{}',
  status text not null default 'pending' check (status in ('pending','approved','rejected','removed')),
  seller_contact_private text,
  seller_contacted boolean not null default false,
  commission_agreed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.listing_reports (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid references public.listings(id) on delete set null,
  reporter_id uuid references auth.users(id) on delete set null,
  reason text not null,
  details text not null default '',
  status text not null default 'open' check (status in ('open','investigating','resolved','dismissed')),
  created_at timestamptz not null default now()
);
alter table public.listings enable row level security;
alter table public.listing_reports enable row level security;
-- Public can see only approved, non-private listing fields through a carefully designed view/API.
-- Do NOT grant public access to seller_contact_private. Create admin-only policies after
-- configuring an admin role/claim. These starter tables intentionally have no permissive write policies.


-- Branch and staff structure for future nationwide operations.
-- IMPORTANT: These tables intentionally have no permissive client policies.
-- Assign privileged roles only through a trusted server/admin process. Do not
-- trust user-editable auth metadata or a role supplied by a signup form.
create table if not exists public.branch_offices (
  id uuid primary key default gen_random_uuid(),
  branch_name text not null,
  state text not null,
  city_or_lga text,
  office_contact_email text,
  office_contact_phone text,
  status text not null default 'planned' check (status in ('planned','active','suspended','closed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (branch_name, state)
);

create table if not exists public.staff_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('overall_owner','national_admin','state_manager','branch_staff','support_moderator')),
  branch_id uuid references public.branch_offices(id) on delete restrict,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check ((role in ('state_manager','branch_staff') and branch_id is not null) or (role in ('overall_owner','national_admin','support_moderator')))
);

alter table public.branch_offices enable row level security;
alter table public.staff_profiles enable row level security;
-- No policies are intentionally added here: RLS therefore denies client access
-- until reviewed policies/functions are installed. Production must enforce that
-- overall_owner has national scope, state managers are scoped to one branch/state,
-- branch staff receive only task-specific access, and users cannot change their
-- own role or branch. Use server-side authorization and audit every privilege change.

-- Stage 6: customer/agent separation and server-ledger foundation.
-- Keep RLS enabled and add reviewed policies/functions before connecting any client.
-- Do not let users choose their own privileged role or write their own balance.
create table if not exists public.agent_applications (
  id uuid primary key default gen_random_uuid(),
  applicant_user_id uuid references auth.users(id) on delete set null,
  full_name text not null check (char_length(full_name) between 2 and 100),
  email text not null,
  phone text not null,
  requested_state text not null,
  requested_area text not null,
  experience_note text not null default '',
  status text not null default 'pending' check (status in ('pending','under_review','approved','rejected','withdrawn')),
  reviewed_by uuid references auth.users(id) on delete set null,
  review_note text,
  created_at timestamptz not null default now(),
  reviewed_at timestamptz
);

create table if not exists public.agent_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  agent_code text unique,
  branch_id uuid references public.branch_offices(id) on delete restrict,
  state text not null,
  service_area text,
  status text not null default 'pending' check (status in ('pending','active','suspended','rejected')),
  approved_by uuid references auth.users(id) on delete set null,
  approved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Append-only style ledger: balances should be calculated from verified ledger rows
-- by trusted server functions; never accept balance amounts from a browser form.
create table if not exists public.agent_wallet_ledger (
  id uuid primary key default gen_random_uuid(),
  agent_user_id uuid not null references auth.users(id) on delete restrict,
  entry_type text not null check (entry_type in ('commission_pending','commission_approved','payout','reversal','adjustment')),
  amount_ngn numeric(14,2) not null check (amount_ngn > 0),
  direction text not null check (direction in ('credit','debit')),
  reference text unique,
  description text not null default '',
  status text not null default 'pending' check (status in ('pending','verified','rejected','paid','reversed')),
  created_by uuid references auth.users(id) on delete set null,
  verified_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  verified_at timestamptz
);

alter table public.agent_applications enable row level security;
alter table public.agent_profiles enable row level security;
alter table public.agent_wallet_ledger enable row level security;
-- Intentionally no client policies are added. Without policies, client access is denied.
-- Production setup must add policies and trusted server functions for:
-- 1) customer self-service limited to their own non-privileged data;
-- 2) agent applications reviewed by the overall owner/authorised staff;
-- 3) agents scoped to assigned branch/state and active status;
-- 4) owner-only role/branch management with MFA and audited privilege changes;
-- 5) ledger inserts/verification/payouts only through trusted server functions;
-- 6) no direct client update/delete of ledger history and no client-editable balances.
