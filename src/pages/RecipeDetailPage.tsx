import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { BookOpen, Clock } from "lucide-react";
import MobileHeader from "@/components/MobileHeader";
import EmptyState from "@/components/EmptyState";
import ListSkeleton from "@/components/ListSkeleton";
import { supabase } from "@/integrations/supabase/client";
import { DIET_LABELS, MEAL_LABELS } from "@/pages/PublicRecipesPage";

interface Ingredient {
  name: string;
  grams?: number | null;
  kcal?: number | null;
  protein_g?: number | null;
  carbs_g?: number | null;
  fats_g?: number | null;
}

interface Recipe {
  id: string;
  title: string;
  meal_type: string;
  diet_category: string;
  instructions: string | null;
  prep_time_min: number | null;
  ingredients: Ingredient[];
  kcal_total: number;
  protein_total: number;
  carbs_total: number;
  fats_total: number;
}

const RecipeDetailPage = () => {
  const { recipeId } = useParams<{ recipeId: string }>();
  const [recipe, setRecipe] = useState<Recipe | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!recipeId) return;
    supabase
      .from("template_recipes")
      .select("id, title, meal_type, diet_category, instructions, prep_time_min, ingredients, kcal_total, protein_total, carbs_total, fats_total")
      .eq("id", recipeId)
      .maybeSingle()
      .then(({ data }) => {
        setRecipe(data as unknown as Recipe | null);
        setLoading(false);
      });
  }, [recipeId]);

  if (loading) {
    return (
      <div>
        <MobileHeader title="Ricetta" />
        <main className="px-4 py-5"><ListSkeleton count={3} variant="card" /></main>
      </div>
    );
  }

  if (!recipe) {
    return (
      <div>
        <MobileHeader title="Ricetta" />
        <main className="px-4 py-5">
          <EmptyState icon={BookOpen} title="Ricetta non trovata" description="Potrebbe essere stata rimossa dal catalogo." />
        </main>
      </div>
    );
  }

  const macros = [
    { label: "Proteine", value: recipe.protein_total },
    { label: "Carboidrati", value: recipe.carbs_total },
    { label: "Grassi", value: recipe.fats_total },
  ];

  return (
    <div>
      <MobileHeader title="Ricetta" />
      <main className="space-y-5 px-4 py-5">
        <header>
          <h1 className="text-xl font-semibold text-balance text-foreground">{recipe.title}</h1>
          <p className="mt-1 flex flex-wrap items-center gap-x-2 text-sm text-muted-foreground">
            <span>{MEAL_LABELS[recipe.meal_type] ?? recipe.meal_type}</span>
            <span aria-hidden="true">·</span>
            <span>{DIET_LABELS[recipe.diet_category] ?? recipe.diet_category}</span>
            {recipe.prep_time_min ? (
              <span className="inline-flex items-center gap-1">
                <span aria-hidden="true">·</span>
                <Clock className="h-3.5 w-3.5" aria-hidden="true" /> {recipe.prep_time_min} min
              </span>
            ) : null}
          </p>
        </header>

        <section aria-label="Valori nutrizionali" className="rounded-lg bg-card p-4 shadow-card">
          <p className="text-2xl font-semibold tabular-nums text-foreground">
            {Math.round(recipe.kcal_total)} <span className="text-sm font-normal text-muted-foreground">kcal</span>
          </p>
          <dl className="mt-3 grid grid-cols-3 gap-3">
            {macros.map(({ label, value }) => (
              <div key={label}>
                <dt className="text-xs text-muted-foreground">{label}</dt>
                <dd className="text-sm font-medium tabular-nums text-foreground">{Math.round(value)} g</dd>
              </div>
            ))}
          </dl>
        </section>

        <section>
          <h2 className="mb-2 text-base font-semibold text-foreground">Ingredienti</h2>
          <ul className="divide-y divide-border overflow-hidden rounded-lg bg-card shadow-card">
            {(recipe.ingredients ?? []).map((ingredient, index) => (
              <li key={`${ingredient.name}-${index}`} className="flex items-baseline justify-between gap-3 px-4 py-2.5">
                <span className="text-sm text-foreground">{ingredient.name}</span>
                <span className="shrink-0 text-xs tabular-nums text-muted-foreground">
                  {ingredient.grams != null ? `${ingredient.grams} g` : ""}
                  {ingredient.kcal != null ? ` · ${Math.round(ingredient.kcal)} kcal` : ""}
                </span>
              </li>
            ))}
          </ul>
        </section>

        <section>
          <h2 className="mb-2 text-base font-semibold text-foreground">Preparazione</h2>
          {recipe.instructions ? (
            <p className="max-w-[65ch] whitespace-pre-line text-sm leading-relaxed text-foreground">{recipe.instructions}</p>
          ) : (
            <p className="text-sm text-muted-foreground">Per questa ricetta non ci sono istruzioni di preparazione.</p>
          )}
        </section>
      </main>
    </div>
  );
};

export default RecipeDetailPage;
