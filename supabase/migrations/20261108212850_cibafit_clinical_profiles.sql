-- Scheda clinica del cliente. Dati sulla salute: li crea solo il cliente dando il consenso,
-- il nutrizionista collegato li vede e li aggiorna solo finche' il consenso resta attivo.
-- Gli admin non hanno accesso.
set local role postgres;
set local lock_timeout = '5s';
set local search_path = pg_catalog;

create table cibafit.client_clinical_profiles (
  client_user_id uuid primary key references auth.users(id) on delete cascade,
  health_data_consent_at timestamptz,
  birth_date date check (birth_date is null or (birth_date > '1900-01-01' and birth_date <= current_date)),
  sex text check (sex is null or sex in ('female', 'male')),
  height_cm numeric check (height_cm is null or height_cm between 50 and 260),
  activity_level text check (activity_level is null or activity_level in ('sedentary', 'light', 'moderate', 'active', 'very_active')),
  goal text,
  allergies text[] not null default '{}',
  intolerances text[] not null default '{}',
  conditions text,
  medications text,
  dietary_preferences text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id) on delete set null
);

alter table cibafit.client_clinical_profiles enable row level security;

create function cibafit.guard_clinical_profile()
returns trigger language plpgsql set search_path to 'cibafit' as $function$
begin
  NEW.updated_at := now();
  NEW.updated_by := auth.uid();
  -- Solo il cliente puo' dare o revocare il consenso.
  if auth.uid() is distinct from OLD.client_user_id
     and NEW.health_data_consent_at is distinct from OLD.health_data_consent_at then
    raise exception 'Solo il cliente puo'' modificare il consenso' using errcode = '42501';
  end if;
  if NEW.client_user_id <> OLD.client_user_id then
    raise exception 'Il cliente della scheda non puo'' cambiare' using errcode = '42501';
  end if;
  return NEW;
end;
$function$;

create trigger guard_clinical_profile before update on cibafit.client_clinical_profiles
  for each row execute function cibafit.guard_clinical_profile();

create policy "Client reads own clinical profile" on cibafit.client_clinical_profiles
  for select to authenticated using (client_user_id = auth.uid());
create policy "Client creates own clinical profile with consent" on cibafit.client_clinical_profiles
  for insert to authenticated with check (client_user_id = auth.uid() and health_data_consent_at is not null);
create policy "Client updates own clinical profile" on cibafit.client_clinical_profiles
  for update to authenticated using (client_user_id = auth.uid()) with check (client_user_id = auth.uid());
create policy "Client deletes own clinical profile" on cibafit.client_clinical_profiles
  for delete to authenticated using (client_user_id = auth.uid());
create policy "Linked pro reads clinical profile with consent" on cibafit.client_clinical_profiles
  for select to authenticated using (
    health_data_consent_at is not null and exists (
      select 1 from cibafit.client_links cl
      where cl.client_user_id = client_clinical_profiles.client_user_id
        and cl.professional_id = auth.uid() and cl.status = 'active'));
create policy "Linked pro updates clinical profile with consent" on cibafit.client_clinical_profiles
  for update to authenticated using (
    health_data_consent_at is not null and exists (
      select 1 from cibafit.client_links cl
      where cl.client_user_id = client_clinical_profiles.client_user_id
        and cl.professional_id = auth.uid() and cl.status = 'active'))
  with check (
    health_data_consent_at is not null and exists (
      select 1 from cibafit.client_links cl
      where cl.client_user_id = client_clinical_profiles.client_user_id
        and cl.professional_id = auth.uid() and cl.status = 'active'));

revoke all on cibafit.client_clinical_profiles from anon, public;
grant select, insert, update, delete on cibafit.client_clinical_profiles to authenticated;
grant all on cibafit.client_clinical_profiles to service_role;
