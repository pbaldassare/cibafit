import { localDateString } from "@/lib/date";
import { useCallback, useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  BookOpen,
  Camera,
  ChevronRight,
  ClipboardList,
  MessageSquare,
  Package,
  Plus,
  ScanLine,
  HeartPulse,
  Sparkles,
  type LucideIcon,
} from "lucide-react";
import MobileHeader from "@/components/MobileHeader";
import MealReminderBanner from "@/components/MealReminderBanner";
import AutoSuggestFavBanner from "@/components/AutoSuggestFavBanner";
import { WeightGoalHomeBar } from "@/components/WeightGoalMotivation";
import { Skeleton } from "@/components/ui/skeleton";
import { useAuth } from "@/hooks/useAuth";
import { getRoleHomePath, useRole } from "@/hooks/useRole";
import { supabase } from "@/integrations/supabase/client";

interface Totals {
  kcal: number;
  protein: number;
  carbs: number;
  fats: number;
}

interface MealSummary {
  type: string;
  kcal: number;
  count: number;
  target: number | null;
}

const MEALS: { type: string; label: string; until: number }[] = [
  { type: "colazione", label: "Colazione", until: 11 },
  { type: "pranzo", label: "Pranzo", until: 15 },
  { type: "spuntino", label: "Spuntino", until: 18 },
  { type: "cena", label: "Cena", until: 24 },
];

const ACTIONS: { label: string; icon: LucideIcon; to: string }[] = [
  { label: "Foto pasto", icon: Camera, to: "/meals/photo" },
  { label: "Barcode", icon: ScanLine, to: "/scan" },
  { label: "Cosa mangio?", icon: Sparkles, to: "/suggest-meal" },
  { label: "Ricette", icon: BookOpen, to: "/recipes" },
];

const EMPTY_TOTALS: Totals = { kcal: 0, protein: 0, carbs: 0, fats: 0 };

const greetingFor = (hour: number) => (hour < 12 ? "Buongiorno" : hour < 18 ? "Buon pomeriggio" : "Buonasera");

const MacroBar = ({ label, value, target }: { label: string; value: number; target: number | null }) => {
  const percent = target ? Math.min(100, Math.round((value / target) * 100)) : 0;
  return (
    <div>
      <div className="flex items-baseline justify-between text-xs">
        <span className="text-muted-foreground">{label}</span>
        <span className="font-medium tabular-nums text-foreground">
          {Math.round(value)}
          {target ? ` / ${Math.round(target)}` : ""} g
        </span>
      </div>
      <div className="mt-1 h-1.5 overflow-hidden rounded-full bg-muted">
        <div className="h-full rounded-full bg-primary transition-[width] duration-500" style={{ width: `${percent}%` }} />
      </div>
    </div>
  );
};

const Index = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { role, profile, isLoading: roleLoading } = useRole();

  const [loading, setLoading] = useState(true);
  const [totals, setTotals] = useState<Totals>(EMPTY_TOTALS);
  const [targets, setTargets] = useState<Totals | null>(null);
  const [meals, setMeals] = useState<MealSummary[]>([]);
  const [hasNutritionist, setHasNutritionist] = useState(false);
  const [unreadMessages, setUnreadMessages] = useState(0);

  useEffect(() => {
    if (!roleLoading && role && role !== "user") {
      navigate(getRoleHomePath(role), { replace: true });
    }
  }, [role, roleLoading, navigate]);

  const load = useCallback(async () => {
    if (!user) return;
    const today = localDateString();

    const [dayRes, ownTargetRes, planRes, linkRes, messagesRes] = await Promise.all([
      supabase
        .from("meal_days")
        .select("meals(meal_type, meal_items(calories, macros))")
        .eq("user_id", user.id)
        .eq("day_date", today)
        .maybeSingle(),
      supabase.from("nutrition_targets").select("kcal_day, protein_g, carbs_g, fats_g").eq("user_id", user.id).maybeSingle(),
      supabase
        .from("diet_plans")
        .select("kcal_day, protein_g_day, carbs_g_day, fats_g_day, diet_plan_meal_targets(meal_type, kcal_target)")
        .eq("client_user_id", user.id)
        .eq("is_active", true)
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle(),
      supabase.from("client_links").select("id").eq("client_user_id", user.id).eq("status", "active").limit(1),
      supabase.from("messages").select("id", { count: "exact", head: true }).eq("receiver_id", user.id).is("read_at", null),
    ]);

    const plan = planRes.data as any;
    const own = ownTargetRes.data as any;
    // Il piano del nutrizionista ha la precedenza sugli obiettivi impostati dall'utente.
    if (plan?.kcal_day) {
      setTargets({ kcal: plan.kcal_day, protein: plan.protein_g_day ?? 0, carbs: plan.carbs_g_day ?? 0, fats: plan.fats_g_day ?? 0 });
    } else if (own?.kcal_day) {
      setTargets({ kcal: own.kcal_day, protein: own.protein_g ?? 0, carbs: own.carbs_g ?? 0, fats: own.fats_g ?? 0 });
    } else {
      setTargets(null);
    }

    const planTargets: Record<string, number> = {};
    (plan?.diet_plan_meal_targets ?? []).forEach((t: any) => {
      planTargets[t.meal_type] = t.kcal_target;
    });

    const dayMeals = ((dayRes.data as any)?.meals ?? []) as any[];
    const sum = { ...EMPTY_TOTALS };
    const summaries = MEALS.map(({ type }) => {
      const items = dayMeals.filter((m) => m.meal_type === type).flatMap((m) => m.meal_items ?? []);
      const kcal = items.reduce((acc: number, item: any) => acc + (item.calories ?? 0), 0);
      items.forEach((item: any) => {
        sum.protein += item.macros?.protein ?? 0;
        sum.carbs += item.macros?.carbs ?? 0;
        sum.fats += item.macros?.fats ?? 0;
      });
      sum.kcal += kcal;
      return { type, kcal, count: items.length, target: planTargets[type] ?? null };
    });

    setTotals(sum);
    setMeals(summaries);
    setHasNutritionist((linkRes.data ?? []).length > 0);
    setUnreadMessages(messagesRes.count ?? 0);
    setLoading(false);
  }, [user]);

  useEffect(() => {
    load();
  }, [load]);

  const now = new Date();
  const firstName = profile?.full_name?.split(" ")[0] ?? "";

  // Il pulsante + apre il pasto dell'ora corrente, oppure il primo ancora vuoto.
  const nextMeal = useMemo(() => {
    const hour = now.getHours();
    const byTime = MEALS.find((m) => hour < m.until)?.type ?? "cena";
    const current = meals.find((m) => m.type === byTime);
    if (!current || current.count === 0) return byTime;
    return meals.find((m) => m.count === 0)?.type ?? byTime;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [meals]);

  const remaining = targets ? Math.round(targets.kcal - totals.kcal) : null;
  const dayPercent = targets?.kcal ? Math.min(100, Math.round((totals.kcal / targets.kcal) * 100)) : 0;

  return (
    <div className="min-h-screen bg-background">
      <MobileHeader title="" showBack={false} />

      <main className="space-y-6 px-4 pb-28 pt-1">
        <div data-tour="home-greeting">
          <h1 className="text-lg font-semibold text-foreground">
            {greetingFor(now.getHours())}{firstName ? `, ${firstName}` : ""}
          </h1>
        </div>

        <MealReminderBanner />

        <section data-tour="home-today" aria-label="La tua giornata" className="rounded-lg bg-card p-4 shadow-card">
          {loading ? (
            <div className="space-y-3">
              <Skeleton className="h-8 w-40" />
              <Skeleton className="h-2 w-full" />
              <Skeleton className="h-16 w-full" />
            </div>
          ) : (
            <>
              <div className="flex items-baseline justify-between gap-3">
                <p className="text-3xl font-semibold tabular-nums text-foreground">
                  {Math.round(totals.kcal)}
                  <span className="ml-1 text-sm font-normal text-muted-foreground">
                    {targets ? `/ ${Math.round(targets.kcal)} kcal` : "kcal oggi"}
                  </span>
                </p>
                {remaining !== null && (
                  <p className={`text-sm tabular-nums ${remaining < 0 ? "font-medium text-destructive" : "text-muted-foreground"}`}>
                    {remaining < 0 ? `${Math.abs(remaining)} in più` : `${remaining} rimaste`}
                  </p>
                )}
              </div>
              {targets && (
                <div className="mt-2 h-2 overflow-hidden rounded-full bg-muted">
                  <div
                    className={`h-full rounded-full transition-[width] duration-500 ${remaining !== null && remaining < 0 ? "bg-destructive" : "bg-primary"}`}
                    style={{ width: `${dayPercent}%` }}
                  />
                </div>
              )}
              <div className="mt-4 grid grid-cols-3 gap-3">
                <MacroBar label="Proteine" value={totals.protein} target={targets?.protein || null} />
                <MacroBar label="Carboidrati" value={totals.carbs} target={targets?.carbs || null} />
                <MacroBar label="Grassi" value={totals.fats} target={targets?.fats || null} />
              </div>
              {!targets && (
                <button
                  onClick={() => navigate("/meals/targets")}
                  className="mt-4 flex w-full items-center justify-between rounded-md bg-muted px-3 py-2.5 text-left text-sm font-medium text-foreground transition-colors hover:bg-muted/70"
                >
                  Imposta i tuoi obiettivi giornalieri
                  <ChevronRight className="h-4 w-4 text-muted-foreground" aria-hidden="true" />
                </button>
              )}
            </>
          )}
        </section>

        <section data-tour="home-meals">
          <div className="mb-2 flex items-baseline justify-between">
            <h2 className="text-base font-semibold text-foreground">Pasti di oggi</h2>
            <button onClick={() => navigate("/meals")} className="text-sm font-medium text-primary-dark hover:underline">
              Apri il diario
            </button>
          </div>
          <ul className="divide-y divide-border overflow-hidden rounded-lg bg-card shadow-card">
            {MEALS.map(({ type, label }) => {
              const meal = meals.find((m) => m.type === type);
              const logged = (meal?.count ?? 0) > 0;
              return (
                <li key={type}>
                  <button
                    onClick={() => navigate(logged ? "/meals" : `/meals?add=${type}`)}
                    className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-ring"
                  >
                    <span className="flex-1">
                      <span className="block text-sm font-medium text-foreground">{label}</span>
                      <span className="block text-xs text-muted-foreground">
                        {logged
                          ? `${meal!.count} ${meal!.count === 1 ? "alimento" : "alimenti"}`
                          : meal?.target
                            ? `Previste ${Math.round(meal.target)} kcal`
                            : "Da registrare"}
                      </span>
                    </span>
                    {logged ? (
                      <span className="text-sm font-medium tabular-nums text-foreground">
                        {Math.round(meal!.kcal)}{meal?.target ? ` / ${Math.round(meal.target)}` : ""} kcal
                      </span>
                    ) : (
                      <span className="inline-flex items-center gap-1 text-sm font-medium text-primary-dark">
                        <Plus className="h-4 w-4" aria-hidden="true" /> Aggiungi
                      </span>
                    )}
                  </button>
                </li>
              );
            })}
          </ul>
        </section>

        <section data-tour="home-actions" aria-label="Azioni rapide" className="grid grid-cols-4 gap-2">
          {ACTIONS.map(({ label, icon: Icon, to }) => (
            <button
              key={to}
              onClick={() => navigate(to)}
              className="flex min-h-[72px] flex-col items-center justify-center gap-1.5 rounded-lg bg-card px-1 py-3 text-center shadow-card transition-colors hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <Icon className="h-5 w-5 text-primary-dark" strokeWidth={1.75} aria-hidden="true" />
              <span className="text-[11px] font-medium leading-tight text-foreground">{label}</span>
            </button>
          ))}
        </section>

        <WeightGoalHomeBar />
        <AutoSuggestFavBanner />

        <section aria-label="Altro">
          <ul className="divide-y divide-border overflow-hidden rounded-lg bg-card shadow-card">
            {hasNutritionist && (
              <>
                <li>
                  <button onClick={() => navigate("/messages")} className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/50">
                    <MessageSquare className="h-5 w-5 shrink-0 text-primary-dark" strokeWidth={1.75} aria-hidden="true" />
                    <span className="flex-1 text-sm font-medium text-foreground">Messaggi del nutrizionista</span>
                    {unreadMessages > 0 && (
                      <span className="rounded-full bg-primary-dark px-2 py-0.5 text-xs font-semibold tabular-nums text-primary-foreground">
                        {unreadMessages > 9 ? "9+" : unreadMessages}
                      </span>
                    )}
                    <ChevronRight className="h-4 w-4 text-muted-foreground" aria-hidden="true" />
                  </button>
                </li>
                <li>
                  <button onClick={() => navigate("/plan")} className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/50">
                    <ClipboardList className="h-5 w-5 shrink-0 text-primary-dark" strokeWidth={1.75} aria-hidden="true" />
                    <span className="flex-1 text-sm font-medium text-foreground">Il tuo piano alimentare</span>
                    <ChevronRight className="h-4 w-4 text-muted-foreground" aria-hidden="true" />
                  </button>
                </li>
              </>
            )}
            <li>
              <button onClick={() => navigate("/clinical")} className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/50">
                <HeartPulse className="h-5 w-5 shrink-0 text-primary-dark" strokeWidth={1.75} aria-hidden="true" />
                <span className="flex-1 text-sm font-medium text-foreground">Scheda salute</span>
                <ChevronRight className="h-4 w-4 text-muted-foreground" aria-hidden="true" />
              </button>
            </li>
            <li>
              <button onClick={() => navigate("/pantry")} className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/50">
                <Package className="h-5 w-5 shrink-0 text-primary-dark" strokeWidth={1.75} aria-hidden="true" />
                <span className="flex-1 text-sm font-medium text-foreground">Dispensa</span>
                <ChevronRight className="h-4 w-4 text-muted-foreground" aria-hidden="true" />
              </button>
            </li>
          </ul>
        </section>
      </main>

      <div className="fixed bottom-[calc(76px+env(safe-area-inset-bottom,0px))] right-4 z-40">
        <button
          onClick={() => navigate(`/meals?add=${nextMeal}`)}
          aria-label="Registra un pasto"
          className="btn-brand flex h-12 w-12 items-center justify-center rounded-full shadow-elevated transition-transform active:scale-95"
        >
          <Plus className="h-5 w-5" strokeWidth={2.2} aria-hidden="true" />
        </button>
      </div>
    </div>
  );
};

export default Index;
