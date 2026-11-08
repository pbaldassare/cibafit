-- CibaFit e' l'app per nutrizionisti e utenti: rimuove ristorazione, HACCP e fornitori dallo schema cibafit.
-- Tocca solo cibafit e i bucket cibafit-*. Nessun CASCADE: una dipendenza inattesa ferma la migrazione.
set local role postgres;
set local lock_timeout = '5s';
set local statement_timeout = '120s';
set local search_path = pg_catalog;

-- 0. File: niente bucket HACCP e niente cartella "restaurants" in cibafit-media.
drop policy "cibafit: Admin manages HACCP photos" on storage.objects;
drop policy "cibafit: Restaurant reads HACCP photos" on storage.objects;
drop policy "cibafit: Restaurant uploads HACCP photos" on storage.objects;
drop policy "cibafit: haccp docs auth delete" on storage.objects;
drop policy "cibafit: haccp docs auth update" on storage.objects;
drop policy "cibafit: haccp docs auth upload" on storage.objects;
drop policy "cibafit: haccp docs public read" on storage.objects;
drop policy "cibafit: Authenticated users can upload to own folder" on storage.objects;
drop policy "cibafit: Users can update own media" on storage.objects;
drop policy "cibafit: Users can delete own media" on storage.objects;
create policy "cibafit: Authenticated users can upload to own folder" on storage.objects for insert with check (bucket_id = 'cibafit-media' and auth.uid() is not null and (storage.foldername(name))[1] = 'users' and (storage.foldername(name))[2] = auth.uid()::text);
create policy "cibafit: Users can update own media" on storage.objects for update using (bucket_id = 'cibafit-media' and auth.uid() is not null and (storage.foldername(name))[1] = 'users' and (storage.foldername(name))[2] = auth.uid()::text);
create policy "cibafit: Users can delete own media" on storage.objects for delete using (bucket_id = 'cibafit-media' and auth.uid() is not null and (storage.foldername(name))[1] = 'users' and (storage.foldername(name))[2] = auth.uid()::text);
select set_config('storage.allow_delete_query', 'true', true);
delete from storage.buckets where id in ('cibafit-haccp-documents', 'cibafit-haccp-photos');

-- 1. Regole di accesso delle tabelle che restano: solo proprietario, nutrizionista collegato o admin.
drop policy "Inventory select own or restaurant member or admin" on cibafit.inventory_items;
drop policy "Inventory insert own or restaurant owner or admin" on cibafit.inventory_items;
drop policy "Inventory update own or restaurant owner or admin" on cibafit.inventory_items;
drop policy "Inventory delete own or restaurant owner or admin" on cibafit.inventory_items;
create policy "Inventory select own or admin" on cibafit.inventory_items for select using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Inventory insert own or admin" on cibafit.inventory_items for insert with check (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Inventory update own or admin" on cibafit.inventory_items for update using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Inventory delete own or admin" on cibafit.inventory_items for delete using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());

drop policy "Attachments select own or restaurant or admin" on cibafit.attachments;
drop policy "Attachments insert own or restaurant owner or admin" on cibafit.attachments;
drop policy "Attachments update own or restaurant owner or admin" on cibafit.attachments;
drop policy "Attachments delete own or restaurant owner or admin" on cibafit.attachments;
create policy "Attachments select own or admin" on cibafit.attachments for select using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Attachments insert own or admin" on cibafit.attachments for insert with check (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Attachments update own or admin" on cibafit.attachments for update using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());
create policy "Attachments delete own or admin" on cibafit.attachments for delete using (owner_user_id = auth.uid() or cibafit.current_user_is_admin());

drop policy "Restaurant members can view item photos" on cibafit.inventory_item_photos;
drop policy "Restaurant members can insert item photos" on cibafit.inventory_item_photos;
drop policy "Restaurant members can delete item photos" on cibafit.inventory_item_photos;
create policy "Owner views item photos" on cibafit.inventory_item_photos for select to authenticated using (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_photos.item_id and ii.owner_user_id = auth.uid()));
create policy "Owner inserts item photos" on cibafit.inventory_item_photos for insert to authenticated with check (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_photos.item_id and ii.owner_user_id = auth.uid()));
create policy "Owner deletes item photos" on cibafit.inventory_item_photos for delete to authenticated using (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_photos.item_id and ii.owner_user_id = auth.uid()));

drop policy "Restaurant members can view inventory allergens" on cibafit.inventory_item_allergens;
drop policy "Restaurant members can insert inventory allergens" on cibafit.inventory_item_allergens;
drop policy "Restaurant members can delete inventory allergens" on cibafit.inventory_item_allergens;
create policy "Owner views inventory allergens" on cibafit.inventory_item_allergens for select to authenticated using (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_allergens.inventory_item_id and ii.owner_user_id = auth.uid()));
create policy "Owner inserts inventory allergens" on cibafit.inventory_item_allergens for insert to authenticated with check (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_allergens.inventory_item_id and ii.owner_user_id = auth.uid()));
create policy "Owner deletes inventory allergens" on cibafit.inventory_item_allergens for delete to authenticated using (exists (select 1 from cibafit.inventory_items ii where ii.id = inventory_item_allergens.inventory_item_id and ii.owner_user_id = auth.uid()));

drop policy "Restaurant owner reads member profiles" on cibafit.profiles;
drop policy "User starts own restaurant trial" on cibafit.subscriptions;

-- 2. Colonne e trigger legati ai ristoranti.
drop trigger validate_inventory_owner_trigger on cibafit.inventory_items;
alter table cibafit.inventory_items drop column restaurant_id, drop column source_document_id;
alter table cibafit.inventory_items alter column owner_user_id set not null;
alter table cibafit.attachments drop column restaurant_id;

-- 3. Tabelle.
drop table
  cibafit.restaurants, cibafit.restaurant_members, cibafit.restaurant_documents, cibafit.restaurant_api_keys, cibafit.restaurant_invites,
  cibafit.suppliers, cibafit.supplier_invites, cibafit.supplier_restaurants, cibafit.supplier_products, cibafit.supplier_orders, cibafit.supplier_order_items,
  cibafit.haccp_tasks, cibafit.haccp_logs, cibafit.haccp_equipment, cibafit.haccp_audit_log, cibafit.haccp_templates, cibafit.haccp_template_tasks,
  cibafit.haccp_task_photos, cibafit.haccp_temperature_logs, cibafit.haccp_preparation_labels, cibafit.haccp_preparation_ingredients,
  cibafit.haccp_documents, cibafit.haccp_preparation_documents, cibafit.haccp_label_audit_log,
  cibafit.preparations, cibafit.preparation_ingredients, cibafit.preparation_allergens,
  cibafit.integration_runs, cibafit.integration_idempotency,
  cibafit.recipes, cibafit.recipe_ingredients, cibafit.recipe_allergens, cibafit.inventory_movements;

-- 4. Funzioni rimaste senza scopo.
do $$
declare r record;
begin
  for r in
    select p.oid::regprocedure as sig from pg_proc p
    where p.pronamespace = 'cibafit'::regnamespace and p.proname = any (array[
      'accept_restaurant_invite','accept_supplier_invite','auto_create_haccp_label_for_preparation','complete_oauth_signup',
      'create_supplier_order','gen_haccp_lot_code','haccp_label_accessible','haccp_log_registration_rules','haccp_temperature_max',
      'is_restaurant_accessible','is_restaurant_owner','mark_supplier_order_stock_loaded','merge_restaurant_products',
      'notify_haccp_temperature_alert','owns_recipe_restaurant','owns_supplier','protect_finalized_haccp_label','purge_unused_product',
      'restaurant_invite_preview','supplier_invite_preview','update_supplier_order_status','validate_doc_type','validate_member_role',
      'validate_haccp_audit_action','validate_haccp_document_type','validate_haccp_equipment_type','validate_haccp_frequency',
      'validate_haccp_label_status','validate_haccp_log_status','validate_inventory_owner','validate_preparation_owner',
      'validate_preparation_storage','validate_supplier_invite_status','validate_supplier_restaurant_status'])
  loop
    execute 'drop function ' || r.sig;
  end loop;
end $$;

-- 5. Ruoli: restano utente, nutrizionista e admin.
create or replace function cibafit.validate_profile_role()
returns trigger language plpgsql set search_path to 'cibafit' as $function$
begin
  if NEW.role not in ('user', 'professional', 'admin') then
    raise exception 'Invalid role: %', NEW.role;
  end if;
  return NEW;
end;
$function$;

create or replace function cibafit.ensure_profile()
returns void language plpgsql security definer set search_path to 'cibafit' as $function$
declare
  _uid uuid := auth.uid();
  _email text;
  _raw jsonb;
  _meta jsonb;
  _role text;
  _phone text;
  _ref_code text;
  _full_name text;
  _inserted uuid;
  _coupon record;
  _base_slug text;
  _slug text;
  _counter int := 0;
begin
  if _uid is null then
    raise exception 'ensure_profile richiede una sessione attiva' using errcode = '28000';
  end if;
  if exists (select 1 from cibafit.profiles where id = _uid) then
    return;
  end if;

  select email, coalesce(raw_user_meta_data, '{}'::jsonb) into _email, _raw from auth.users where id = _uid;
  if not found then
    return;
  end if;
  _meta := coalesce(_raw -> 'cibafit', '{}'::jsonb);

  _role := coalesce(_meta ->> 'role', 'user');
  if _role not in ('user', 'professional') then
    _role := 'user';
  end if;
  _phone := nullif(_meta ->> 'phone', '');
  _ref_code := nullif(_meta ->> 'ref_coupon_code', '');
  _full_name := coalesce(_meta ->> 'full_name', _raw ->> 'full_name', '');

  insert into cibafit.profiles (id, email, full_name, phone, role, ref_coupon_code)
  values (_uid, _email, _full_name, _phone, _role, _ref_code)
  on conflict (id) do nothing
  returning id into _inserted;
  if _inserted is null then
    return;
  end if;

  if _role = 'professional' then
    _base_slug := trim(both '-' from lower(regexp_replace(
      coalesce(_meta ->> 'display_name', _full_name, 'pro'), '[^a-zA-Z0-9]+', '-', 'g')));
    if _base_slug = '' then _base_slug := 'pro'; end if;
    _slug := _base_slug;
    loop
      exit when not exists (select 1 from cibafit.professional_profiles where public_slug = _slug);
      _counter := _counter + 1;
      _slug := _base_slug || '-' || _counter;
    end loop;
    insert into cibafit.professional_profiles (user_id, display_name, specialization, city, bio, public_slug)
    values (_uid, coalesce(_meta ->> 'display_name', _full_name, ''), coalesce(_meta ->> 'specialization', ''),
            _meta ->> 'city', _meta ->> 'bio', _slug);
  end if;

  if _ref_code is not null then
    select * into _coupon from cibafit.nutritionist_coupons
    where coupon_code = _ref_code and is_active = true limit 1;
    if found and _coupon.nutritionist_user_id <> _uid then
      insert into cibafit.user_nutritionist_links (client_user_id, nutritionist_user_id, coupon_id, link_source, is_active)
      values (_uid, _coupon.nutritionist_user_id, _coupon.id, 'referral_link', true)
      on conflict (client_user_id, nutritionist_user_id) do nothing;
    end if;
  end if;
end;
$function$;

-- 6. Abbonamenti: restano i piani utente.
delete from cibafit.subscription_plans where role_type = 'restaurant';
do $$
declare c text;
begin
  select conname into c from pg_constraint
  where conrelid = 'cibafit.subscriptions'::regclass and contype = 'c' and pg_get_constraintdef(oid) like '%plan_type%restaurant%';
  execute format('alter table cibafit.subscriptions drop constraint %I', c);
end $$;
alter table cibafit.subscriptions add constraint subscriptions_plan_type_check check (plan_type = 'user_plus');
