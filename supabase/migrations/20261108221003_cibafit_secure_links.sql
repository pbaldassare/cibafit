-- Collegamenti nutrizionista-cliente: un collegamento attivo deve partire dal cliente.
-- Prima un nutrizionista poteva collegarsi da solo a qualunque utente e leggerne i dati.
-- Il nutrizionista collegato puo' aggiornare gli obiettivi del cliente; i codici invito si consumano.
set local role postgres;
set local lock_timeout = '5s';
set local search_path = pg_catalog;

create function cibafit.guard_client_link()
returns trigger language plpgsql security definer set search_path to 'cibafit' as $function$
declare
  _uid uuid := auth.uid();
begin
  -- Funzioni di servizio e admin non passano da qui.
  if _uid is null or cibafit.current_user_is_admin() then
    return NEW;
  end if;

  if TG_OP = 'UPDATE' and (NEW.client_user_id <> OLD.client_user_id or NEW.professional_id <> OLD.professional_id) then
    raise exception 'Il collegamento non puo'' cambiare persone' using errcode = '42501';
  end if;

  if NEW.status = 'active'
     and (TG_OP = 'INSERT' or OLD.status is distinct from 'active')
     and _uid <> NEW.client_user_id
     and not exists (
       select 1 from cibafit.professional_link_requests r
       where r.user_id = NEW.client_user_id
         and r.professional_id = NEW.professional_id
         and r.status = 'pending') then
    raise exception 'Il collegamento deve essere richiesto dal cliente' using errcode = '42501';
  end if;

  return NEW;
end;
$function$;

create trigger guard_client_link before insert or update on cibafit.client_links
  for each row execute function cibafit.guard_client_link();

create policy "Linked pro inserts client targets" on cibafit.nutrition_targets
  for insert to authenticated with check (exists (
    select 1 from cibafit.client_links cl
    where cl.professional_id = auth.uid() and cl.client_user_id = nutrition_targets.user_id and cl.status = 'active'));
create policy "Linked pro updates client targets" on cibafit.nutrition_targets
  for update to authenticated using (exists (
    select 1 from cibafit.client_links cl
    where cl.professional_id = auth.uid() and cl.client_user_id = nutrition_targets.user_id and cl.status = 'active'))
  with check (exists (
    select 1 from cibafit.client_links cl
    where cl.professional_id = auth.uid() and cl.client_user_id = nutrition_targets.user_id and cl.status = 'active'));

-- Niente macro inventati per chi non li ha scelti.
alter table cibafit.nutrition_targets alter column protein_g drop default;
alter table cibafit.nutrition_targets alter column carbs_g drop default;
alter table cibafit.nutrition_targets alter column fats_g drop default;

-- Il cliente consuma il codice solo dopo essersi collegato a quel nutrizionista.
create function cibafit.redeem_invite(code text)
returns void language plpgsql security definer set search_path to 'cibafit' as $function$
begin
  update cibafit.professional_invites i
  set status = 'used'
  where i.invite_code = code
    and i.status = 'active'
    and exists (
      select 1 from cibafit.client_links cl
      where cl.client_user_id = auth.uid()
        and cl.professional_id = i.professional_id
        and cl.status = 'active');
end;
$function$;
revoke all on function cibafit.redeem_invite(text) from public, anon;
grant execute on function cibafit.redeem_invite(text) to authenticated, service_role;

notify pgrst, 'reload schema';
