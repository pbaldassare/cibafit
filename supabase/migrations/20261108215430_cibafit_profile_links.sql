-- Collega note, coupon e commissioni ai profili cibafit: senza questi legami le API non
-- restituivano i nomi e le pagine Note e Coupon risultavano vuote.
-- I registri di commissioni e pagamenti sopravvivono alla cancellazione di un account, senza riferimento alla persona.
set local role postgres;
set local lock_timeout = '5s';
set local search_path = pg_catalog;

alter table cibafit.professional_notes drop constraint professional_notes_client_user_id_fkey;
alter table cibafit.professional_notes add constraint professional_notes_client_user_id_fkey
  foreign key (client_user_id) references cibafit.profiles(id) on delete cascade;

alter table cibafit.nutritionist_coupons add constraint nutritionist_coupons_nutritionist_user_id_fkey
  foreign key (nutritionist_user_id) references cibafit.profiles(id) on delete cascade;

alter table cibafit.user_nutritionist_links add constraint user_nutritionist_links_client_user_id_fkey
  foreign key (client_user_id) references cibafit.profiles(id) on delete cascade;
alter table cibafit.user_nutritionist_links add constraint user_nutritionist_links_nutritionist_user_id_fkey
  foreign key (nutritionist_user_id) references cibafit.profiles(id) on delete cascade;

alter table cibafit.nutritionist_commissions alter column nutritionist_user_id drop not null;
alter table cibafit.nutritionist_commissions alter column client_user_id drop not null;
alter table cibafit.nutritionist_commissions alter column coupon_id drop not null;
alter table cibafit.nutritionist_commissions add constraint nutritionist_commissions_nutritionist_user_id_fkey
  foreign key (nutritionist_user_id) references cibafit.profiles(id) on delete set null;
alter table cibafit.nutritionist_commissions add constraint nutritionist_commissions_client_user_id_fkey
  foreign key (client_user_id) references cibafit.profiles(id) on delete set null;

alter table cibafit.nutritionist_commissions drop constraint nutritionist_commissions_coupon_id_fkey;
alter table cibafit.nutritionist_commissions add constraint nutritionist_commissions_coupon_id_fkey
  foreign key (coupon_id) references cibafit.nutritionist_coupons(id) on delete set null;
alter table cibafit.subscription_payments drop constraint subscription_payments_coupon_id_fkey;
alter table cibafit.subscription_payments add constraint subscription_payments_coupon_id_fkey
  foreign key (coupon_id) references cibafit.nutritionist_coupons(id) on delete set null;
alter table cibafit.user_nutritionist_links drop constraint user_nutritionist_links_coupon_id_fkey;
alter table cibafit.user_nutritionist_links add constraint user_nutritionist_links_coupon_id_fkey
  foreign key (coupon_id) references cibafit.nutritionist_coupons(id) on delete set null;

create or replace function cibafit.delete_account_data(target uuid)
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
  delete from cibafit.nutritionist_coupons where nutritionist_user_id = target;

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

notify pgrst, 'reload schema';
