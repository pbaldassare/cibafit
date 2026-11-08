-- CibaFit: sottoprogetto isolato nello schema "cibafit".
-- Clona solo la STRUTTURA delle tabelle nutrizione di public (nessun dato utente).
-- Non copia foreign key, trigger e policy: RLS attiva senza policy = accesso negato
-- a tutti i ruoli client finche' non verranno definite le policy.
create schema if not exists cibafit;
comment on schema cibafit is 'Sottoprogetto CibaFit (modulo nutrizione). Separato da public.';

do $$
declare
  t text;
begin
  foreach t in array array[
    'template_recipes',
    'diet_plans', 'diet_plan_items', 'diet_plan_meal_targets',
    'diet_plan_templates', 'diet_plan_template_meals',
    'nutrition_plans', 'nutrition_plan_weeks', 'nutrition_plan_days', 'nutrition_plan_meals',
    'nutrition_targets',
    'meal_days', 'meals', 'meal_items', 'meal_logs', 'meal_log_ingredients',
    'daily_progress', 'body_measurements',
    'food_templates', 'ingredients', 'dishes', 'dish_ingredients',
    'client_links', 'professional_profiles', 'professional_invites',
    'professional_notes', 'professional_link_requests',
    'user_favorite_meals', 'favorite_meal_items',
    'pro_suggestions', 'generated_recipes'
  ]
  loop
    execute format('create table cibafit.%I (like public.%I including all)', t, t);
    execute format('alter table cibafit.%I enable row level security', t);
  end loop;
end $$;

revoke all on schema cibafit from public, anon, authenticated;
grant usage on schema cibafit to service_role;
grant all on all tables in schema cibafit to service_role;
alter default privileges in schema cibafit grant all on tables to service_role;
