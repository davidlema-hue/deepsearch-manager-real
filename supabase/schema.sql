-- Deep Search Manager schema
create extension if not exists "uuid-ossp";

create table if not exists roles (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,
  permissions jsonb not null default '{}'::jsonb,
  created_at timestamptz default now()
);

create table if not exists clients (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  contact_name text,
  contact_email text,
  access_email text unique,
  access_active boolean default true,
  status text default 'Activo',
  created_at timestamptz default now()
);

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  email text not null unique,
  role_id uuid references roles(id),
  user_type text not null check (user_type in ('interno','cliente')),
  area text,
  is_active boolean default true,
  client_id uuid references clients(id),
  created_at timestamptz default now()
);

create table if not exists profile_clients (
  profile_id uuid references profiles(id) on delete cascade,
  client_id uuid references clients(id) on delete cascade,
  primary key (profile_id, client_id)
);

create table if not exists tasks (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  description text,
  client_id uuid references clients(id),
  area text,
  assignee_id uuid references profiles(id),
  priority text default 'Media',
  status text default 'Pendiente',
  due_date date,
  source text default 'Manual',
  created_by uuid references profiles(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists cronoposts (
  id uuid primary key default uuid_generate_v4(),
  client_id uuid references clients(id) on delete cascade,
  date date not null,
  title text not null,
  format text,
  platforms text[] default '{}',
  copy text,
  art_link text,
  published_link text,
  responsible_id uuid references profiles(id),
  status text default 'Borrador',
  sent_to_client boolean default false,
  sent_at timestamptz,
  sent_by uuid references profiles(id),
  approved_at timestamptz,
  approved_by uuid references profiles(id),
  created_by uuid references profiles(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists post_comments (
  id uuid primary key default uuid_generate_v4(),
  cronopost_id uuid references cronoposts(id) on delete cascade,
  author_id uuid references profiles(id),
  comment text not null,
  created_at timestamptz default now(),
  converted_to_task_id uuid references tasks(id)
);

insert into roles (name, permissions) values
('Super Admin', '{"all":true}'::jsonb),
('Administrador', '{"dashboard":{"view":true},"clientes":{"view":true,"create":true,"edit":true},"usuarios":{"view":true,"create":true,"edit":true},"tareas":{"view":true,"create":true,"edit":true,"delete":true},"cronopost":{"view":true,"create":true,"edit":true,"delete":true,"sendApproval":true}}'::jsonb),
('Equipo Interno', '{"dashboard":{"view":true},"tareas":{"view":true,"create":true,"edit":true},"cronopost":{"view":true,"create":true,"edit":true,"sendApproval":true},"traficoDiseno":{"view":true}}'::jsonb),
('Cliente', '{"portalCliente":{"view":true,"approve":true,"comment":true}}'::jsonb)
on conflict (name) do nothing;

alter table roles enable row level security;
alter table clients enable row level security;
alter table profiles enable row level security;
alter table profile_clients enable row level security;
alter table tasks enable row level security;
alter table cronoposts enable row level security;
alter table post_comments enable row level security;

-- MVP policies: logged users can read/write. Tighten before production final.
create policy "authenticated read roles" on roles for select to authenticated using (true);
create policy "authenticated manage roles" on roles for all to authenticated using (true) with check (true);
create policy "authenticated manage clients" on clients for all to authenticated using (true) with check (true);
create policy "authenticated manage profiles" on profiles for all to authenticated using (true) with check (true);
create policy "authenticated manage profile_clients" on profile_clients for all to authenticated using (true) with check (true);
create policy "authenticated manage tasks" on tasks for all to authenticated using (true) with check (true);
create policy "authenticated manage cronoposts" on cronoposts for all to authenticated using (true) with check (true);
create policy "authenticated manage comments" on post_comments for all to authenticated using (true) with check (true);
