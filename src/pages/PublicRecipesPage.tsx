import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import { BookOpen, Clock, Search } from "lucide-react";
import MobileHeader from "@/components/MobileHeader";
import EmptyState from "@/components/EmptyState";
import ListSkeleton from "@/components/ListSkeleton";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useDebounce } from "@/hooks/useDebounce";
import { supabase } from "@/integrations/supabase/client";

interface RecipeRow {
  id: string;
  title: string;
  meal_type: string;
  diet_category: string;
  prep_time_min: number | null;
  kcal_total: number;
  protein_total: number;
  carbs_total: number;
  fats_total: number;
}

export const DIET_LABELS: Record<string, string> = {
  digiuno: "Digiuno",
  dimagrimento: "Dimagrimento",
  keto: "Keto",
  massa: "Massa",
  mediterranea: "Mediterranea",
};

export const MEAL_LABELS: Record<string, string> = {
  colazione: "Colazione",
  pranzo: "Pranzo",
  spuntino: "Spuntino",
  cena: "Cena",
};

const PublicRecipesPage = () => {
  const navigate = useNavigate();
  const [recipes, setRecipes] = useState<RecipeRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [failed, setFailed] = useState(false);
  const [search, setSearch] = useState("");
  const [diet, setDiet] = useState("all");
  const [meal, setMeal] = useState("all");
  const debouncedSearch = useDebounce(search, 250);

  useEffect(() => {
    supabase
      .from("template_recipes")
      .select("id, title, meal_type, diet_category, prep_time_min, kcal_total, protein_total, carbs_total, fats_total")
      .order("title")
      .then(({ data, error }) => {
        if (error) setFailed(true);
        setRecipes((data ?? []) as RecipeRow[]);
        setLoading(false);
      });
  }, []);

  const filtered = useMemo(() => {
    const term = debouncedSearch.trim().toLowerCase();
    return recipes.filter(
      (r) =>
        (!term || r.title.toLowerCase().includes(term)) &&
        (diet === "all" || r.diet_category === diet) &&
        (meal === "all" || r.meal_type === meal),
    );
  }, [recipes, debouncedSearch, diet, meal]);

  return (
    <div>
      <MobileHeader title="Ricette" />
      <main className="space-y-3 px-4 py-5">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
          <Input
            placeholder="Cerca una ricetta"
            aria-label="Cerca una ricetta"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="pl-9"
          />
        </div>

        <div className="grid grid-cols-2 gap-2">
          <Select value={diet} onValueChange={setDiet}>
            <SelectTrigger aria-label="Tipo di dieta"><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Tutte le diete</SelectItem>
              {Object.entries(DIET_LABELS).map(([value, label]) => (
                <SelectItem key={value} value={value}>{label}</SelectItem>
              ))}
            </SelectContent>
          </Select>
          <Select value={meal} onValueChange={setMeal}>
            <SelectTrigger aria-label="Pasto"><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Tutti i pasti</SelectItem>
              {Object.entries(MEAL_LABELS).map(([value, label]) => (
                <SelectItem key={value} value={value}>{label}</SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        {loading ? (
          <ListSkeleton count={4} variant="card" />
        ) : failed ? (
          <EmptyState
            icon={BookOpen}
            title="Ricette non disponibili"
            description="Non siamo riusciti a caricarle. Controlla la connessione e riprova."
          />
        ) : filtered.length === 0 ? (
          <EmptyState
            icon={BookOpen}
            title="Nessuna ricetta trovata"
            description="Prova a cambiare la ricerca o i filtri."
          />
        ) : (
          <>
            <p className="text-xs text-muted-foreground">
              {filtered.length} {filtered.length === 1 ? "ricetta" : "ricette"}
            </p>
            <ul className="divide-y divide-border overflow-hidden rounded-lg bg-card shadow-card">
              {filtered.map((r) => (
                <li key={r.id}>
                  <button
                    onClick={() => navigate(`/recipes/${r.id}`)}
                    className="w-full px-4 py-3 text-left transition-colors hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-ring"
                  >
                    <span className="flex items-baseline justify-between gap-3">
                      <span className="text-sm font-medium text-foreground">{r.title}</span>
                      <span className="shrink-0 text-sm font-semibold tabular-nums text-foreground">
                        {Math.round(r.kcal_total)} kcal
                      </span>
                    </span>
                    <span className="mt-1 flex flex-wrap items-center gap-x-3 gap-y-0.5 text-xs text-muted-foreground">
                      <span>{MEAL_LABELS[r.meal_type] ?? r.meal_type} · {DIET_LABELS[r.diet_category] ?? r.diet_category}</span>
                      <span className="tabular-nums">
                        P {Math.round(r.protein_total)} · C {Math.round(r.carbs_total)} · G {Math.round(r.fats_total)}
                      </span>
                      {r.prep_time_min ? (
                        <span className="inline-flex items-center gap-1">
                          <Clock className="h-3 w-3" aria-hidden="true" /> {r.prep_time_min} min
                        </span>
                      ) : null}
                    </span>
                  </button>
                </li>
              ))}
            </ul>
          </>
        )}
      </main>
    </div>
  );
};

export default PublicRecipesPage;
