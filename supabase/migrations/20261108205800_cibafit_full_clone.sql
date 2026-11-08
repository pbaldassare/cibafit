-- CibaFit: copia strutturale completa di public nello schema cibafit (generata dal catalogo).
-- Nessun dato utente: si copiano solo i cataloghi di riferimento. Cibarius (public) non viene modificato.
-- Escluse: get_resend_api_key, handle_new_user e un seed una tantum. Chiamate HTTP verso le funzioni di Cibarius disattivate.
set local role postgres;
set local lock_timeout = '5s';
set local statement_timeout = '120s';
set local check_function_bodies = off;
set local search_path = pg_catalog;

-- 1. Tabelle
create table if not exists cibafit."admin_audit_log" (like public."admin_audit_log" including all);
alter table cibafit."admin_audit_log" enable row level security;
create table if not exists cibafit."ai_cache" (like public."ai_cache" including all);
alter table cibafit."ai_cache" enable row level security;
create table if not exists cibafit."ai_usage_log" (like public."ai_usage_log" including all);
alter table cibafit."ai_usage_log" enable row level security;
create table if not exists cibafit."allergens" (like public."allergens" including all);
alter table cibafit."allergens" enable row level security;
create table if not exists cibafit."api_keys" (like public."api_keys" including all);
alter table cibafit."api_keys" enable row level security;
create table if not exists cibafit."appointments" (like public."appointments" including all);
alter table cibafit."appointments" enable row level security;
create table if not exists cibafit."attachments" (like public."attachments" including all);
alter table cibafit."attachments" enable row level security;
create table if not exists cibafit."body_measurements" (like public."body_measurements" including all);
alter table cibafit."body_measurements" enable row level security;
create table if not exists cibafit."client_links" (like public."client_links" including all);
alter table cibafit."client_links" enable row level security;
create table if not exists cibafit."custom_coupons" (like public."custom_coupons" including all);
alter table cibafit."custom_coupons" enable row level security;
create table if not exists cibafit."daily_progress" (like public."daily_progress" including all);
alter table cibafit."daily_progress" enable row level security;
create table if not exists cibafit."diet_plan_items" (like public."diet_plan_items" including all);
alter table cibafit."diet_plan_items" enable row level security;
create table if not exists cibafit."diet_plan_meal_targets" (like public."diet_plan_meal_targets" including all);
alter table cibafit."diet_plan_meal_targets" enable row level security;
create table if not exists cibafit."diet_plan_template_meals" (like public."diet_plan_template_meals" including all);
alter table cibafit."diet_plan_template_meals" enable row level security;
create table if not exists cibafit."diet_plan_templates" (like public."diet_plan_templates" including all);
alter table cibafit."diet_plan_templates" enable row level security;
create table if not exists cibafit."diet_plans" (like public."diet_plans" including all);
alter table cibafit."diet_plans" enable row level security;
create table if not exists cibafit."dish_ingredients" (like public."dish_ingredients" including all);
alter table cibafit."dish_ingredients" enable row level security;
create table if not exists cibafit."dishes" (like public."dishes" including all);
alter table cibafit."dishes" enable row level security;
create table if not exists cibafit."email_notifications_log" (like public."email_notifications_log" including all);
alter table cibafit."email_notifications_log" enable row level security;
create table if not exists cibafit."email_preferences" (like public."email_preferences" including all);
alter table cibafit."email_preferences" enable row level security;
create table if not exists cibafit."favorite_meal_items" (like public."favorite_meal_items" including all);
alter table cibafit."favorite_meal_items" enable row level security;
create table if not exists cibafit."food_templates" (like public."food_templates" including all);
alter table cibafit."food_templates" enable row level security;
create table if not exists cibafit."generated_recipes" (like public."generated_recipes" including all);
alter table cibafit."generated_recipes" enable row level security;
create table if not exists cibafit."haccp_audit_log" (like public."haccp_audit_log" including all);
alter table cibafit."haccp_audit_log" enable row level security;
create table if not exists cibafit."haccp_documents" (like public."haccp_documents" including all);
alter table cibafit."haccp_documents" enable row level security;
create table if not exists cibafit."haccp_equipment" (like public."haccp_equipment" including all);
alter table cibafit."haccp_equipment" enable row level security;
create table if not exists cibafit."haccp_label_audit_log" (like public."haccp_label_audit_log" including all);
alter table cibafit."haccp_label_audit_log" enable row level security;
create table if not exists cibafit."haccp_logs" (like public."haccp_logs" including all);
alter table cibafit."haccp_logs" enable row level security;
create table if not exists cibafit."haccp_preparation_documents" (like public."haccp_preparation_documents" including all);
alter table cibafit."haccp_preparation_documents" enable row level security;
create table if not exists cibafit."haccp_preparation_ingredients" (like public."haccp_preparation_ingredients" including all);
alter table cibafit."haccp_preparation_ingredients" enable row level security;
create table if not exists cibafit."haccp_preparation_labels" (like public."haccp_preparation_labels" including all);
alter table cibafit."haccp_preparation_labels" enable row level security;
create table if not exists cibafit."haccp_task_photos" (like public."haccp_task_photos" including all);
alter table cibafit."haccp_task_photos" enable row level security;
create table if not exists cibafit."haccp_tasks" (like public."haccp_tasks" including all);
alter table cibafit."haccp_tasks" enable row level security;
create table if not exists cibafit."haccp_temperature_logs" (like public."haccp_temperature_logs" including all);
alter table cibafit."haccp_temperature_logs" enable row level security;
create table if not exists cibafit."haccp_template_tasks" (like public."haccp_template_tasks" including all);
alter table cibafit."haccp_template_tasks" enable row level security;
create table if not exists cibafit."haccp_templates" (like public."haccp_templates" including all);
alter table cibafit."haccp_templates" enable row level security;
create table if not exists cibafit."in_app_notifications" (like public."in_app_notifications" including all);
alter table cibafit."in_app_notifications" enable row level security;
create table if not exists cibafit."ingredient_categories" (like public."ingredient_categories" including all);
alter table cibafit."ingredient_categories" enable row level security;
create table if not exists cibafit."ingredient_compatibility_matrix" (like public."ingredient_compatibility_matrix" including all);
alter table cibafit."ingredient_compatibility_matrix" enable row level security;
create table if not exists cibafit."ingredient_translation" (like public."ingredient_translation" including all);
alter table cibafit."ingredient_translation" enable row level security;
create table if not exists cibafit."ingredients" (like public."ingredients" including all);
alter table cibafit."ingredients" enable row level security;
create table if not exists cibafit."integration_idempotency" (like public."integration_idempotency" including all);
alter table cibafit."integration_idempotency" enable row level security;
create table if not exists cibafit."integration_runs" (like public."integration_runs" including all);
alter table cibafit."integration_runs" enable row level security;
create table if not exists cibafit."inventory_item_allergens" (like public."inventory_item_allergens" including all);
alter table cibafit."inventory_item_allergens" enable row level security;
create table if not exists cibafit."inventory_item_photos" (like public."inventory_item_photos" including all);
alter table cibafit."inventory_item_photos" enable row level security;
create table if not exists cibafit."inventory_items" (like public."inventory_items" including all);
alter table cibafit."inventory_items" enable row level security;
create table if not exists cibafit."inventory_movements" (like public."inventory_movements" including all);
alter table cibafit."inventory_movements" enable row level security;
create table if not exists cibafit."manual_subscription_overrides" (like public."manual_subscription_overrides" including all);
alter table cibafit."manual_subscription_overrides" enable row level security;
create table if not exists cibafit."meal_days" (like public."meal_days" including all);
alter table cibafit."meal_days" enable row level security;
create table if not exists cibafit."meal_items" (like public."meal_items" including all);
alter table cibafit."meal_items" enable row level security;
create table if not exists cibafit."meal_log_ingredients" (like public."meal_log_ingredients" including all);
alter table cibafit."meal_log_ingredients" enable row level security;
create table if not exists cibafit."meal_logs" (like public."meal_logs" including all);
alter table cibafit."meal_logs" enable row level security;
create table if not exists cibafit."meal_reminder_settings" (like public."meal_reminder_settings" including all);
alter table cibafit."meal_reminder_settings" enable row level security;
create table if not exists cibafit."meals" (like public."meals" including all);
alter table cibafit."meals" enable row level security;
create table if not exists cibafit."messages" (like public."messages" including all);
alter table cibafit."messages" enable row level security;
create table if not exists cibafit."nutrition_plan_days" (like public."nutrition_plan_days" including all);
alter table cibafit."nutrition_plan_days" enable row level security;
create table if not exists cibafit."nutrition_plan_meals" (like public."nutrition_plan_meals" including all);
alter table cibafit."nutrition_plan_meals" enable row level security;
create table if not exists cibafit."nutrition_plan_weeks" (like public."nutrition_plan_weeks" including all);
alter table cibafit."nutrition_plan_weeks" enable row level security;
create table if not exists cibafit."nutrition_plans" (like public."nutrition_plans" including all);
alter table cibafit."nutrition_plans" enable row level security;
create table if not exists cibafit."nutrition_targets" (like public."nutrition_targets" including all);
alter table cibafit."nutrition_targets" enable row level security;
create table if not exists cibafit."nutritionist_commissions" (like public."nutritionist_commissions" including all);
alter table cibafit."nutritionist_commissions" enable row level security;
create table if not exists cibafit."nutritionist_coupons" (like public."nutritionist_coupons" including all);
alter table cibafit."nutritionist_coupons" enable row level security;
create table if not exists cibafit."preparation_allergens" (like public."preparation_allergens" including all);
alter table cibafit."preparation_allergens" enable row level security;
create table if not exists cibafit."preparation_ingredients" (like public."preparation_ingredients" including all);
alter table cibafit."preparation_ingredients" enable row level security;
create table if not exists cibafit."preparations" (like public."preparations" including all);
alter table cibafit."preparations" enable row level security;
create table if not exists cibafit."pro_meal_text_suggestions" (like public."pro_meal_text_suggestions" including all);
alter table cibafit."pro_meal_text_suggestions" enable row level security;
create table if not exists cibafit."pro_suggestions" (like public."pro_suggestions" including all);
alter table cibafit."pro_suggestions" enable row level security;
create table if not exists cibafit."product_submissions" (like public."product_submissions" including all);
alter table cibafit."product_submissions" enable row level security;
create table if not exists cibafit."product_usage_log" (like public."product_usage_log" including all);
alter table cibafit."product_usage_log" enable row level security;
create table if not exists cibafit."products" (like public."products" including all);
alter table cibafit."products" enable row level security;
create table if not exists cibafit."professional_invites" (like public."professional_invites" including all);
alter table cibafit."professional_invites" enable row level security;
create table if not exists cibafit."professional_link_requests" (like public."professional_link_requests" including all);
alter table cibafit."professional_link_requests" enable row level security;
create table if not exists cibafit."professional_notes" (like public."professional_notes" including all);
alter table cibafit."professional_notes" enable row level security;
create table if not exists cibafit."professional_profiles" (like public."professional_profiles" including all);
alter table cibafit."professional_profiles" enable row level security;
create table if not exists cibafit."profiles" (like public."profiles" including all);
alter table cibafit."profiles" enable row level security;
create table if not exists cibafit."quick_day_logs" (like public."quick_day_logs" including all);
alter table cibafit."quick_day_logs" enable row level security;
create table if not exists cibafit."recipe_allergens" (like public."recipe_allergens" including all);
alter table cibafit."recipe_allergens" enable row level security;
create table if not exists cibafit."recipe_ingredients" (like public."recipe_ingredients" including all);
alter table cibafit."recipe_ingredients" enable row level security;
create table if not exists cibafit."recipes" (like public."recipes" including all);
alter table cibafit."recipes" enable row level security;
create table if not exists cibafit."restaurant_api_keys" (like public."restaurant_api_keys" including all);
alter table cibafit."restaurant_api_keys" enable row level security;
create table if not exists cibafit."restaurant_documents" (like public."restaurant_documents" including all);
alter table cibafit."restaurant_documents" enable row level security;
create table if not exists cibafit."restaurant_invites" (like public."restaurant_invites" including all);
alter table cibafit."restaurant_invites" enable row level security;
create table if not exists cibafit."restaurant_members" (like public."restaurant_members" including all);
alter table cibafit."restaurant_members" enable row level security;
create table if not exists cibafit."restaurants" (like public."restaurants" including all);
alter table cibafit."restaurants" enable row level security;
create table if not exists cibafit."stripe_payments" (like public."stripe_payments" including all);
alter table cibafit."stripe_payments" enable row level security;
create table if not exists cibafit."stripe_settings" (like public."stripe_settings" including all);
alter table cibafit."stripe_settings" enable row level security;
create table if not exists cibafit."subscription_payments" (like public."subscription_payments" including all);
alter table cibafit."subscription_payments" enable row level security;
create table if not exists cibafit."subscription_plans" (like public."subscription_plans" including all);
alter table cibafit."subscription_plans" enable row level security;
create table if not exists cibafit."subscriptions" (like public."subscriptions" including all);
alter table cibafit."subscriptions" enable row level security;
create table if not exists cibafit."supplier_invites" (like public."supplier_invites" including all);
alter table cibafit."supplier_invites" enable row level security;
create table if not exists cibafit."supplier_order_items" (like public."supplier_order_items" including all);
alter table cibafit."supplier_order_items" enable row level security;
create table if not exists cibafit."supplier_orders" (like public."supplier_orders" including all);
alter table cibafit."supplier_orders" enable row level security;
create table if not exists cibafit."supplier_products" (like public."supplier_products" including all);
alter table cibafit."supplier_products" enable row level security;
create table if not exists cibafit."supplier_restaurants" (like public."supplier_restaurants" including all);
alter table cibafit."supplier_restaurants" enable row level security;
create table if not exists cibafit."suppliers" (like public."suppliers" including all);
alter table cibafit."suppliers" enable row level security;
create table if not exists cibafit."support_requests" (like public."support_requests" including all);
alter table cibafit."support_requests" enable row level security;
create table if not exists cibafit."template_recipes" (like public."template_recipes" including all);
alter table cibafit."template_recipes" enable row level security;
create table if not exists cibafit."user_favorite_meals" (like public."user_favorite_meals" including all);
alter table cibafit."user_favorite_meals" enable row level security;
create table if not exists cibafit."user_favorites" (like public."user_favorites" including all);
alter table cibafit."user_favorites" enable row level security;
create table if not exists cibafit."user_nutritionist_links" (like public."user_nutritionist_links" including all);
alter table cibafit."user_nutritionist_links" enable row level security;
create table if not exists cibafit."user_product_favorites" (like public."user_product_favorites" including all);
alter table cibafit."user_product_favorites" enable row level security;
create table if not exists cibafit."waste_savings" (like public."waste_savings" including all);
alter table cibafit."waste_savings" enable row level security;
create table if not exists cibafit."weight_goals" (like public."weight_goals" including all);
alter table cibafit."weight_goals" enable row level security;

-- 2. Funzioni
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_label_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('draft','finalized','cancelled') THEN
    RAISE EXCEPTION 'Invalid haccp label status: %', NEW.status;
  END IF;
  IF NEW.conservation_type NOT IN ('ambiente','frigo','freezer','sottovuoto','altro') THEN
    RAISE EXCEPTION 'Invalid conservation_type: %', NEW.conservation_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_label_status"() from public;
grant execute on function cibafit."validate_haccp_label_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_document_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.document_type NOT IN ('bolla','fattura','ddt','altro') THEN
    RAISE EXCEPTION 'Invalid document_type: %', NEW.document_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_document_type"() from public;
grant execute on function cibafit."validate_haccp_document_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.restaurant_invite_preview(_token text)
 RETURNS TABLE(restaurant_name text, status text)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT r.name,
    CASE
      WHEN i.revoked_at IS NOT NULL THEN 'revoked'
      WHEN i.used_at IS NOT NULL THEN 'used'
      WHEN i.expires_at < now() THEN 'expired'
      ELSE 'valid'
    END
  FROM cibafit.restaurant_invites i
  JOIN cibafit.restaurants r ON r.id = i.restaurant_id
  WHERE i.token = _token;
$function$;
revoke all on function cibafit."restaurant_invite_preview"(_token text) from public;
grant execute on function cibafit."restaurant_invite_preview"(_token text) to anon, authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_nutrition_plan(_plan_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.nutrition_plans
    WHERE id = _plan_id
    AND (nutritionist_user_id = auth.uid() OR client_user_id = auth.uid())
  );
$function$;
revoke all on function cibafit."owns_nutrition_plan"(_plan_id uuid) from public;
grant execute on function cibafit."owns_nutrition_plan"(_plan_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_submission_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('pending', 'approved', 'rejected') THEN
    RAISE EXCEPTION 'Invalid submission status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_submission_status"() from public;
grant execute on function cibafit."validate_submission_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.handle_new_email_prefs()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  INSERT INTO cibafit.email_preferences (user_id) VALUES (NEW.id)
  ON CONFLICT DO NOTHING;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."handle_new_email_prefs"() from public;
grant execute on function cibafit."handle_new_email_prefs"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_link_request_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('pending', 'approved', 'rejected') THEN
    RAISE EXCEPTION 'Invalid link_request status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_link_request_status"() from public;
grant execute on function cibafit."validate_link_request_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.mark_supplier_order_stock_loaded(_order_id uuid)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  UPDATE cibafit.supplier_orders o SET stock_loaded_at = now(), updated_at = now()
  WHERE o.id = _order_id
    AND o.status = 'consegnato'
    AND EXISTS (SELECT 1 FROM cibafit.restaurants r WHERE r.id = o.restaurant_id AND r.owner_id = auth.uid());
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Ordine non trovato o non ancora consegnato';
  END IF;
END;
$function$;
revoke all on function cibafit."mark_supplier_order_stock_loaded"(_order_id uuid) from public;
grant execute on function cibafit."mark_supplier_order_stock_loaded"(_order_id uuid) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_profile_role()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.role NOT IN ('user', 'restaurant_owner', 'admin', 'professional', 'supplier') THEN
    RAISE EXCEPTION 'Invalid role: %', NEW.role;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_profile_role"() from public;
grant execute on function cibafit."validate_profile_role"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.haccp_temperature_max(_equipment_type text)
 RETURNS numeric
 LANGUAGE sql
 IMMUTABLE
 SET search_path TO 'cibafit'
AS $function$
  SELECT CASE _equipment_type
    WHEN 'freezer' THEN -18
    WHEN 'fridge' THEN 4
    WHEN 'cold_room' THEN 4
  END::numeric;
$function$;
revoke all on function cibafit."haccp_temperature_max"(_equipment_type text) from public;
grant execute on function cibafit."haccp_temperature_max"(_equipment_type text) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_np_week(_week_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.nutrition_plan_weeks w
    JOIN cibafit.nutrition_plans p ON p.id = w.plan_id
    WHERE w.id = _week_id
    AND (p.nutritionist_user_id = auth.uid() OR p.client_user_id = auth.uid())
  );
$function$;
revoke all on function cibafit."owns_np_week"(_week_id uuid) from public;
grant execute on function cibafit."owns_np_week"(_week_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_template_recipe_meal_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.meal_type NOT IN ('colazione', 'pranzo', 'cena', 'spuntino') THEN
    RAISE EXCEPTION 'Invalid meal_type: %', NEW.meal_type;
  END IF;
  IF NEW.diet_category NOT IN ('mediterranea', 'keto', 'digiuno', 'massa', 'dimagrimento') THEN
    RAISE EXCEPTION 'Invalid diet_category: %', NEW.diet_category;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_template_recipe_meal_type"() from public;
grant execute on function cibafit."validate_template_recipe_meal_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.gen_haccp_lot_code()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _next INT;
BEGIN
  IF NEW.internal_lot_code IS NULL OR NEW.internal_lot_code = '' THEN
    SELECT COALESCE(MAX(NULLIF(REGEXP_REPLACE(internal_lot_code,'[^0-9]','','g'),'')::INT),0)+1
      INTO _next
      FROM cibafit.haccp_preparation_labels
      WHERE restaurant_id = NEW.restaurant_id;
    NEW.internal_lot_code := 'L-' || LPAD(_next::text, 5, '0');
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."gen_haccp_lot_code"() from public;
grant execute on function cibafit."gen_haccp_lot_code"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_nutrition_plan_mode()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.plan_mode NOT IN ('targets_only', 'weekly_meal_plan') THEN
    RAISE EXCEPTION 'Invalid plan_mode: %', NEW.plan_mode;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_nutrition_plan_mode"() from public;
grant execute on function cibafit."validate_nutrition_plan_mode"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_meal_day(_meal_day_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (SELECT 1 FROM cibafit.meal_days WHERE id = _meal_day_id AND user_id = auth.uid());
$function$;
revoke all on function cibafit."owns_meal_day"(_meal_day_id uuid) from public;
grant execute on function cibafit."owns_meal_day"(_meal_day_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.auto_create_nutritionist_coupon()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _name text;
  _code text;
  _suffix text;
  _attempts int := 0;
BEGIN
  -- Only for professionals
  IF NEW.role != 'professional' THEN
    RETURN NEW;
  END IF;

  -- Build code from name
  _name := UPPER(COALESCE(SPLIT_PART(NEW.full_name, ' ', 1), 'PRO'));
  _name := REGEXP_REPLACE(_name, '[^A-Z0-9]', '', 'g');
  IF LENGTH(_name) < 2 THEN _name := 'PRO'; END IF;
  _name := LEFT(_name, 8);

  LOOP
    _suffix := UPPER(SUBSTR(MD5(RANDOM()::text), 1, 3));
    _code := _name || _suffix;
    _attempts := _attempts + 1;

    BEGIN
      INSERT INTO cibafit.nutritionist_coupons (nutritionist_user_id, coupon_code)
      VALUES (NEW.id, _code);
      EXIT;
    EXCEPTION WHEN unique_violation THEN
      IF _attempts > 10 THEN
        _code := _name || UPPER(SUBSTR(MD5(RANDOM()::text), 1, 6));
        INSERT INTO cibafit.nutritionist_coupons (nutritionist_user_id, coupon_code)
        VALUES (NEW.id, _code);
        EXIT;
      END IF;
    END;
  END LOOP;

  RETURN NEW;
END;
$function$;
revoke all on function cibafit."auto_create_nutritionist_coupon"() from public;
grant execute on function cibafit."auto_create_nutritionist_coupon"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.haccp_label_accessible(_label_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS(
    SELECT 1 FROM cibafit.haccp_preparation_labels l
    WHERE l.id = _label_id
      AND (cibafit.is_restaurant_accessible(l.restaurant_id) OR cibafit.current_user_is_admin())
  );
$function$;
revoke all on function cibafit."haccp_label_accessible"(_label_id uuid) from public;
grant execute on function cibafit."haccp_label_accessible"(_label_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_inventory_owner()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.owner_user_id IS NULL AND NEW.restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Either owner_user_id or restaurant_id must be set';
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_inventory_owner"() from public;
grant execute on function cibafit."validate_inventory_owner"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_appointment_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('scheduled', 'completed', 'cancelled') THEN
    RAISE EXCEPTION 'Invalid appointment status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_appointment_status"() from public;
grant execute on function cibafit."validate_appointment_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_diet_plan_item_meal_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.meal_type NOT IN ('colazione', 'pranzo', 'cena', 'spuntino') THEN
    RAISE EXCEPTION 'Invalid meal_type: %', NEW.meal_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_diet_plan_item_meal_type"() from public;
grant execute on function cibafit."validate_diet_plan_item_meal_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_supplier_restaurant_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('pending', 'active', 'revoked') THEN
    RAISE EXCEPTION 'Invalid supplier_restaurant status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_supplier_restaurant_status"() from public;
grant execute on function cibafit."validate_supplier_restaurant_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.protect_finalized_haccp_label()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF OLD.status = 'finalized' THEN
    -- Allow only: cancellation with reason, updated_at refresh
    IF NEW.status = 'cancelled' AND NEW.cancel_reason IS NOT NULL THEN
      RETURN NEW;
    END IF;
    IF NEW.preparation_name IS DISTINCT FROM OLD.preparation_name
      OR NEW.quantity IS DISTINCT FROM OLD.quantity
      OR NEW.unit IS DISTINCT FROM OLD.unit
      OR NEW.production_date IS DISTINCT FROM OLD.production_date
      OR NEW.expiration_date IS DISTINCT FROM OLD.expiration_date
      OR NEW.conservation_type IS DISTINCT FROM OLD.conservation_type
      OR NEW.internal_lot_code IS DISTINCT FROM OLD.internal_lot_code
      OR NEW.allergens IS DISTINCT FROM OLD.allergens
      OR NEW.notes IS DISTINCT FROM OLD.notes THEN
      RAISE EXCEPTION 'Cannot modify a finalized HACCP label. Cancel it (with reason) or duplicate it.';
    END IF;
  END IF;
  IF OLD.status = 'cancelled' THEN
    RAISE EXCEPTION 'Cannot modify a cancelled HACCP label.';
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."protect_finalized_haccp_label"() from public;
grant execute on function cibafit."protect_finalized_haccp_label"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_np_meal_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.meal_type NOT IN ('colazione', 'spuntino_mattina', 'pranzo', 'spuntino_pomeriggio', 'cena', 'extra') THEN
    RAISE EXCEPTION 'Invalid meal_type: %', NEW.meal_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_np_meal_type"() from public;
grant execute on function cibafit."validate_np_meal_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_storage_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.storage_type NOT IN ('frigo', 'freezer', 'ambiente') THEN
    RAISE EXCEPTION 'Invalid storage_type: %', NEW.storage_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_storage_type"() from public;
grant execute on function cibafit."validate_storage_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_audit_action()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.action NOT IN ('created','finalized','printed','reprinted','cancelled','modified','duplicated') THEN
    RAISE EXCEPTION 'Invalid audit action: %', NEW.action;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_audit_action"() from public;
grant execute on function cibafit."validate_haccp_audit_action"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.accept_restaurant_invite(_token text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _uid uuid := auth.uid();
  _inv cibafit.restaurant_invites;
BEGIN
  IF _uid IS NULL THEN
    RAISE EXCEPTION 'Accedi per accettare l''invito';
  END IF;

  SELECT * INTO _inv FROM cibafit.restaurant_invites WHERE token = _token FOR UPDATE;
  IF NOT FOUND OR _inv.revoked_at IS NOT NULL THEN
    RAISE EXCEPTION 'Invito non valido';
  END IF;

  IF EXISTS (SELECT 1 FROM cibafit.restaurant_members WHERE restaurant_id = _inv.restaurant_id AND user_id = _uid) THEN
    RETURN _inv.restaurant_id;
  END IF;

  IF _inv.used_at IS NOT NULL THEN
    RAISE EXCEPTION 'Questo invito è già stato usato';
  END IF;
  IF _inv.expires_at < now() THEN
    RAISE EXCEPTION 'Questo invito è scaduto';
  END IF;
  IF EXISTS (SELECT 1 FROM cibafit.restaurants WHERE owner_id = _uid) THEN
    RAISE EXCEPTION 'Questo account ha già un ristorante: usa un altro account per lo staff';
  END IF;

  INSERT INTO cibafit.restaurant_members (restaurant_id, user_id, member_role)
  VALUES (_inv.restaurant_id, _uid, 'staff');

  UPDATE cibafit.restaurant_invites SET used_by = _uid, used_at = now() WHERE id = _inv.id;

  RETURN _inv.restaurant_id;
END;
$function$;
revoke all on function cibafit."accept_restaurant_invite"(_token text) from public;
grant execute on function cibafit."accept_restaurant_invite"(_token text) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_meal_item_source()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.source_type NOT IN ('product', 'inventory_item', 'custom') THEN
    RAISE EXCEPTION 'Invalid source_type: %', NEW.source_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_meal_item_source"() from public;
grant execute on function cibafit."validate_meal_item_source"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_commission_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('pending', 'approved', 'paid', 'cancelled') THEN
    RAISE EXCEPTION 'Invalid commission status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_commission_status"() from public;
grant execute on function cibafit."validate_commission_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.has_pending_link_request(_pro_id uuid, _user_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.professional_link_requests
    WHERE professional_id = _pro_id
      AND user_id = _user_id
      AND status = 'pending'
  );
$function$;
revoke all on function cibafit."has_pending_link_request"(_pro_id uuid, _user_id uuid) from public;
grant execute on function cibafit."has_pending_link_request"(_pro_id uuid, _user_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_doc_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.doc_type NOT IN ('bolla', 'fattura', 'altro') THEN
    RAISE EXCEPTION 'Invalid doc_type: %', NEW.doc_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_doc_type"() from public;
grant execute on function cibafit."validate_doc_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.has_active_pro_link(_pro_id uuid, _client_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.client_links
    WHERE professional_id = _pro_id
      AND client_user_id = _client_id
      AND status = 'active'
  );
$function$;
revoke all on function cibafit."has_active_pro_link"(_pro_id uuid, _client_id uuid) from public;
grant execute on function cibafit."has_active_pro_link"(_pro_id uuid, _client_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.update_supplier_order_status(_order_id uuid, _status text, _note text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _o cibafit.supplier_orders;
  _is_supplier boolean;
  _is_restaurant boolean;
  _notify uuid;
  _label text;
  _party text;
BEGIN
  SELECT * INTO _o FROM cibafit.supplier_orders WHERE id = _order_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Ordine non trovato';
  END IF;

  _is_supplier := cibafit.owns_supplier(_o.supplier_id);
  _is_restaurant := EXISTS (SELECT 1 FROM cibafit.restaurants WHERE id = _o.restaurant_id AND owner_id = auth.uid());

  IF NOT (
    (_is_supplier AND (
      (_o.status = 'inviato' AND _status IN ('confermato', 'rifiutato', 'consegnato'))
      OR (_o.status = 'confermato' AND _status = 'consegnato')))
    OR (_is_restaurant AND (
      (_o.status = 'inviato' AND _status IN ('annullato', 'consegnato'))
      OR (_o.status = 'confermato' AND _status = 'consegnato')))
  ) THEN
    RAISE EXCEPTION 'Cambio di stato non consentito (% -> %)', _o.status, _status;
  END IF;

  UPDATE cibafit.supplier_orders SET
    status = _status,
    updated_at = now(),
    confirmed_at = CASE WHEN _status = 'confermato' THEN now() ELSE confirmed_at END,
    delivered_at = CASE WHEN _status = 'consegnato' THEN now() ELSE delivered_at END,
    supplier_note = CASE WHEN _is_supplier AND nullif(trim(_note), '') IS NOT NULL THEN trim(_note) ELSE supplier_note END
  WHERE id = _order_id;

  _label := CASE _status
    WHEN 'confermato' THEN 'confermato'
    WHEN 'rifiutato' THEN 'rifiutato'
    WHEN 'consegnato' THEN 'consegnato'
    WHEN 'annullato' THEN 'annullato'
  END;

  IF _is_supplier THEN
    SELECT owner_id INTO _notify FROM cibafit.restaurants WHERE id = _o.restaurant_id;
    SELECT name INTO _party FROM cibafit.suppliers WHERE id = _o.supplier_id;
  ELSE
    SELECT owner_user_id INTO _notify FROM cibafit.suppliers WHERE id = _o.supplier_id;
    SELECT name INTO _party FROM cibafit.restaurants WHERE id = _o.restaurant_id;
  END IF;

  IF _notify IS NOT NULL AND _notify <> auth.uid() THEN
    INSERT INTO cibafit.in_app_notifications (user_id, type, title, body, metadata)
    VALUES (_notify, 'supplier_order_update',
      'Ordine ' || _label,
      _party || ' ha segnato l''ordine del ' || to_char(_o.created_at AT TIME ZONE 'Europe/Rome', 'DD/MM') || ' come ' || _label
        || coalesce('. Nota: ' || nullif(trim(_note), ''), ''),
      jsonb_build_object('order_id', _order_id, 'for', CASE WHEN _is_supplier THEN 'restaurant' ELSE 'supplier' END));
  END IF;
END;
$function$;
revoke all on function cibafit."update_supplier_order_status"(_order_id uuid, _status text, _note text) from public;
grant execute on function cibafit."update_supplier_order_status"(_order_id uuid, _status text, _note text) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_payment_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.payment_status NOT IN ('pending', 'completed', 'refunded', 'failed') THEN
    RAISE EXCEPTION 'Invalid payment_status: %', NEW.payment_status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_payment_status"() from public;
grant execute on function cibafit."validate_payment_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.auto_create_haccp_label_for_preparation()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _cons text;
BEGIN
  IF NEW.restaurant_id IS NULL THEN
    RETURN NEW;
  END IF;

  IF EXISTS (SELECT 1 FROM cibafit.haccp_preparation_labels WHERE source_preparation_id = NEW.id) THEN
    RETURN NEW;
  END IF;

  _cons := CASE WHEN NEW.storage_type IN ('frigo','freezer','ambiente') THEN NEW.storage_type ELSE 'frigo' END;

  INSERT INTO cibafit.haccp_preparation_labels (
    restaurant_id, preparation_name, production_date, expiration_date,
    conservation_type, quantity, unit, portions, notes, status,
    created_by, source_preparation_id
  )
  VALUES (
    NEW.restaurant_id,
    NEW.name,
    COALESCE(NEW.production_date, NEW.prepared_at::date, CURRENT_DATE),
    COALESCE(NEW.use_by_date, CURRENT_DATE + INTERVAL '3 days'),
    _cons,
    NULL,
    NULL,
    COALESCE(NEW.portions, 1),
    NEW.notes,
    'draft',
    NEW.owner_user_id,
    NEW.id
  );

  RETURN NEW;
END;
$function$;
revoke all on function cibafit."auto_create_haccp_label_for_preparation"() from public;
grant execute on function cibafit."auto_create_haccp_label_for_preparation"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_meal_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.meal_type NOT IN ('colazione', 'pranzo', 'cena', 'spuntino') THEN
    RAISE EXCEPTION 'Invalid meal_type: %', NEW.meal_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_meal_type"() from public;
grant execute on function cibafit."validate_meal_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.accept_supplier_invite(_code text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _restaurant_id uuid;
  _inv cibafit.supplier_invites;
BEGIN
  SELECT id INTO _restaurant_id FROM cibafit.restaurants WHERE owner_id = auth.uid() LIMIT 1;
  IF _restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Solo il titolare di un ristorante può collegare un fornitore';
  END IF;

  SELECT * INTO _inv FROM cibafit.supplier_invites
  WHERE invite_code = upper(trim(_code)) AND status = 'active'
  FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Il codice invito non esiste o è già stato usato';
  END IF;

  INSERT INTO cibafit.supplier_restaurants (supplier_id, restaurant_id, status, invite_code)
  VALUES (_inv.supplier_id, _restaurant_id, 'active', _inv.invite_code)
  ON CONFLICT (supplier_id, restaurant_id)
  DO UPDATE SET status = 'active', invite_code = EXCLUDED.invite_code;

  UPDATE cibafit.supplier_invites SET status = 'used' WHERE id = _inv.id;
  RETURN _inv.supplier_id;
END;
$function$;
revoke all on function cibafit."accept_supplier_invite"(_code text) from public;
grant execute on function cibafit."accept_supplier_invite"(_code text) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_preparation_storage()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.storage_type NOT IN ('frigo', 'freezer', 'ambiente') THEN
    RAISE EXCEPTION 'Invalid storage_type: %', NEW.storage_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_preparation_storage"() from public;
grant execute on function cibafit."validate_preparation_storage"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.touch_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$function$;
revoke all on function cibafit."touch_updated_at"() from public;
grant execute on function cibafit."touch_updated_at"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_np_day(_day_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.nutrition_plan_days d
    JOIN cibafit.nutrition_plan_weeks w ON w.id = d.week_id
    JOIN cibafit.nutrition_plans p ON p.id = w.plan_id
    WHERE d.id = _day_id
    AND (p.nutritionist_user_id = auth.uid() OR p.client_user_id = auth.uid())
  );
$function$;
revoke all on function cibafit."owns_np_day"(_day_id uuid) from public;
grant execute on function cibafit."owns_np_day"(_day_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_preparation_owner()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.owner_user_id IS NULL AND NEW.restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Either owner_user_id or restaurant_id must be set';
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_preparation_owner"() from public;
grant execute on function cibafit."validate_preparation_owner"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.log_product_usage()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.owner_user_id IS NOT NULL THEN
    INSERT INTO cibafit.product_usage_log (user_id, product_id)
    VALUES (NEW.owner_user_id, NEW.product_id);
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."log_product_usage"() from public;
grant execute on function cibafit."log_product_usage"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.is_admin(_user_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.profiles
    WHERE id = _user_id AND role = 'admin'
  );
$function$;
revoke all on function cibafit."is_admin"(_user_id uuid) from public;
grant execute on function cibafit."is_admin"(_user_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.is_restaurant_owner(_restaurant_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM restaurants WHERE id = _restaurant_id AND owner_id = auth.uid()
  )
  OR EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'
  );
$function$;
revoke all on function cibafit."is_restaurant_owner"(_restaurant_id uuid) from public;
grant execute on function cibafit."is_restaurant_owner"(_restaurant_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.is_restaurant_accessible(_restaurant_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM restaurants WHERE id = _restaurant_id AND owner_id = auth.uid()
  )
  OR EXISTS (
    SELECT 1 FROM restaurant_members WHERE restaurant_id = _restaurant_id AND user_id = auth.uid()
  )
  OR EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'
  );
$function$;
revoke all on function cibafit."is_restaurant_accessible"(_restaurant_id uuid) from public;
grant execute on function cibafit."is_restaurant_accessible"(_restaurant_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.notify_haccp_temperature_alert()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _max numeric := cibafit.haccp_temperature_max(NEW.equipment_type);
  _owner uuid;
  _restaurant_name text;
BEGIN
  IF _max IS NULL OR NEW.temperature_value <= _max THEN
    RETURN NEW;
  END IF;

  SELECT owner_id, name INTO _owner, _restaurant_name
  FROM cibafit.restaurants WHERE id = NEW.restaurant_id;
  IF _owner IS NULL THEN
    RETURN NEW;
  END IF;

  INSERT INTO cibafit.in_app_notifications (user_id, type, title, body, metadata)
  VALUES (
    _owner,
    'temperature_alert',
    'Temperatura fuori soglia: ' || NEW.equipment_name,
    format('%s: %s °C (massimo %s °C), registrata da %s.',
      _restaurant_name, NEW.temperature_value, _max, coalesce(NEW.recorded_by_name, 'staff')),
    jsonb_build_object('restaurant_id', NEW.restaurant_id, 'temperature_log_id', NEW.id)
  );

  -- CibaFit: notifica HTTP verso le funzioni di Cibarius disattivata.

  RETURN NEW;
END;
$function$;
revoke all on function cibafit."notify_haccp_temperature_alert"() from public;
grant execute on function cibafit."notify_haccp_temperature_alert"() to service_role;
CREATE OR REPLACE FUNCTION cibafit.create_supplier_order(_supplier_id uuid, _items jsonb, _notes text DEFAULT NULL::text, _requested_delivery_date date DEFAULT NULL::date)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _restaurant_id uuid;
  _restaurant_name text;
  _order_id uuid;
  _supplier_owner uuid;
  _lines int;
  _total numeric;
BEGIN
  SELECT id, name INTO _restaurant_id, _restaurant_name FROM cibafit.restaurants WHERE owner_id = auth.uid() LIMIT 1;
  IF _restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Solo il titolare del ristorante può ordinare';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM cibafit.supplier_restaurants
    WHERE supplier_id = _supplier_id AND restaurant_id = _restaurant_id AND status = 'active'
  ) THEN
    RAISE EXCEPTION 'Il fornitore non è collegato al ristorante';
  END IF;
  IF _requested_delivery_date IS NOT NULL AND _requested_delivery_date < current_date THEN
    RAISE EXCEPTION 'La data di consegna è già passata';
  END IF;

  INSERT INTO cibafit.supplier_orders (supplier_id, restaurant_id, status, notes, requested_delivery_date, created_by, total)
  VALUES (_supplier_id, _restaurant_id, 'inviato', nullif(trim(_notes), ''), _requested_delivery_date, auth.uid(), 0)
  RETURNING id INTO _order_id;

  INSERT INTO cibafit.supplier_order_items (order_id, supplier_product_id, product_id, product_name, unit, unit_price, quantity)
  SELECT _order_id, sp.id, sp.product_id, coalesce(p.name, 'Prodotto'), coalesce(sp.unit, p.unit), sp.price, (item->>'quantity')::numeric
  FROM jsonb_array_elements(_items) AS item
  JOIN cibafit.supplier_products sp
    ON sp.id = (item->>'supplier_product_id')::uuid AND sp.supplier_id = _supplier_id
  LEFT JOIN cibafit.products p ON p.id = sp.product_id
  WHERE (item->>'quantity')::numeric > 0
    AND coalesce(sp.availability, 'available') <> 'unavailable';

  GET DIAGNOSTICS _lines = ROW_COUNT;
  IF _lines = 0 OR _lines <> jsonb_array_length(_items) THEN
    RAISE EXCEPTION 'Ordine non valido: controlla prodotti e quantità';
  END IF;

  SELECT coalesce(sum(line_total), 0) INTO _total FROM cibafit.supplier_order_items WHERE order_id = _order_id;
  UPDATE cibafit.supplier_orders SET total = _total WHERE id = _order_id;

  SELECT owner_user_id INTO _supplier_owner FROM cibafit.suppliers WHERE id = _supplier_id;
  IF _supplier_owner IS NOT NULL THEN
    INSERT INTO cibafit.in_app_notifications (user_id, type, title, body, metadata)
    VALUES (_supplier_owner, 'supplier_order_new', 'Nuovo ordine da ' || _restaurant_name,
      format('%s prodotti, totale € %s', _lines, to_char(_total, 'FM999G990D00')),
      jsonb_build_object('order_id', _order_id));
  END IF;

  -- CibaFit: notifica HTTP verso le funzioni di Cibarius disattivata.

  RETURN _order_id;
END;
$function$;
revoke all on function cibafit."create_supplier_order"(_supplier_id uuid, _items jsonb, _notes text, _requested_delivery_date date) from public;
grant execute on function cibafit."create_supplier_order"(_supplier_id uuid, _items jsonb, _notes text, _requested_delivery_date date) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.current_user_is_admin()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (SELECT 1 FROM cibafit.profiles WHERE id = auth.uid() AND role = 'admin');
$function$;
revoke all on function cibafit."current_user_is_admin"() from public;
grant execute on function cibafit."current_user_is_admin"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.purge_unused_product(p_product_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NOT cibafit.current_user_is_admin() THEN
    RAISE EXCEPTION 'Riservato agli amministratori';
  END IF;

  IF EXISTS (SELECT 1 FROM cibafit.inventory_items         WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.inventory_movements     WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.meal_items              WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.preparation_ingredients WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.recipe_ingredients      WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.supplier_products       WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.user_product_favorites  WHERE product_id = p_product_id)
  OR EXISTS (SELECT 1 FROM cibafit.product_usage_log       WHERE product_id = p_product_id)
  THEN
    RETURN false;
  END IF;

  DELETE FROM cibafit.products WHERE id = p_product_id;
  RETURN true;
END;
$function$;
revoke all on function cibafit."purge_unused_product"(p_product_id uuid) from public;
grant execute on function cibafit."purge_unused_product"(p_product_id uuid) to anon, authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.get_user_role(_user_id uuid)
 RETURNS text
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT role FROM cibafit.profiles WHERE id = _user_id LIMIT 1;
$function$;
revoke all on function cibafit."get_user_role"(_user_id uuid) from public;
grant execute on function cibafit."get_user_role"(_user_id uuid) to anon, authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_meal_log_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.meal_type NOT IN ('colazione', 'pranzo', 'cena', 'spuntino') THEN
    RAISE EXCEPTION 'Invalid meal_type: %', NEW.meal_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_meal_log_type"() from public;
grant execute on function cibafit."validate_meal_log_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_equipment_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.equipment_type NOT IN ('cella_frigorifera', 'frigorifero', 'freezer') THEN
    RAISE EXCEPTION 'Invalid equipment_type: %', NEW.equipment_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_equipment_type"() from public;
grant execute on function cibafit."validate_haccp_equipment_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_supplier(_supplier_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (SELECT 1 FROM cibafit.suppliers WHERE id = _supplier_id AND owner_user_id = auth.uid());
$function$;
revoke all on function cibafit."owns_supplier"(_supplier_id uuid) from public;
grant execute on function cibafit."owns_supplier"(_supplier_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.supplier_invite_preview(_code text)
 RETURNS TABLE(supplier_name text)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT s.name
  FROM cibafit.supplier_invites i
  JOIN cibafit.suppliers s ON s.id = i.supplier_id
  WHERE i.invite_code = upper(trim(_code)) AND i.status = 'active';
$function$;
revoke all on function cibafit."supplier_invite_preview"(_code text) from public;
grant execute on function cibafit."supplier_invite_preview"(_code text) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_log_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('completata', 'non_controllata', 'in_ritardo', 'annullata') THEN
    RAISE EXCEPTION 'Invalid haccp_log status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_log_status"() from public;
grant execute on function cibafit."validate_haccp_log_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_attachment_entity_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.entity_type NOT IN ('product', 'inventory_item', 'recipe', 'profile') THEN
    RAISE EXCEPTION 'Invalid entity_type: %', NEW.entity_type;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_attachment_entity_type"() from public;
grant execute on function cibafit."validate_attachment_entity_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_invite_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('active', 'used', 'disabled') THEN
    RAISE EXCEPTION 'Invalid invite status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_invite_status"() from public;
grant execute on function cibafit."validate_invite_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_support_request_type()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.type NOT IN ('problema', 'suggerimento', 'delete_account') THEN
    RAISE EXCEPTION 'Invalid support request type: %', NEW.type;
  END IF;
  IF NEW.status NOT IN ('open', 'resolved', 'closed') THEN
    RAISE EXCEPTION 'Invalid support request status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_support_request_type"() from public;
grant execute on function cibafit."validate_support_request_type"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_member_role()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.member_role NOT IN ('owner', 'manager', 'staff') THEN
    RAISE EXCEPTION 'Invalid member_role: %', NEW.member_role;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_member_role"() from public;
grant execute on function cibafit."validate_member_role"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_supplier_invite_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('active', 'used', 'disabled') THEN
    RAISE EXCEPTION 'Invalid supplier invite status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_supplier_invite_status"() from public;
grant execute on function cibafit."validate_supplier_invite_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.set_nutrition_available()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  NEW.nutrition_available := (NEW.calories_100g IS NOT NULL AND NEW.calories_100g > 0);
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."set_nutrition_available"() from public;
grant execute on function cibafit."set_nutrition_available"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.complete_oauth_signup(p_payload jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _uid uuid := auth.uid();
  _profile cibafit.profiles%ROWTYPE;
  _role text;
  _full_name text;
  _phone text;
  _ref_code text;
  _coupon_record record;
  _restaurant_id uuid;
  _slug text;
  _base_slug text;
  _counter int := 0;
BEGIN
  IF _uid IS NULL THEN
    RAISE EXCEPTION 'complete_oauth_signup richiede una sessione attiva'
      USING ERRCODE = '28000';
  END IF;

  SELECT * INTO _profile FROM cibafit.profiles WHERE id = _uid;
  IF NOT FOUND THEN
    RETURN jsonb_build_object('applied', false, 'reason', 'no_profile');
  END IF;

  IF _profile.role <> 'user' THEN
    RETURN jsonb_build_object('applied', false, 'reason', 'role_already_set', 'role', _profile.role);
  END IF;

  IF _profile.created_at < now() - interval '1 hour' THEN
    RETURN jsonb_build_object('applied', false, 'reason', 'not_a_new_account', 'role', _profile.role);
  END IF;

  _role := COALESCE(p_payload->>'role', 'user');
  IF _role NOT IN ('user', 'restaurant_owner', 'professional') THEN
    _role := 'user';
  END IF;

  _full_name := NULLIF(TRIM(COALESCE(p_payload->>'full_name', '')), '');
  _phone := NULLIF(TRIM(COALESCE(p_payload->>'phone', p_payload->>'restaurant_phone', '')), '');
  _ref_code := NULLIF(TRIM(COALESCE(p_payload->>'ref_coupon_code', '')), '');

  UPDATE cibafit.profiles
  SET role = _role,
      full_name = COALESCE(NULLIF(full_name, ''), _full_name, ''),
      phone = COALESCE(NULLIF(phone, ''), _phone),
      ref_coupon_code = COALESCE(ref_coupon_code, _ref_code)
  WHERE id = _uid;

  IF _role = 'professional'
     AND NOT EXISTS (SELECT 1 FROM cibafit.professional_profiles WHERE user_id = _uid) THEN
    _base_slug := LOWER(REGEXP_REPLACE(
      COALESCE(NULLIF(p_payload->>'display_name', ''), _full_name, NULLIF(_profile.full_name, ''), 'pro'),
      '[^a-zA-Z0-9]+', '-', 'g'
    ));
    _base_slug := TRIM(BOTH '-' FROM _base_slug);
    IF _base_slug = '' THEN _base_slug := 'pro'; END IF;

    _slug := _base_slug;
    LOOP
      EXIT WHEN NOT EXISTS (SELECT 1 FROM cibafit.professional_profiles WHERE public_slug = _slug);
      _counter := _counter + 1;
      _slug := _base_slug || '-' || _counter;
    END LOOP;

    INSERT INTO cibafit.professional_profiles (user_id, display_name, specialization, city, bio, public_slug)
    VALUES (
      _uid,
      COALESCE(NULLIF(p_payload->>'display_name', ''), _full_name, NULLIF(_profile.full_name, ''), ''),
      COALESCE(p_payload->>'specialization', ''),
      NULLIF(p_payload->>'city', ''),
      NULLIF(p_payload->>'bio', ''),
      _slug
    );
  END IF;

  IF _role = 'restaurant_owner'
     AND NOT EXISTS (SELECT 1 FROM cibafit.restaurants WHERE owner_id = _uid) THEN
    INSERT INTO cibafit.restaurants (name, phone, address, owner_id)
    VALUES (
      COALESCE(NULLIF(p_payload->>'restaurant_name', ''), 'Il mio ristorante'),
      COALESCE(NULLIF(p_payload->>'restaurant_phone', ''), _phone, ''),
      NULLIF(p_payload->>'restaurant_address', ''),
      _uid
    )
    RETURNING id INTO _restaurant_id;

    INSERT INTO cibafit.restaurant_members (restaurant_id, user_id, member_role)
    VALUES (_restaurant_id, _uid, 'owner')
    ON CONFLICT DO NOTHING;
  END IF;

  IF _ref_code IS NOT NULL THEN
    SELECT * INTO _coupon_record FROM cibafit.nutritionist_coupons
    WHERE coupon_code = _ref_code AND is_active = true
    LIMIT 1;

    IF FOUND AND _coupon_record.nutritionist_user_id <> _uid THEN
      INSERT INTO cibafit.user_nutritionist_links (client_user_id, nutritionist_user_id, coupon_id, link_source, is_active)
      VALUES (_uid, _coupon_record.nutritionist_user_id, _coupon_record.id, 'referral_link', true)
      ON CONFLICT (client_user_id, nutritionist_user_id) DO NOTHING;
    END IF;
  END IF;

  RETURN jsonb_build_object('applied', true, 'role', _role);
END;
$function$;
revoke all on function cibafit."complete_oauth_signup"(p_payload jsonb) from public;
grant execute on function cibafit."complete_oauth_signup"(p_payload jsonb) to authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_client_link_status()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.status NOT IN ('pending', 'active', 'revoked') THEN
    RAISE EXCEPTION 'Invalid client_link status: %', NEW.status;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_client_link_status"() from public;
grant execute on function cibafit."validate_client_link_status"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_meal(_meal_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.meals m
    JOIN cibafit.meal_days md ON md.id = m.meal_day_id
    WHERE m.id = _meal_id AND md.user_id = auth.uid()
  );
$function$;
revoke all on function cibafit."owns_meal"(_meal_id uuid) from public;
grant execute on function cibafit."owns_meal"(_meal_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.merge_restaurant_products(p_restaurant_id uuid, p_target_product uuid, p_source_product uuid)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  v_target_name text;
  v_lots        integer;
  v_movements   integer;
  v_deleted     boolean := false;
BEGIN
  IF p_target_product = p_source_product THEN
    RAISE EXCEPTION 'Il prodotto di origine e quello di destinazione coincidono';
  END IF;

  IF NOT cibafit.is_restaurant_accessible(p_restaurant_id) THEN
    RAISE EXCEPTION 'Nessun accesso a questo ristorante';
  END IF;

  SELECT name INTO v_target_name FROM cibafit.products WHERE id = p_target_product;
  IF v_target_name IS NULL THEN
    RAISE EXCEPTION 'Prodotto di destinazione inesistente';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM cibafit.products WHERE id = p_source_product) THEN
    RAISE EXCEPTION 'Prodotto di origine inesistente';
  END IF;

  UPDATE cibafit.inventory_items
     SET product_id = p_target_product
   WHERE restaurant_id = p_restaurant_id
     AND product_id = p_source_product;
  GET DIAGNOSTICS v_lots = ROW_COUNT;

  UPDATE cibafit.inventory_movements
     SET product_id = p_target_product,
         product_name = v_target_name
   WHERE restaurant_id = p_restaurant_id
     AND product_id = p_source_product;
  GET DIAGNOSTICS v_movements = ROW_COUNT;

  IF NOT EXISTS (SELECT 1 FROM cibafit.inventory_items       WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.inventory_movements   WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.meal_items            WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.preparation_ingredients WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.recipe_ingredients    WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.supplier_products     WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.user_product_favorites WHERE product_id = p_source_product)
 AND NOT EXISTS (SELECT 1 FROM cibafit.product_usage_log     WHERE product_id = p_source_product)
  THEN
    DELETE FROM cibafit.products WHERE id = p_source_product;
    v_deleted := true;
  END IF;

  RETURN jsonb_build_object(
    'lots_moved', v_lots,
    'movements_moved', v_movements,
    'source_deleted', v_deleted,
    'target_name', v_target_name
  );
END;
$function$;
revoke all on function cibafit."merge_restaurant_products"(p_restaurant_id uuid, p_target_product uuid, p_source_product uuid) from public;
grant execute on function cibafit."merge_restaurant_products"(p_restaurant_id uuid, p_target_product uuid, p_source_product uuid) to anon, authenticated, service_role;
CREATE OR REPLACE FUNCTION cibafit.has_active_client_link(_pro_id uuid, _client_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.client_links
    WHERE professional_id = _pro_id AND client_user_id = _client_id AND status = 'active'
  );
$function$;
revoke all on function cibafit."has_active_client_link"(_pro_id uuid, _client_id uuid) from public;
grant execute on function cibafit."has_active_client_link"(_pro_id uuid, _client_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.haccp_log_registration_rules()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
DECLARE
  _today date := (now() AT TIME ZONE 'Europe/Rome')::date;
BEGIN
  IF TG_OP = 'INSERT' THEN
    NEW.completed_at := now();
    NEW.created_at := now();
    IF NEW.log_date > _today THEN
      RAISE EXCEPTION 'Non si puo'' registrare un controllo per un giorno futuro (%)', NEW.log_date;
    END IF;
    IF NEW.status = 'completata' AND NEW.log_date < _today THEN
      NEW.status := 'in_ritardo';
    END IF;
    RETURN NEW;
  END IF;

  NEW.completed_at := OLD.completed_at;
  NEW.created_at := OLD.created_at;
  NEW.log_date := OLD.log_date;
  IF NEW.status IS DISTINCT FROM OLD.status
     AND NEW.status <> 'annullata'
     AND NOT cibafit.current_user_is_admin() THEN
    RAISE EXCEPTION 'Lo stato di un controllo HACCP si puo'' solo annullare';
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."haccp_log_registration_rules"() from public;
grant execute on function cibafit."haccp_log_registration_rules"() to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.owns_recipe_restaurant(_recipe_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'cibafit'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM cibafit.recipes r
    JOIN cibafit.restaurants rest ON rest.id = r.restaurant_id
    WHERE r.id = _recipe_id AND rest.owner_id = auth.uid()
  );
$function$;
revoke all on function cibafit."owns_recipe_restaurant"(_recipe_id uuid) from public;
grant execute on function cibafit."owns_recipe_restaurant"(_recipe_id uuid) to anon, authenticated, public, service_role;
CREATE OR REPLACE FUNCTION cibafit.validate_haccp_frequency()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'cibafit'
AS $function$
BEGIN
  IF NEW.frequency NOT IN ('giornaliera', 'settimanale', 'mensile', 'personalizzata') THEN
    RAISE EXCEPTION 'Invalid frequency: %', NEW.frequency;
  END IF;
  RETURN NEW;
END;
$function$;
revoke all on function cibafit."validate_haccp_frequency"() from public;
grant execute on function cibafit."validate_haccp_frequency"() to anon, authenticated, public, service_role;

-- 3. Cataloghi di riferimento (senza proprietario)
insert into cibafit."allergens" select * from public."allergens";
insert into cibafit."subscription_plans" select * from public."subscription_plans";
insert into cibafit."ingredient_categories" select * from public."ingredient_categories";
insert into cibafit."ingredients" select * from public."ingredients";
insert into cibafit."ingredient_translation" select * from public."ingredient_translation";
insert into cibafit."ingredient_compatibility_matrix" select * from public."ingredient_compatibility_matrix";
insert into cibafit."food_templates" select * from public."food_templates";
insert into cibafit."haccp_templates" select * from public."haccp_templates";
insert into cibafit."haccp_template_tasks" select * from public."haccp_template_tasks";

-- 4. Chiavi esterne
alter table cibafit."restaurant_invites" add constraint "restaurant_invites_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."restaurants" add constraint "restaurants_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."restaurant_members" add constraint "restaurant_members_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."restaurant_members" add constraint "restaurant_members_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."inventory_items" add constraint "inventory_items_owner_user_id_fkey" FOREIGN KEY (owner_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."inventory_items" add constraint "inventory_items_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."inventory_items" add constraint "inventory_items_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE CASCADE;
alter table cibafit."attachments" add constraint "attachments_owner_user_id_fkey" FOREIGN KEY (owner_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."attachments" add constraint "attachments_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."nutrition_targets" add constraint "nutrition_targets_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."meal_days" add constraint "meal_days_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."meals" add constraint "meals_meal_day_id_fkey" FOREIGN KEY (meal_day_id) REFERENCES cibafit.meal_days(id) ON DELETE CASCADE;
alter table cibafit."meal_items" add constraint "meal_items_meal_id_fkey" FOREIGN KEY (meal_id) REFERENCES cibafit.meals(id) ON DELETE CASCADE;
alter table cibafit."meal_items" add constraint "meal_items_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id);
alter table cibafit."meal_items" add constraint "meal_items_inventory_item_id_fkey" FOREIGN KEY (inventory_item_id) REFERENCES cibafit.inventory_items(id);
alter table cibafit."restaurant_invites" add constraint "restaurant_invites_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."client_links" add constraint "client_links_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."client_links" add constraint "client_links_client_user_id_fkey" FOREIGN KEY (client_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."professional_invites" add constraint "professional_invites_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."professional_notes" add constraint "professional_notes_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."professional_notes" add constraint "professional_notes_client_user_id_fkey" FOREIGN KEY (client_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."suppliers" add constraint "suppliers_owner_user_id_fkey" FOREIGN KEY (owner_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."supplier_invites" add constraint "supplier_invites_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES cibafit.suppliers(id) ON DELETE CASCADE;
alter table cibafit."supplier_restaurants" add constraint "supplier_restaurants_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES cibafit.suppliers(id) ON DELETE CASCADE;
alter table cibafit."supplier_restaurants" add constraint "supplier_restaurants_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."supplier_products" add constraint "supplier_products_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES cibafit.suppliers(id) ON DELETE CASCADE;
alter table cibafit."supplier_products" add constraint "supplier_products_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE CASCADE;
alter table cibafit."supplier_orders" add constraint "supplier_orders_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES cibafit.suppliers(id) ON DELETE SET NULL;
alter table cibafit."supplier_orders" add constraint "supplier_orders_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE SET NULL;
alter table cibafit."recipes" add constraint "recipes_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."recipe_ingredients" add constraint "recipe_ingredients_recipe_id_fkey" FOREIGN KEY (recipe_id) REFERENCES cibafit.recipes(id) ON DELETE CASCADE;
alter table cibafit."recipe_ingredients" add constraint "recipe_ingredients_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id);
alter table cibafit."recipe_allergens" add constraint "recipe_allergens_recipe_id_fkey" FOREIGN KEY (recipe_id) REFERENCES cibafit.recipes(id) ON DELETE CASCADE;
alter table cibafit."recipe_allergens" add constraint "recipe_allergens_allergen_id_fkey" FOREIGN KEY (allergen_id) REFERENCES cibafit.allergens(id);
alter table cibafit."restaurant_documents" add constraint "restaurant_documents_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."preparations" add constraint "preparations_owner_user_id_fkey" FOREIGN KEY (owner_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."preparations" add constraint "preparations_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."preparation_ingredients" add constraint "preparation_ingredients_preparation_id_fkey" FOREIGN KEY (preparation_id) REFERENCES cibafit.preparations(id) ON DELETE CASCADE;
alter table cibafit."preparation_ingredients" add constraint "preparation_ingredients_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id);
alter table cibafit."preparation_allergens" add constraint "preparation_allergens_preparation_id_fkey" FOREIGN KEY (preparation_id) REFERENCES cibafit.preparations(id) ON DELETE CASCADE;
alter table cibafit."preparation_allergens" add constraint "preparation_allergens_allergen_id_fkey" FOREIGN KEY (allergen_id) REFERENCES cibafit.allergens(id);
alter table cibafit."diet_plan_meal_targets" add constraint "diet_plan_meal_targets_diet_plan_id_fkey" FOREIGN KEY (diet_plan_id) REFERENCES cibafit.diet_plans(id) ON DELETE CASCADE;
alter table cibafit."products" add constraint "products_template_id_fkey" FOREIGN KEY (template_id) REFERENCES cibafit.food_templates(id);
alter table cibafit."diet_plan_template_meals" add constraint "diet_plan_template_meals_template_id_fkey" FOREIGN KEY (template_id) REFERENCES cibafit.diet_plan_templates(id) ON DELETE CASCADE;
alter table cibafit."support_requests" add constraint "support_requests_user_id_fkey" FOREIGN KEY (user_id) REFERENCES cibafit.profiles(id) ON DELETE CASCADE;
alter table cibafit."diet_plan_items" add constraint "diet_plan_items_diet_plan_id_fkey" FOREIGN KEY (diet_plan_id) REFERENCES cibafit.diet_plans(id) ON DELETE CASCADE;
alter table cibafit."nutrition_plans" add constraint "nutrition_plans_nutritionist_user_id_fkey" FOREIGN KEY (nutritionist_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."nutrition_plans" add constraint "nutrition_plans_client_user_id_fkey" FOREIGN KEY (client_user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."nutrition_plan_weeks" add constraint "nutrition_plan_weeks_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES cibafit.nutrition_plans(id) ON DELETE CASCADE;
alter table cibafit."dish_ingredients" add constraint "dish_ingredients_dish_id_fkey" FOREIGN KEY (dish_id) REFERENCES cibafit.dishes(id) ON DELETE CASCADE;
alter table cibafit."dish_ingredients" add constraint "dish_ingredients_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES cibafit.food_templates(id) ON DELETE CASCADE;
alter table cibafit."meal_log_ingredients" add constraint "meal_log_ingredients_meal_log_id_fkey" FOREIGN KEY (meal_log_id) REFERENCES cibafit.meal_logs(id) ON DELETE CASCADE;
alter table cibafit."meal_log_ingredients" add constraint "meal_log_ingredients_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES cibafit.ingredients(id);
alter table cibafit."daily_progress" add constraint "daily_progress_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES cibafit.diet_plans(id) ON DELETE SET NULL;
alter table cibafit."user_nutritionist_links" add constraint "user_nutritionist_links_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES cibafit.nutritionist_coupons(id);
alter table cibafit."subscription_payments" add constraint "subscription_payments_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES cibafit.nutritionist_coupons(id);
alter table cibafit."nutritionist_commissions" add constraint "nutritionist_commissions_payment_id_fkey" FOREIGN KEY (payment_id) REFERENCES cibafit.subscription_payments(id);
alter table cibafit."nutritionist_commissions" add constraint "nutritionist_commissions_coupon_id_fkey" FOREIGN KEY (coupon_id) REFERENCES cibafit.nutritionist_coupons(id);
alter table cibafit."meal_reminder_settings" add constraint "meal_reminder_settings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."user_favorite_meals" add constraint "user_favorite_meals_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."favorite_meal_items" add constraint "favorite_meal_items_favorite_meal_id_fkey" FOREIGN KEY (favorite_meal_id) REFERENCES cibafit.user_favorite_meals(id) ON DELETE CASCADE;
alter table cibafit."favorite_meal_items" add constraint "favorite_meal_items_ingredient_id_fkey" FOREIGN KEY (ingredient_id) REFERENCES cibafit.ingredients(id);
alter table cibafit."quick_day_logs" add constraint "quick_day_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."waste_savings" add constraint "waste_savings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."restaurant_invites" add constraint "restaurant_invites_used_by_fkey" FOREIGN KEY (used_by) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."email_notifications_log" add constraint "email_notifications_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."email_preferences" add constraint "email_preferences_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."haccp_tasks" add constraint "haccp_tasks_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_logs" add constraint "haccp_logs_task_id_fkey" FOREIGN KEY (task_id) REFERENCES cibafit.haccp_tasks(id) ON DELETE CASCADE;
alter table cibafit."haccp_logs" add constraint "haccp_logs_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_equipment" add constraint "haccp_equipment_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_logs" add constraint "haccp_logs_original_log_id_fkey" FOREIGN KEY (original_log_id) REFERENCES cibafit.haccp_logs(id);
alter table cibafit."haccp_template_tasks" add constraint "haccp_template_tasks_template_id_fkey" FOREIGN KEY (template_id) REFERENCES cibafit.haccp_templates(id) ON DELETE CASCADE;
alter table cibafit."restaurants" add constraint "restaurants_haccp_template_id_fkey" FOREIGN KEY (haccp_template_id) REFERENCES cibafit.haccp_templates(id);
alter table cibafit."nutrition_plan_days" add constraint "nutrition_plan_days_week_id_fkey" FOREIGN KEY (week_id) REFERENCES cibafit.nutrition_plan_weeks(id) ON DELETE CASCADE;
alter table cibafit."nutrition_plan_meals" add constraint "nutrition_plan_meals_day_id_fkey" FOREIGN KEY (day_id) REFERENCES cibafit.nutrition_plan_days(id) ON DELETE CASCADE;
alter table cibafit."subscriptions" add constraint "subscriptions_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."haccp_task_photos" add constraint "haccp_task_photos_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_task_photos" add constraint "haccp_task_photos_task_log_id_fkey" FOREIGN KEY (task_log_id) REFERENCES cibafit.haccp_logs(id) ON DELETE CASCADE;
alter table cibafit."haccp_temperature_logs" add constraint "haccp_temperature_logs_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_temperature_logs" add constraint "haccp_temperature_logs_task_log_id_fkey" FOREIGN KEY (task_log_id) REFERENCES cibafit.haccp_logs(id) ON DELETE CASCADE;
alter table cibafit."subscriptions" add constraint "subscriptions_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES cibafit.subscription_plans(id);
alter table cibafit."stripe_payments" add constraint "stripe_payments_subscription_id_fkey" FOREIGN KEY (subscription_id) REFERENCES cibafit.subscriptions(id);
alter table cibafit."custom_coupons" add constraint "custom_coupons_applies_to_plan_id_fkey" FOREIGN KEY (applies_to_plan_id) REFERENCES cibafit.subscription_plans(id);
alter table cibafit."weight_goals" add constraint "weight_goals_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."custom_coupons" add constraint "custom_coupons_assigned_to_user_id_fkey" FOREIGN KEY (assigned_to_user_id) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."pro_meal_text_suggestions" add constraint "pro_meal_text_suggestions_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."professional_link_requests" add constraint "professional_link_requests_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."professional_link_requests" add constraint "professional_link_requests_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."in_app_notifications" add constraint "in_app_notifications_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."ai_usage_log" add constraint "ai_usage_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."inventory_item_photos" add constraint "inventory_item_photos_uploaded_by_fkey" FOREIGN KEY (uploaded_by) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."inventory_item_allergens" add constraint "inventory_item_allergens_inventory_item_id_fkey" FOREIGN KEY (inventory_item_id) REFERENCES cibafit.inventory_items(id) ON DELETE CASCADE;
alter table cibafit."inventory_item_allergens" add constraint "inventory_item_allergens_allergen_id_fkey" FOREIGN KEY (allergen_id) REFERENCES cibafit.allergens(id) ON DELETE CASCADE;
alter table cibafit."user_product_favorites" add constraint "user_product_favorites_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."user_product_favorites" add constraint "user_product_favorites_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE CASCADE;
alter table cibafit."product_usage_log" add constraint "product_usage_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
alter table cibafit."product_usage_log" add constraint "product_usage_log_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE CASCADE;
alter table cibafit."haccp_preparation_labels" add constraint "haccp_preparation_labels_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_preparation_ingredients" add constraint "haccp_preparation_ingredients_preparation_label_id_fkey" FOREIGN KEY (preparation_label_id) REFERENCES cibafit.haccp_preparation_labels(id) ON DELETE CASCADE;
alter table cibafit."haccp_documents" add constraint "haccp_documents_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."haccp_preparation_documents" add constraint "haccp_preparation_documents_preparation_label_id_fkey" FOREIGN KEY (preparation_label_id) REFERENCES cibafit.haccp_preparation_labels(id) ON DELETE CASCADE;
alter table cibafit."haccp_preparation_documents" add constraint "haccp_preparation_documents_document_id_fkey" FOREIGN KEY (document_id) REFERENCES cibafit.haccp_documents(id) ON DELETE CASCADE;
alter table cibafit."haccp_label_audit_log" add constraint "haccp_label_audit_log_preparation_label_id_fkey" FOREIGN KEY (preparation_label_id) REFERENCES cibafit.haccp_preparation_labels(id) ON DELETE CASCADE;
alter table cibafit."haccp_preparation_labels" add constraint "haccp_preparation_labels_source_preparation_id_fkey" FOREIGN KEY (source_preparation_id) REFERENCES cibafit.preparations(id) ON DELETE SET NULL;
alter table cibafit."inventory_items" add constraint "inventory_items_source_document_id_fkey" FOREIGN KEY (source_document_id) REFERENCES cibafit.haccp_documents(id) ON DELETE SET NULL;
alter table cibafit."inventory_movements" add constraint "inventory_movements_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."inventory_movements" add constraint "inventory_movements_inventory_item_id_fkey" FOREIGN KEY (inventory_item_id) REFERENCES cibafit.inventory_items(id) ON DELETE SET NULL;
alter table cibafit."inventory_movements" add constraint "inventory_movements_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE SET NULL;
alter table cibafit."inventory_movements" add constraint "inventory_movements_source_document_id_fkey" FOREIGN KEY (source_document_id) REFERENCES cibafit.haccp_documents(id) ON DELETE SET NULL;
alter table cibafit."integration_runs" add constraint "integration_runs_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."integration_idempotency" add constraint "integration_idempotency_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."integration_idempotency" add constraint "integration_idempotency_run_id_fkey" FOREIGN KEY (run_id) REFERENCES cibafit.integration_runs(id) ON DELETE SET NULL;
alter table cibafit."restaurant_api_keys" add constraint "restaurant_api_keys_restaurant_id_fkey" FOREIGN KEY (restaurant_id) REFERENCES cibafit.restaurants(id) ON DELETE CASCADE;
alter table cibafit."restaurant_api_keys" add constraint "restaurant_api_keys_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."supplier_orders" add constraint "supplier_orders_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL;
alter table cibafit."supplier_order_items" add constraint "supplier_order_items_order_id_fkey" FOREIGN KEY (order_id) REFERENCES cibafit.supplier_orders(id) ON DELETE CASCADE;
alter table cibafit."supplier_order_items" add constraint "supplier_order_items_supplier_product_id_fkey" FOREIGN KEY (supplier_product_id) REFERENCES cibafit.supplier_products(id) ON DELETE SET NULL;
alter table cibafit."supplier_order_items" add constraint "supplier_order_items_product_id_fkey" FOREIGN KEY (product_id) REFERENCES cibafit.products(id) ON DELETE SET NULL;

-- 5. Trigger
CREATE TRIGGER validate_profile_role_trigger BEFORE INSERT OR UPDATE ON cibafit.profiles FOR EACH ROW EXECUTE FUNCTION cibafit.validate_profile_role();
CREATE TRIGGER validate_member_role_trigger BEFORE INSERT OR UPDATE ON cibafit.restaurant_members FOR EACH ROW EXECUTE FUNCTION cibafit.validate_member_role();
CREATE TRIGGER validate_storage_type_trigger BEFORE INSERT OR UPDATE ON cibafit.inventory_items FOR EACH ROW EXECUTE FUNCTION cibafit.validate_storage_type();
CREATE TRIGGER validate_inventory_owner_trigger BEFORE INSERT OR UPDATE ON cibafit.inventory_items FOR EACH ROW EXECUTE FUNCTION cibafit.validate_inventory_owner();
CREATE TRIGGER validate_attachment_entity_type_trigger BEFORE INSERT OR UPDATE ON cibafit.attachments FOR EACH ROW EXECUTE FUNCTION cibafit.validate_attachment_entity_type();
CREATE TRIGGER validate_meal_type_trigger BEFORE INSERT OR UPDATE ON cibafit.meals FOR EACH ROW EXECUTE FUNCTION cibafit.validate_meal_type();
CREATE TRIGGER validate_meal_item_source_trigger BEFORE INSERT OR UPDATE ON cibafit.meal_items FOR EACH ROW EXECUTE FUNCTION cibafit.validate_meal_item_source();
CREATE TRIGGER trg_validate_client_link_status BEFORE INSERT OR UPDATE ON cibafit.client_links FOR EACH ROW EXECUTE FUNCTION cibafit.validate_client_link_status();
CREATE TRIGGER trg_validate_invite_status BEFORE INSERT OR UPDATE ON cibafit.professional_invites FOR EACH ROW EXECUTE FUNCTION cibafit.validate_invite_status();
CREATE TRIGGER trg_validate_supplier_invite_status BEFORE INSERT OR UPDATE ON cibafit.supplier_invites FOR EACH ROW EXECUTE FUNCTION cibafit.validate_supplier_invite_status();
CREATE TRIGGER trg_validate_supplier_restaurant_status BEFORE INSERT OR UPDATE ON cibafit.supplier_restaurants FOR EACH ROW EXECUTE FUNCTION cibafit.validate_supplier_restaurant_status();
CREATE TRIGGER trg_validate_doc_type BEFORE INSERT OR UPDATE ON cibafit.restaurant_documents FOR EACH ROW EXECUTE FUNCTION cibafit.validate_doc_type();
CREATE TRIGGER trg_validate_preparation_owner BEFORE INSERT OR UPDATE ON cibafit.preparations FOR EACH ROW EXECUTE FUNCTION cibafit.validate_preparation_owner();
CREATE TRIGGER trg_validate_preparation_storage BEFORE INSERT OR UPDATE ON cibafit.preparations FOR EACH ROW EXECUTE FUNCTION cibafit.validate_preparation_storage();
CREATE TRIGGER trg_validate_appointment_status BEFORE INSERT OR UPDATE ON cibafit.appointments FOR EACH ROW EXECUTE FUNCTION cibafit.validate_appointment_status();
CREATE TRIGGER trg_validate_submission_status BEFORE INSERT OR UPDATE ON cibafit.product_submissions FOR EACH ROW EXECUTE FUNCTION cibafit.validate_submission_status();
CREATE TRIGGER trg_validate_support_request BEFORE INSERT OR UPDATE ON cibafit.support_requests FOR EACH ROW EXECUTE FUNCTION cibafit.validate_support_request_type();
CREATE TRIGGER trg_validate_diet_plan_item_meal_type BEFORE INSERT OR UPDATE ON cibafit.diet_plan_items FOR EACH ROW EXECUTE FUNCTION cibafit.validate_diet_plan_item_meal_type();
CREATE TRIGGER trg_validate_meal_log_type BEFORE INSERT OR UPDATE ON cibafit.meal_logs FOR EACH ROW EXECUTE FUNCTION cibafit.validate_meal_log_type();
CREATE TRIGGER trg_validate_template_recipe BEFORE INSERT OR UPDATE ON cibafit.template_recipes FOR EACH ROW EXECUTE FUNCTION cibafit.validate_template_recipe_meal_type();
CREATE TRIGGER trg_validate_payment_status BEFORE INSERT OR UPDATE ON cibafit.subscription_payments FOR EACH ROW EXECUTE FUNCTION cibafit.validate_payment_status();
CREATE TRIGGER trg_validate_commission_status BEFORE INSERT OR UPDATE ON cibafit.nutritionist_commissions FOR EACH ROW EXECUTE FUNCTION cibafit.validate_commission_status();
CREATE TRIGGER trg_auto_create_nutritionist_coupon AFTER INSERT ON cibafit.profiles FOR EACH ROW EXECUTE FUNCTION cibafit.auto_create_nutritionist_coupon();
CREATE TRIGGER on_profile_created_email_prefs AFTER INSERT ON cibafit.profiles FOR EACH ROW EXECUTE FUNCTION cibafit.handle_new_email_prefs();
CREATE TRIGGER trg_validate_haccp_frequency BEFORE INSERT OR UPDATE ON cibafit.haccp_tasks FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_frequency();
CREATE TRIGGER trg_validate_haccp_log_status BEFORE INSERT OR UPDATE ON cibafit.haccp_logs FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_log_status();
CREATE TRIGGER trg_validate_haccp_equipment_type BEFORE INSERT OR UPDATE ON cibafit.haccp_equipment FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_equipment_type();
CREATE TRIGGER trg_validate_nutrition_plan_mode BEFORE INSERT OR UPDATE ON cibafit.nutrition_plans FOR EACH ROW EXECUTE FUNCTION cibafit.validate_nutrition_plan_mode();
CREATE TRIGGER trg_validate_np_meal_type BEFORE INSERT OR UPDATE ON cibafit.nutrition_plan_meals FOR EACH ROW EXECUTE FUNCTION cibafit.validate_np_meal_type();
CREATE TRIGGER trg_set_nutrition_available BEFORE INSERT OR UPDATE ON cibafit.products FOR EACH ROW EXECUTE FUNCTION cibafit.set_nutrition_available();
CREATE TRIGGER trg_validate_link_request_status BEFORE INSERT OR UPDATE ON cibafit.professional_link_requests FOR EACH ROW EXECUTE FUNCTION cibafit.validate_link_request_status();
CREATE TRIGGER trg_log_product_usage AFTER INSERT ON cibafit.inventory_items FOR EACH ROW EXECUTE FUNCTION cibafit.log_product_usage();
CREATE TRIGGER trg_validate_haccp_label_status BEFORE INSERT OR UPDATE ON cibafit.haccp_preparation_labels FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_label_status();
CREATE TRIGGER trg_gen_haccp_lot_code BEFORE INSERT ON cibafit.haccp_preparation_labels FOR EACH ROW EXECUTE FUNCTION cibafit.gen_haccp_lot_code();
CREATE TRIGGER trg_protect_finalized_haccp_label BEFORE UPDATE ON cibafit.haccp_preparation_labels FOR EACH ROW EXECUTE FUNCTION cibafit.protect_finalized_haccp_label();
CREATE TRIGGER trg_haccp_label_touch BEFORE UPDATE ON cibafit.haccp_preparation_labels FOR EACH ROW EXECUTE FUNCTION cibafit.touch_updated_at();
CREATE TRIGGER trg_validate_haccp_doc_type BEFORE INSERT OR UPDATE ON cibafit.haccp_documents FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_document_type();
CREATE TRIGGER trg_validate_haccp_audit_action BEFORE INSERT ON cibafit.haccp_label_audit_log FOR EACH ROW EXECUTE FUNCTION cibafit.validate_haccp_audit_action();
CREATE TRIGGER trg_auto_haccp_label_for_prep AFTER INSERT ON cibafit.preparations FOR EACH ROW EXECUTE FUNCTION cibafit.auto_create_haccp_label_for_preparation();
CREATE TRIGGER haccp_temperature_alert AFTER INSERT ON cibafit.haccp_temperature_logs FOR EACH ROW EXECUTE FUNCTION cibafit.notify_haccp_temperature_alert();
CREATE TRIGGER haccp_log_registration_rules BEFORE INSERT OR UPDATE ON cibafit.haccp_logs FOR EACH ROW EXECUTE FUNCTION cibafit.haccp_log_registration_rules();

-- 6. Policy RLS
create policy "Users can view own profile" on cibafit."profiles" as permissive for select to public using ((auth.uid() = id));
create policy "Admins can view all profiles" on cibafit."profiles" as permissive for select to public using (cibafit.is_admin(auth.uid()));
create policy "Admins can update all profiles" on cibafit."profiles" as permissive for update to public using (cibafit.is_admin(auth.uid()));
create policy "Restaurant update by owner or admin" on cibafit."restaurants" as permissive for update to public using (((owner_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Restaurant insert by owner or admin" on cibafit."restaurants" as permissive for insert to public with check (((auth.uid() = owner_id) OR cibafit.current_user_is_admin()));
create policy "Members insert by owner or admin" on cibafit."restaurant_members" as permissive for insert to public with check (((EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = restaurant_members.restaurant_id) AND (r.owner_id = auth.uid())))) OR cibafit.current_user_is_admin()));
create policy "Restaurant member inserts haccp_logs" on cibafit."haccp_logs" as permissive for insert to authenticated with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Restaurant owner manages haccp_logs" on cibafit."haccp_logs" as permissive for all to authenticated using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Admin haccp_logs" on cibafit."haccp_logs" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Admin haccp_equipment" on cibafit."haccp_equipment" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Restaurant member inserts temps" on cibafit."haccp_temperature_logs" as permissive for insert to authenticated with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin temps" on cibafit."haccp_temperature_logs" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Products readable by authenticated" on cibafit."products" as permissive for select to public using ((auth.uid() IS NOT NULL));
create policy "Inventory insert own or restaurant owner or admin" on cibafit."inventory_items" as permissive for insert to public with check (((owner_user_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = inventory_items.restaurant_id) AND (r.owner_id = auth.uid())))) OR cibafit.current_user_is_admin()));
create policy "System inserts links" on cibafit."user_nutritionist_links" as permissive for insert to authenticated with check ((client_user_id = auth.uid()));
create policy "User reads own payments" on cibafit."subscription_payments" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin manages payments" on cibafit."subscription_payments" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User inserts own payments" on cibafit."subscription_payments" as permissive for insert to authenticated with check ((user_id = auth.uid()));
create policy "Nutritionist reads own commissions" on cibafit."nutritionist_commissions" as permissive for select to authenticated using ((nutritionist_user_id = auth.uid()));
create policy "Admin manages commissions" on cibafit."nutritionist_commissions" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users can update own email prefs" on cibafit."email_preferences" as permissive for update to authenticated using ((user_id = auth.uid()));
create policy "Users can insert own email prefs" on cibafit."email_preferences" as permissive for insert to authenticated with check ((user_id = auth.uid()));
create policy "Admin haccp_tasks" on cibafit."haccp_tasks" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Restaurant accessible haccp_logs" on cibafit."haccp_logs" as permissive for select to authenticated using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Products insert by authenticated" on cibafit."products" as permissive for insert to public with check ((auth.uid() IS NOT NULL));
create policy "Attachments insert own or restaurant owner or admin" on cibafit."attachments" as permissive for insert to public with check (((owner_user_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = attachments.restaurant_id) AND (r.owner_id = auth.uid())))) OR cibafit.current_user_is_admin()));
create policy "Users own targets" on cibafit."nutrition_targets" as permissive for all to public using (((user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Users own meal_days" on cibafit."meal_days" as permissive for all to public using (((user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Users own meals" on cibafit."meals" as permissive for all to public using ((cibafit.owns_meal_day(meal_day_id) OR cibafit.current_user_is_admin()));
create policy "Users own meal_items" on cibafit."meal_items" as permissive for all to public using ((cibafit.owns_meal(meal_id) OR cibafit.current_user_is_admin()));
create policy "Pro sees own links" on cibafit."client_links" as permissive for select to public using (((professional_id = auth.uid()) OR (client_user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Pro or client updates link" on cibafit."client_links" as permissive for update to public using (((professional_id = auth.uid()) OR (client_user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Pro manage own invites" on cibafit."professional_invites" as permissive for all to public using (((professional_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Auth users can read active invites" on cibafit."professional_invites" as permissive for select to public using (((auth.uid() IS NOT NULL) AND (status = 'active'::text)));
create policy "Pro manages notes for active clients" on cibafit."professional_notes" as permissive for all to public using ((((professional_id = auth.uid()) AND cibafit.has_active_client_link(auth.uid(), client_user_id)) OR cibafit.current_user_is_admin()));
create policy "Client reads own notes" on cibafit."professional_notes" as permissive for select to public using ((client_user_id = auth.uid()));
create policy "Pro reads client meal_days" on cibafit."meal_days" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = meal_days.user_id) AND (cl.status = 'active'::text)))));
create policy "Pro reads client meals" on cibafit."meals" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM (cibafit.meal_days md
     JOIN cibafit.client_links cl ON ((cl.client_user_id = md.user_id)))
  WHERE ((md.id = meals.meal_day_id) AND (cl.professional_id = auth.uid()) AND (cl.status = 'active'::text)))));
create policy "Pro reads client meal_items" on cibafit."meal_items" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM ((cibafit.meals m
     JOIN cibafit.meal_days md ON ((md.id = m.meal_day_id)))
     JOIN cibafit.client_links cl ON ((cl.client_user_id = md.user_id)))
  WHERE ((m.id = meal_items.meal_id) AND (cl.professional_id = auth.uid()) AND (cl.status = 'active'::text)))));
create policy "Pro reads client targets" on cibafit."nutrition_targets" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = nutrition_targets.user_id) AND (cl.status = 'active'::text)))));
create policy "Pro reads client profiles" on cibafit."profiles" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = profiles.id) AND (cl.status = 'active'::text)))));
create policy "Supplier select own" on cibafit."suppliers" as permissive for select to public using (((owner_user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Supplier insert own" on cibafit."suppliers" as permissive for insert to public with check (((owner_user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Supplier update own" on cibafit."suppliers" as permissive for update to public using (((owner_user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Supplier manages own invites" on cibafit."supplier_invites" as permissive for all to public using ((cibafit.owns_supplier(supplier_id) OR cibafit.current_user_is_admin()));
create policy "Supplier sees own restaurant links" on cibafit."supplier_restaurants" as permissive for select to public using ((cibafit.owns_supplier(supplier_id) OR cibafit.current_user_is_admin()));
create policy "Admin manages allergens" on cibafit."allergens" as permissive for all to public using (cibafit.current_user_is_admin());
create policy "Restaurant owner sees supplier links" on cibafit."supplier_restaurants" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = supplier_restaurants.restaurant_id) AND (r.owner_id = auth.uid())))));
create policy "Supplier manages own catalog" on cibafit."supplier_products" as permissive for all to public using ((cibafit.owns_supplier(supplier_id) OR cibafit.current_user_is_admin()));
create policy "Restaurant reads linked supplier catalog" on cibafit."supplier_products" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM (cibafit.supplier_restaurants sr
     JOIN cibafit.restaurants r ON ((r.id = sr.restaurant_id)))
  WHERE ((sr.supplier_id = supplier_products.supplier_id) AND (sr.status = 'active'::text) AND (r.owner_id = auth.uid())))));
create policy "Owner manages recipe allergens" on cibafit."recipe_allergens" as permissive for all to public using ((cibafit.owns_recipe_restaurant(recipe_id) OR cibafit.current_user_is_admin()));
create policy "Supplier sees own orders" on cibafit."supplier_orders" as permissive for select to public using (((EXISTS ( SELECT 1
   FROM cibafit.suppliers s
  WHERE ((s.id = supplier_orders.supplier_id) AND (s.owner_user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = supplier_orders.restaurant_id) AND (r.owner_id = auth.uid())))) OR cibafit.current_user_is_admin()));
create policy "Anyone reads public recipes" on cibafit."recipes" as permissive for select to public using (((is_public = true) AND (auth.uid() IS NOT NULL)));
create policy "Owner manages recipe ingredients" on cibafit."recipe_ingredients" as permissive for all to public using ((cibafit.owns_recipe_restaurant(recipe_id) OR cibafit.current_user_is_admin()));
create policy "Read public recipe ingredients" on cibafit."recipe_ingredients" as permissive for select to public using (((EXISTS ( SELECT 1
   FROM cibafit.recipes r
  WHERE ((r.id = recipe_ingredients.recipe_id) AND (r.is_public = true)))) AND (auth.uid() IS NOT NULL)));
create policy "Anyone reads allergens" on cibafit."allergens" as permissive for select to public using (true);
create policy "Read public recipe allergens" on cibafit."recipe_allergens" as permissive for select to public using (((EXISTS ( SELECT 1
   FROM cibafit.recipes r
  WHERE ((r.id = recipe_allergens.recipe_id) AND (r.is_public = true)))) AND (auth.uid() IS NOT NULL)));
create policy "Authenticated can read restaurants" on cibafit."restaurants" as permissive for select to public using ((auth.uid() IS NOT NULL));
create policy "Members visible to self, owner, admin" on cibafit."restaurant_members" as permissive for select to public using (((user_id = auth.uid()) OR cibafit.is_restaurant_owner(restaurant_id)));
create policy "Members update by owner or admin" on cibafit."restaurant_members" as permissive for update to public using (cibafit.is_restaurant_owner(restaurant_id));
create policy "Members delete by owner or admin" on cibafit."restaurant_members" as permissive for delete to public using (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner manages recipes" on cibafit."recipes" as permissive for all to public using (cibafit.is_restaurant_owner(restaurant_id));
create policy "Inventory select own or restaurant member or admin" on cibafit."inventory_items" as permissive for select to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_accessible(restaurant_id)));
create policy "Inventory update own or restaurant owner or admin" on cibafit."inventory_items" as permissive for update to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(restaurant_id)));
create policy "Admin generated_recipes" on cibafit."generated_recipes" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro reads client inventory" on cibafit."inventory_items" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = inventory_items.owner_user_id) AND (cl.status = 'active'::text)))));
create policy "Inventory delete own or restaurant owner or admin" on cibafit."inventory_items" as permissive for delete to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(restaurant_id)));
create policy "Attachments select own or restaurant or admin" on cibafit."attachments" as permissive for select to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_accessible(restaurant_id)));
create policy "Attachments update own or restaurant owner or admin" on cibafit."attachments" as permissive for update to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(restaurant_id)));
create policy "Attachments delete own or restaurant owner or admin" on cibafit."attachments" as permissive for delete to public using (((owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(restaurant_id)));
create policy "Restaurant owner full access" on cibafit."restaurant_documents" as permissive for all to public using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant members can read" on cibafit."restaurant_documents" as permissive for select to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin full access on restaurant_documents" on cibafit."restaurant_documents" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User CRUD own preparations" on cibafit."preparations" as permissive for all to public using ((owner_user_id = auth.uid())) with check ((owner_user_id = auth.uid()));
create policy "Restaurant owner CRUD preparations" on cibafit."preparations" as permissive for all to public using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant members read preparations" on cibafit."preparations" as permissive for select to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin full access preparations" on cibafit."preparations" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "food_templates_admin_all" on cibafit."food_templates" as permissive for all to public using (cibafit.current_user_is_admin());
create policy "Ingredients follow preparation access" on cibafit."preparation_ingredients" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.preparations p
  WHERE ((p.id = preparation_ingredients.preparation_id) AND ((p.owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(p.restaurant_id) OR cibafit.is_restaurant_accessible(p.restaurant_id) OR cibafit.current_user_is_admin()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.preparations p
  WHERE ((p.id = preparation_ingredients.preparation_id) AND ((p.owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(p.restaurant_id) OR cibafit.current_user_is_admin())))));
create policy "Allergens follow preparation access" on cibafit."preparation_allergens" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.preparations p
  WHERE ((p.id = preparation_allergens.preparation_id) AND ((p.owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(p.restaurant_id) OR cibafit.is_restaurant_accessible(p.restaurant_id) OR cibafit.current_user_is_admin()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.preparations p
  WHERE ((p.id = preparation_allergens.preparation_id) AND ((p.owner_user_id = auth.uid()) OR cibafit.is_restaurant_owner(p.restaurant_id) OR cibafit.current_user_is_admin())))));
create policy "Pro manages diet_plans" on cibafit."diet_plans" as permissive for all to public using (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id))) with check (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id)));
create policy "Client reads own diet_plans" on cibafit."diet_plans" as permissive for select to public using ((client_user_id = auth.uid()));
create policy "Admin diet_plans" on cibafit."diet_plans" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro manages meal_targets" on cibafit."diet_plan_meal_targets" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_meal_targets.diet_plan_id) AND (dp.professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), dp.client_user_id))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_meal_targets.diet_plan_id) AND (dp.professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), dp.client_user_id)))));
create policy "Client reads own meal_targets" on cibafit."diet_plan_meal_targets" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_meal_targets.diet_plan_id) AND (dp.client_user_id = auth.uid())))));
create policy "Admin meal_targets" on cibafit."diet_plan_meal_targets" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro manages suggestions" on cibafit."pro_suggestions" as permissive for all to public using (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id))) with check (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id)));
create policy "Client reads own suggestions" on cibafit."pro_suggestions" as permissive for select to public using ((client_user_id = auth.uid()));
create policy "Client updates own suggestions" on cibafit."pro_suggestions" as permissive for update to public using ((client_user_id = auth.uid()));
create policy "Admin suggestions" on cibafit."pro_suggestions" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro manages generated_recipes" on cibafit."generated_recipes" as permissive for all to public using (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id))) with check (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id)));
create policy "Client reads own generated_recipes" on cibafit."generated_recipes" as permissive for select to public using ((client_user_id = auth.uid()));
create policy "food_templates_read" on cibafit."food_templates" as permissive for select to authenticated using (true);
create policy "Pro manages own professional_profile" on cibafit."professional_profiles" as permissive for all to public using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Admin manages professional_profiles" on cibafit."professional_profiles" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Client reads linked pro profile" on cibafit."professional_profiles" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = professional_profiles.user_id) AND (cl.client_user_id = auth.uid()) AND (cl.status = 'active'::text)))));
create policy "Pro manages own templates" on cibafit."diet_plan_templates" as permissive for all to public using ((professional_id = auth.uid())) with check ((professional_id = auth.uid()));
create policy "Admin templates" on cibafit."diet_plan_templates" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Template meals follow template access" on cibafit."diet_plan_template_meals" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plan_templates t
  WHERE ((t.id = diet_plan_template_meals.template_id) AND (t.professional_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plan_templates t
  WHERE ((t.id = diet_plan_template_meals.template_id) AND (t.professional_id = auth.uid())))));
create policy "Admin template meals" on cibafit."diet_plan_template_meals" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Messages update read" on cibafit."messages" as permissive for update to authenticated using ((receiver_id = auth.uid())) with check ((receiver_id = auth.uid()));
create policy "Messages admin" on cibafit."messages" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro manages appointments" on cibafit."appointments" as permissive for all to authenticated using (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id))) with check (((professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), client_user_id)));
create policy "Client reads appointments" on cibafit."appointments" as permissive for select to authenticated using ((client_user_id = auth.uid()));
create policy "Admin appointments" on cibafit."appointments" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User manages own measurements" on cibafit."body_measurements" as permissive for all to public using (((user_id = auth.uid()) OR cibafit.current_user_is_admin())) with check (((user_id = auth.uid()) OR cibafit.current_user_is_admin()));
create policy "Anyone reads public profiles" on cibafit."professional_profiles" as permissive for select to anon using (((is_visible = true) AND (public_slug IS NOT NULL)));
create policy "Pro reads client measurements" on cibafit."body_measurements" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = body_measurements.user_id) AND (cl.status = 'active'::text)))));
create policy "Products update by authenticated" on cibafit."products" as permissive for update to public using ((auth.uid() IS NOT NULL)) with check ((auth.uid() IS NOT NULL));
create policy "Users insert own submissions" on cibafit."product_submissions" as permissive for insert to authenticated with check ((user_id = auth.uid()));
create policy "Users read own submissions" on cibafit."product_submissions" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin manages submissions" on cibafit."product_submissions" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users insert own support requests" on cibafit."support_requests" as permissive for insert to public with check ((user_id = auth.uid()));
create policy "Users read own support requests" on cibafit."support_requests" as permissive for select to public using ((user_id = auth.uid()));
create policy "Admin manages all support requests" on cibafit."support_requests" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users can view own email prefs" on cibafit."email_preferences" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin diet_plan_items" on cibafit."diet_plan_items" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Pro manages diet_plan_items" on cibafit."diet_plan_items" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_items.diet_plan_id) AND (dp.professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), dp.client_user_id))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_items.diet_plan_id) AND (dp.professional_id = auth.uid()) AND cibafit.has_active_pro_link(auth.uid(), dp.client_user_id)))));
create policy "Client reads own diet_plan_items" on cibafit."diet_plan_items" as permissive for select to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_items.diet_plan_id) AND (dp.client_user_id = auth.uid())))));
create policy "User manages own templates" on cibafit."diet_plan_templates" as permissive for all to public using ((professional_id = auth.uid())) with check ((professional_id = auth.uid()));
create policy "Self plan diet_plan_items" on cibafit."diet_plan_items" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_items.diet_plan_id) AND (dp.professional_id = auth.uid()) AND (dp.client_user_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_items.diet_plan_id) AND (dp.professional_id = auth.uid()) AND (dp.client_user_id = auth.uid())))));
create policy "Self plan diet_plans" on cibafit."diet_plans" as permissive for all to public using (((professional_id = auth.uid()) AND (client_user_id = auth.uid()))) with check (((professional_id = auth.uid()) AND (client_user_id = auth.uid())));
create policy "Self plan meal_targets" on cibafit."diet_plan_meal_targets" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_meal_targets.diet_plan_id) AND (dp.professional_id = auth.uid()) AND (dp.client_user_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plans dp
  WHERE ((dp.id = diet_plan_meal_targets.diet_plan_id) AND (dp.professional_id = auth.uid()) AND (dp.client_user_id = auth.uid())))));
create policy "Authenticated reads visible profiles" on cibafit."professional_profiles" as permissive for select to public using (((auth.uid() IS NOT NULL) AND (is_visible = true)));
create policy "Read system templates" on cibafit."diet_plan_templates" as permissive for select to public using (((professional_id = '00000000-0000-0000-0000-000000000000'::uuid) AND (auth.uid() IS NOT NULL)));
create policy "Read system template meals" on cibafit."diet_plan_template_meals" as permissive for select to public using (((EXISTS ( SELECT 1
   FROM cibafit.diet_plan_templates t
  WHERE ((t.id = diet_plan_template_meals.template_id) AND (t.professional_id = '00000000-0000-0000-0000-000000000000'::uuid)))) AND (auth.uid() IS NOT NULL)));
create policy "User template meals follow template" on cibafit."diet_plan_template_meals" as permissive for all to public using ((EXISTS ( SELECT 1
   FROM cibafit.diet_plan_templates t
  WHERE ((t.id = diet_plan_template_meals.template_id) AND (t.professional_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.diet_plan_templates t
  WHERE ((t.id = diet_plan_template_meals.template_id) AND (t.professional_id = auth.uid())))));
create policy "Anyone reads dishes" on cibafit."dishes" as permissive for select to authenticated using (true);
create policy "Authenticated inserts dishes" on cibafit."dishes" as permissive for insert to authenticated with check (true);
create policy "Anyone reads dish_ingredients" on cibafit."dish_ingredients" as permissive for select to authenticated using (true);
create policy "Authenticated inserts dish_ingredients" on cibafit."dish_ingredients" as permissive for insert to authenticated with check (true);
create policy "ingredients_read" on cibafit."ingredients" as permissive for select to authenticated using (true);
create policy "ingredients_insert" on cibafit."ingredients" as permissive for insert to authenticated with check (true);
create policy "ingredients_update" on cibafit."ingredients" as permissive for update to authenticated using (true);
create policy "translation_read" on cibafit."ingredient_translation" as permissive for select to authenticated using (true);
create policy "meal_logs_own" on cibafit."meal_logs" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "meal_log_ingredients_own" on cibafit."meal_log_ingredients" as permissive for all to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.meal_logs ml
  WHERE ((ml.id = meal_log_ingredients.meal_log_id) AND (ml.user_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.meal_logs ml
  WHERE ((ml.id = meal_log_ingredients.meal_log_id) AND (ml.user_id = auth.uid())))));
create policy "Client reads own links" on cibafit."user_nutritionist_links" as permissive for select to authenticated using ((client_user_id = auth.uid()));
create policy "Nutritionist reads own links" on cibafit."user_nutritionist_links" as permissive for select to authenticated using ((nutritionist_user_id = auth.uid()));
create policy "Users update own profile no role change" on cibafit."profiles" as permissive for update to public using ((auth.uid() = id)) with check (((auth.uid() = id) AND (role = cibafit.get_user_role(auth.uid()))));
create policy "Anyone reads template_recipes" on cibafit."template_recipes" as permissive for select to public using (true);
create policy "Admin manages template_recipes" on cibafit."template_recipes" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User owns daily_progress" on cibafit."daily_progress" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Pro reads client daily_progress" on cibafit."daily_progress" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.client_links cl
  WHERE ((cl.professional_id = auth.uid()) AND (cl.client_user_id = daily_progress.user_id) AND (cl.status = 'active'::text)))));
create policy "Admin daily_progress" on cibafit."daily_progress" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User owns favorites" on cibafit."user_favorites" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Nutritionist reads own coupons" on cibafit."nutritionist_coupons" as permissive for select to authenticated using ((nutritionist_user_id = auth.uid()));
create policy "Admin manages all coupons" on cibafit."nutritionist_coupons" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Authenticated validates coupons" on cibafit."nutritionist_coupons" as permissive for select to authenticated using ((is_active = true));
create policy "Admin manages links" on cibafit."user_nutritionist_links" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users manage own reminder settings" on cibafit."meal_reminder_settings" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Users own favorite_meals" on cibafit."user_favorite_meals" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Favorite meal items follow parent" on cibafit."favorite_meal_items" as permissive for all to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.user_favorite_meals fm
  WHERE ((fm.id = favorite_meal_items.favorite_meal_id) AND (fm.user_id = auth.uid()))))) with check ((EXISTS ( SELECT 1
   FROM cibafit.user_favorite_meals fm
  WHERE ((fm.id = favorite_meal_items.favorite_meal_id) AND (fm.user_id = auth.uid())))));
create policy "Users own quick_day_logs" on cibafit."quick_day_logs" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Users own waste_savings" on cibafit."waste_savings" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Anon reads active coupons" on cibafit."nutritionist_coupons" as permissive for select to anon using ((is_active = true));
create policy "Anyone reads ingredient_categories" on cibafit."ingredient_categories" as permissive for select to authenticated using (true);
create policy "Admin manages ingredient_categories" on cibafit."ingredient_categories" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Anyone reads compatibility_matrix" on cibafit."ingredient_compatibility_matrix" as permissive for select to authenticated using (true);
create policy "Admin manages compatibility_matrix" on cibafit."ingredient_compatibility_matrix" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users can view own email logs" on cibafit."email_notifications_log" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin reads haccp_audit_log" on cibafit."haccp_audit_log" as permissive for select to authenticated using (cibafit.current_user_is_admin());
create policy "Restaurant reads own haccp_audit_log" on cibafit."haccp_audit_log" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.haccp_logs hl
  WHERE ((hl.id = haccp_audit_log.record_id) AND cibafit.is_restaurant_accessible(hl.restaurant_id)))));
create policy "Authenticated inserts haccp_audit_log" on cibafit."haccp_audit_log" as permissive for insert to authenticated with check ((changed_by = auth.uid()));
create policy "Anyone reads active templates" on cibafit."haccp_templates" as permissive for select to authenticated using (true);
create policy "Admin manages templates" on cibafit."haccp_templates" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Anyone reads template tasks" on cibafit."haccp_template_tasks" as permissive for select to authenticated using (true);
create policy "Admin manages template tasks" on cibafit."haccp_template_tasks" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Anyone reads active plans" on cibafit."subscription_plans" as permissive for select to authenticated using (true);
create policy "Admin manages plans" on cibafit."subscription_plans" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User reads own subscription" on cibafit."subscriptions" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin manages subscriptions" on cibafit."subscriptions" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Restaurant accessible photos" on cibafit."haccp_task_photos" as permissive for select to authenticated using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Restaurant member inserts photos" on cibafit."haccp_task_photos" as permissive for insert to authenticated with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin photos" on cibafit."haccp_task_photos" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Restaurant accessible temps" on cibafit."haccp_temperature_logs" as permissive for select to authenticated using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin full access on stripe_payments" on cibafit."stripe_payments" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User can read own payments" on cibafit."stripe_payments" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin full access on stripe_settings" on cibafit."stripe_settings" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Admin full access on custom_coupons" on cibafit."custom_coupons" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Admin full access on overrides" on cibafit."manual_subscription_overrides" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "User can read own overrides" on cibafit."manual_subscription_overrides" as permissive for select to authenticated using ((user_id = auth.uid()));
create policy "Admin full access on audit_log" on cibafit."admin_audit_log" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Anyone can read active plans" on cibafit."subscription_plans" as permissive for select to authenticated using ((is_active = true));
create policy "Admins can manage api_keys" on cibafit."api_keys" as permissive for all to authenticated using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Users can manage own weight goals" on cibafit."weight_goals" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Pros can read client weight goals" on cibafit."weight_goals" as permissive for select to authenticated using (cibafit.has_active_client_link(auth.uid(), user_id));
create policy "Admins can read all weight goals" on cibafit."weight_goals" as permissive for select to authenticated using (cibafit.current_user_is_admin());
create policy "Professionals can update requests to them" on cibafit."professional_link_requests" as permissive for update to authenticated using ((auth.uid() = professional_id));
create policy "Pro manages client measurements" on cibafit."body_measurements" as permissive for all to authenticated using (cibafit.has_active_client_link(auth.uid(), user_id)) with check (cibafit.has_active_client_link(auth.uid(), user_id));
create policy "Pro manages client weight goals" on cibafit."weight_goals" as permissive for all to authenticated using (cibafit.has_active_client_link(auth.uid(), user_id)) with check (cibafit.has_active_client_link(auth.uid(), user_id));
create policy "Nutritionists manage own plans" on cibafit."nutrition_plans" as permissive for all to authenticated using (((nutritionist_user_id = auth.uid()) OR (client_user_id = auth.uid()) OR cibafit.is_admin(auth.uid()))) with check (((nutritionist_user_id = auth.uid()) OR cibafit.is_admin(auth.uid())));
create policy "Access via plan ownership" on cibafit."nutrition_plan_weeks" as permissive for all to authenticated using (cibafit.owns_nutrition_plan(plan_id)) with check (cibafit.owns_nutrition_plan(plan_id));
create policy "Access via week ownership" on cibafit."nutrition_plan_days" as permissive for all to authenticated using (cibafit.owns_np_week(week_id)) with check (cibafit.owns_np_week(week_id));
create policy "Access via day ownership" on cibafit."nutrition_plan_meals" as permissive for all to authenticated using (cibafit.owns_np_day(day_id)) with check (cibafit.owns_np_day(day_id));
create policy "Pros manage own meal suggestions" on cibafit."pro_meal_text_suggestions" as permissive for all to authenticated using ((professional_id = auth.uid())) with check ((professional_id = auth.uid()));
create policy "Users can view own link requests" on cibafit."professional_link_requests" as permissive for select to authenticated using ((auth.uid() = user_id));
create policy "Professionals can view requests to them" on cibafit."professional_link_requests" as permissive for select to authenticated using ((auth.uid() = professional_id));
create policy "Users can create link requests" on cibafit."professional_link_requests" as permissive for insert to authenticated with check ((auth.uid() = user_id));
create policy "Users can view own notifications" on cibafit."in_app_notifications" as permissive for select to authenticated using ((auth.uid() = user_id));
create policy "Users can update own notifications" on cibafit."in_app_notifications" as permissive for update to authenticated using ((auth.uid() = user_id));
create policy "Authenticated can insert notifications" on cibafit."in_app_notifications" as permissive for insert to authenticated with check (true);
create policy "Pro reads link request profiles" on cibafit."profiles" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.professional_link_requests plr
  WHERE ((plr.professional_id = auth.uid()) AND (plr.user_id = profiles.id) AND (plr.status = 'pending'::text)))));
create policy "Messages insert own" on cibafit."messages" as permissive for insert to authenticated with check (((sender_id = auth.uid()) AND (cibafit.has_active_pro_link(auth.uid(), receiver_id) OR cibafit.has_active_client_link(receiver_id, auth.uid()) OR cibafit.has_pending_link_request(auth.uid(), receiver_id) OR cibafit.has_pending_link_request(receiver_id, auth.uid()) OR cibafit.current_user_is_admin())));
create policy "Messages select own" on cibafit."messages" as permissive for select to authenticated using ((((sender_id = auth.uid()) OR (receiver_id = auth.uid())) AND (cibafit.has_active_pro_link(auth.uid(),
CASE
    WHEN (sender_id = auth.uid()) THEN receiver_id
    ELSE sender_id
END) OR cibafit.has_active_client_link(
CASE
    WHEN (sender_id = auth.uid()) THEN receiver_id
    ELSE sender_id
END, auth.uid()) OR cibafit.has_pending_link_request(auth.uid(),
CASE
    WHEN (sender_id = auth.uid()) THEN receiver_id
    ELSE sender_id
END) OR cibafit.has_pending_link_request(
CASE
    WHEN (sender_id = auth.uid()) THEN receiver_id
    ELSE sender_id
END, auth.uid()) OR cibafit.current_user_is_admin())));
create policy "Client or pro inserts link" on cibafit."client_links" as permissive for insert to authenticated with check (((client_user_id = auth.uid()) OR (professional_id = auth.uid())));
create policy "Admins can read ai_usage_log" on cibafit."ai_usage_log" as permissive for select to authenticated using (cibafit.current_user_is_admin());
create policy "Restaurant members can view item photos" on cibafit."inventory_item_photos" as permissive for select to authenticated using (((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'inventory'::text) AND (rm.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM (cibafit.preparations p
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = p.restaurant_id)))
  WHERE ((p.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'preparation'::text) AND (rm.user_id = auth.uid()))))));
create policy "Restaurant members can insert item photos" on cibafit."inventory_item_photos" as permissive for insert to authenticated with check (((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'inventory'::text) AND (rm.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM (cibafit.preparations p
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = p.restaurant_id)))
  WHERE ((p.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'preparation'::text) AND (rm.user_id = auth.uid()))))));
create policy "Restaurant members can delete item photos" on cibafit."inventory_item_photos" as permissive for delete to authenticated using (((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'inventory'::text) AND (rm.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM (cibafit.preparations p
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = p.restaurant_id)))
  WHERE ((p.id = inventory_item_photos.item_id) AND (inventory_item_photos.item_type = 'preparation'::text) AND (rm.user_id = auth.uid()))))));
create policy "Restaurant members can view inventory allergens" on cibafit."inventory_item_allergens" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_allergens.inventory_item_id) AND (rm.user_id = auth.uid())))));
create policy "Restaurant members can insert inventory allergens" on cibafit."inventory_item_allergens" as permissive for insert to authenticated with check ((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_allergens.inventory_item_id) AND (rm.user_id = auth.uid())))));
create policy "Restaurant members can delete inventory allergens" on cibafit."inventory_item_allergens" as permissive for delete to authenticated using ((EXISTS ( SELECT 1
   FROM (cibafit.inventory_items ii
     JOIN cibafit.restaurant_members rm ON ((rm.restaurant_id = ii.restaurant_id)))
  WHERE ((ii.id = inventory_item_allergens.inventory_item_id) AND (rm.user_id = auth.uid())))));
create policy "Users manage own product favorites" on cibafit."user_product_favorites" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "Users manage own usage log" on cibafit."product_usage_log" as permissive for all to authenticated using ((user_id = auth.uid())) with check ((user_id = auth.uid()));
create policy "members read labels" on cibafit."haccp_preparation_labels" as permissive for select to public using ((cibafit.is_restaurant_accessible(restaurant_id) OR cibafit.current_user_is_admin()));
create policy "members insert labels" on cibafit."haccp_preparation_labels" as permissive for insert to public with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "members update labels" on cibafit."haccp_preparation_labels" as permissive for update to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "members delete labels" on cibafit."haccp_preparation_labels" as permissive for delete to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "ing read" on cibafit."haccp_preparation_ingredients" as permissive for select to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "ing insert" on cibafit."haccp_preparation_ingredients" as permissive for insert to public with check (cibafit.haccp_label_accessible(preparation_label_id));
create policy "ing update" on cibafit."haccp_preparation_ingredients" as permissive for update to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "ing delete" on cibafit."haccp_preparation_ingredients" as permissive for delete to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "docs read" on cibafit."haccp_documents" as permissive for select to public using ((cibafit.is_restaurant_accessible(restaurant_id) OR cibafit.current_user_is_admin()));
create policy "docs insert" on cibafit."haccp_documents" as permissive for insert to public with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "docs update" on cibafit."haccp_documents" as permissive for update to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "docs delete" on cibafit."haccp_documents" as permissive for delete to public using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "pdoc read" on cibafit."haccp_preparation_documents" as permissive for select to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "pdoc insert" on cibafit."haccp_preparation_documents" as permissive for insert to public with check (cibafit.haccp_label_accessible(preparation_label_id));
create policy "pdoc delete" on cibafit."haccp_preparation_documents" as permissive for delete to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "audit read" on cibafit."haccp_label_audit_log" as permissive for select to public using (cibafit.haccp_label_accessible(preparation_label_id));
create policy "audit insert" on cibafit."haccp_label_audit_log" as permissive for insert to public with check (cibafit.haccp_label_accessible(preparation_label_id));
create policy "Admin full access on haccp_documents" on cibafit."haccp_documents" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "movements read" on cibafit."inventory_movements" as permissive for select to public using ((cibafit.is_restaurant_accessible(restaurant_id) OR cibafit.current_user_is_admin()));
create policy "movements insert" on cibafit."inventory_movements" as permissive for insert to public with check (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Admin full access on inventory_movements" on cibafit."inventory_movements" as permissive for all to public using (cibafit.current_user_is_admin()) with check (cibafit.current_user_is_admin());
create policy "Restaurant owners manage api keys" on cibafit."restaurant_api_keys" as permissive for all to authenticated using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owners read integration runs" on cibafit."integration_runs" as permissive for select to authenticated using (cibafit.is_restaurant_owner(restaurant_id));
create policy "User starts own restaurant trial" on cibafit."subscriptions" as permissive for insert to authenticated with check (((user_id = auth.uid()) AND (plan_type = 'restaurant'::text) AND (status = 'trial'::text) AND (trial_end_date <= (now() + '31 days'::interval)) AND (is_free_override = false) AND (stripe_customer_id IS NULL) AND (stripe_subscription_id IS NULL) AND (NOT (EXISTS ( SELECT 1
   FROM cibafit.subscriptions s
  WHERE ((s.user_id = auth.uid()) AND (s.plan_type = 'restaurant'::text)))))));
create policy "Owner manages restaurant invites" on cibafit."restaurant_invites" as permissive for all to authenticated using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner reads member profiles" on cibafit."profiles" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM (cibafit.restaurant_members rm
     JOIN cibafit.restaurants r ON ((r.id = rm.restaurant_id)))
  WHERE ((rm.user_id = profiles.id) AND (r.owner_id = auth.uid())))));
create policy "Restaurant reads haccp_tasks" on cibafit."haccp_tasks" as permissive for select to authenticated using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Restaurant owner inserts haccp_tasks" on cibafit."haccp_tasks" as permissive for insert to authenticated with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner updates haccp_tasks" on cibafit."haccp_tasks" as permissive for update to authenticated using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner deletes haccp_tasks" on cibafit."haccp_tasks" as permissive for delete to authenticated using (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant reads haccp_equipment" on cibafit."haccp_equipment" as permissive for select to authenticated using (cibafit.is_restaurant_accessible(restaurant_id));
create policy "Restaurant owner inserts haccp_equipment" on cibafit."haccp_equipment" as permissive for insert to authenticated with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner updates haccp_equipment" on cibafit."haccp_equipment" as permissive for update to authenticated using (cibafit.is_restaurant_owner(restaurant_id)) with check (cibafit.is_restaurant_owner(restaurant_id));
create policy "Restaurant owner deletes haccp_equipment" on cibafit."haccp_equipment" as permissive for delete to authenticated using (cibafit.is_restaurant_owner(restaurant_id));
create policy "Supplier or restaurant updates link" on cibafit."supplier_restaurants" as permissive for update to authenticated using ((cibafit.owns_supplier(supplier_id) OR (EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = supplier_restaurants.restaurant_id) AND (r.owner_id = auth.uid())))) OR cibafit.current_user_is_admin())) with check ((cibafit.owns_supplier(supplier_id) OR cibafit.current_user_is_admin() OR ((status = 'revoked'::text) AND (EXISTS ( SELECT 1
   FROM cibafit.restaurants r
  WHERE ((r.id = supplier_restaurants.restaurant_id) AND (r.owner_id = auth.uid())))))));
create policy "Linked restaurant reads supplier" on cibafit."suppliers" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM (cibafit.supplier_restaurants sr
     JOIN cibafit.restaurants r ON ((r.id = sr.restaurant_id)))
  WHERE ((sr.supplier_id = suppliers.id) AND (r.owner_id = auth.uid())))));
create policy "Order parties read items" on cibafit."supplier_order_items" as permissive for select to authenticated using ((EXISTS ( SELECT 1
   FROM cibafit.supplier_orders o
  WHERE (o.id = supplier_order_items.order_id))));

-- 7. Permessi (speculari a public: l'accesso reale e' governato dalle policy)
grant usage on schema cibafit to anon, authenticated, service_role;
grant all on all tables in schema cibafit to anon, authenticated, service_role;

-- 8. Provisioning profilo
-- Provisioning del profilo CibaFit. auth.users e' condiviso con Cibarius e il trigger
-- public.handle_new_user NON va toccato: il profilo cibafit nasce da questa funzione,
-- chiamata dal client dopo il login. I dati di iscrizione stanno in user_metadata.cibafit.
create function cibafit.ensure_profile()
returns void
language plpgsql
security definer
set search_path to 'cibafit'
as $function$
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
  _restaurant_id uuid;
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
  if _role not in ('user', 'restaurant_owner', 'professional') then
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

  if _role = 'restaurant_owner' then
    insert into cibafit.restaurants (name, phone, address, owner_id)
    values (coalesce(_meta ->> 'restaurant_name', 'Il mio ristorante'),
            coalesce(_meta ->> 'restaurant_phone', _phone, ''), _meta ->> 'restaurant_address', _uid)
    returning id into _restaurant_id;
    insert into cibafit.restaurant_members (restaurant_id, user_id, member_role)
    values (_restaurant_id, _uid, 'owner');
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
revoke all on function cibafit.ensure_profile() from public, anon;
grant execute on function cibafit.ensure_profile() to authenticated, service_role;
