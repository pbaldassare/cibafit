-- Cancellazione account CibaFit. Tocca solo lo schema cibafit: l'eventuale account su Cibarius resta.
-- I piani gia' preparati per i clienti restano ai clienti anche se il nutrizionista si cancella.
-- I registri di pagamento e provvigione restano per obblighi fiscali: contengono solo l'id utente.
set local role postgres;
set local lock_timeout = '5s';
set local search_path = pg_catalog;

alter table cibafit.diet_plans alter column professional_id drop not null;
alter table cibafit.generated_recipes alter column professional_id drop not null;

create function cibafit.delete_account_data(target uuid)
returns table (bucket_id text, name text)
language plpgsql
security definer
set search_path to 'cibafit'
as $function$
declare
  fk record;
  _buckets text[];
  _names text[];
begin
  if target is null then
    raise exception 'target obbligatorio';
  end if;

  -- File da rimuovere tramite le API Storage dopo la cancellazione dei dati.
  select coalesce(array_agg(o.bucket_id), '{}'), coalesce(array_agg(o.name), '{}')
    into _buckets, _names
    from storage.objects o
    where o.owner_id = target::text and o.bucket_id like 'cibafit-%';

  -- Dati del cliente.
  delete from cibafit.diet_plans where client_user_id = target;
  delete from cibafit.generated_recipes where client_user_id = target;
  delete from cibafit.pro_suggestions where client_user_id = target or professional_id = target;
  delete from cibafit.body_measurements where user_id = target;
  delete from cibafit.messages where sender_id = target or receiver_id = target;
  delete from cibafit.user_favorites where user_id = target;
  delete from cibafit.meal_logs where user_id = target;
  delete from cibafit.daily_progress where user_id = target;
  delete from cibafit.appointments where client_user_id = target or professional_id = target;
  delete from cibafit.manual_subscription_overrides where user_id = target;
  delete from cibafit.product_submissions where user_id = target;
  delete from cibafit.user_nutritionist_links where client_user_id = target or nutritionist_user_id = target;

  -- Dati del nutrizionista: i piani dei clienti restano, senza piu' il suo riferimento.
  update cibafit.diet_plans set professional_id = null where professional_id = target;
  update cibafit.generated_recipes set professional_id = null where professional_id = target;
  delete from cibafit.diet_plan_templates where professional_id = target;
  delete from cibafit.professional_profiles where user_id = target;
  delete from cibafit.nutritionist_coupons where nutritionist_user_id = target
    and not exists (select 1 from cibafit.nutritionist_commissions c where c.nutritionist_user_id = target);

  -- Tutte le tabelle collegate all'utente con una chiave esterna.
  for fk in
    select c.conrelid::regclass as tbl, a.attname as col, c.confdeltype as action
    from pg_constraint c
    join pg_attribute a on a.attrelid = c.conrelid and a.attnum = c.conkey[1]
    where c.connamespace = 'cibafit'::regnamespace
      and c.contype = 'f'
      and c.confrelid in ('auth.users'::regclass, 'cibafit.profiles'::regclass)
      and c.conrelid <> 'cibafit.profiles'::regclass
  loop
    if fk.action = 'n' then
      execute format('update %s set %I = null where %I = $1', fk.tbl, fk.col, fk.col) using target;
    else
      execute format('delete from %s where %I = $1', fk.tbl, fk.col) using target;
    end if;
  end loop;

  delete from cibafit.profiles where id = target;

  return query select f.b, f.n from unnest(_buckets, _names) as f(b, n);
end;
$function$;

revoke all on function cibafit.delete_account_data(uuid) from public, anon, authenticated;
grant execute on function cibafit.delete_account_data(uuid) to service_role;

notify pgrst, 'reload schema';
