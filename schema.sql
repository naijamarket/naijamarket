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
