import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import { useSubscription } from "@/hooks/useSubscription";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import MobileHeader from "@/components/MobileHeader";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Loader2, Save, Crown } from "lucide-react";

const MealsTargetsPage = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const navigate = useNavigate();
  const { isActive: plusActive } = useSubscription("user_plus");

  const [kcal, setKcal] = useState("");
  const [protein, setProtein] = useState("");
  const [carbs, setCarbs] = useState("");
  const [fats, setFats] = useState("");
  const [sugars, setSugars] = useState("");
  const [loading, setLoading] = useState(true);
  const [loadFailed, setLoadFailed] = useState(false);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!user) return;
    supabase.from("nutrition_targets").select("*").eq("user_id", user.id).maybeSingle().then(({ data, error }) => {
      if (error) {
        console.error("nutrition_targets load failed:", error);
        setLoadFailed(true);
        toast({ variant: "destructive", title: "Obiettivi non caricati", description: "Non riusciamo a leggere i tuoi obiettivi. Controlla la connessione e riapri la pagina." });
      }
      if (data) {
        setKcal(String(data.kcal_day));
        setProtein(data.protein_g != null ? String(data.protein_g) : "");
        setCarbs(data.carbs_g != null ? String(data.carbs_g) : "");
        setFats(data.fats_g != null ? String(data.fats_g) : "");
        setSugars((data as any).sugars_g != null ? String((data as any).sugars_g) : "");
      }
      setLoading(false);
    });
  }, [user]);

  // An empty field stays empty: it must be sent as null, or the database fills in its own defaults
  const optionalNumber = (value: string) => {
    const parsed = parseFloat(value);
    return Number.isFinite(parsed) ? parsed : null;
  };

  const handleSave = async () => {
    if (!user) return;
    // Saving after a failed read would overwrite targets the user cannot see
    if (loadFailed) {
      toast({ variant: "destructive", title: "Obiettivi non salvati", description: "Non siamo riusciti a leggere quelli attuali. Riapri la pagina e riprova." });
      return;
    }
    const kcalDay = parseFloat(kcal);
    if (!(kcalDay > 0)) {
      toast({ variant: "destructive", title: "Calorie mancanti", description: "Inserisci le calorie giornaliere per salvare gli obiettivi." });
      return;
    }
    setSaving(true);

    const payload = {
      user_id: user.id,
      kcal_day: kcalDay,
      protein_g: optionalNumber(protein),
      carbs_g: optionalNumber(carbs),
      fats_g: optionalNumber(fats),
      sugars_g: optionalNumber(sugars),
      updated_at: new Date().toISOString(),
    };

    const { error } = await supabase.from("nutrition_targets").upsert(payload, { onConflict: "user_id" });
    setSaving(false);

    if (error) {
      console.error("nutrition_targets save failed:", error);
      toast({ variant: "destructive", title: "Obiettivi non salvati", description: "Il salvataggio non è andato a buon fine. Controlla la connessione e riprova." });
    } else {
      toast({ title: "Obiettivi salvati!" });
      navigate("/meals");
    }
  };

  if (loading) {
    return (
      <div>
        <MobileHeader title="Obiettivi" showBack />
        <div className="flex justify-center py-20"><Loader2 className="h-8 w-8 animate-spin text-primary" /></div>
      </div>
    );
  }

  return (
    <div>
      <MobileHeader title="Obiettivi nutrizionali" showBack />

      <main className="px-4 pb-28 space-y-4">
        <div className="rounded-2xl border border-border bg-card p-4 space-y-4">
          <div className="space-y-2">
            <label className="text-sm font-semibold text-foreground">Calorie giornaliere (kcal)</label>
            <Input type="number" value={kcal} onChange={e => setKcal(e.target.value)} className="border-border" />
          </div>
          <div className="space-y-2">
            <label className="text-sm font-semibold text-foreground flex items-center gap-2">
              Proteine (g)
              {!plusActive && <Badge variant="secondary" className="text-[11px]"><Crown className="h-3 w-3 mr-0.5" />Plus</Badge>}
            </label>
            <Input type="number" value={protein} onChange={e => setProtein(e.target.value)} className="border-border" disabled={!plusActive} />
          </div>
          <div className="space-y-2">
            <label className="text-sm font-semibold text-foreground flex items-center gap-2">
              Carboidrati (g)
              {!plusActive && <Badge variant="secondary" className="text-[11px]"><Crown className="h-3 w-3 mr-0.5" />Plus</Badge>}
            </label>
            <Input type="number" value={carbs} onChange={e => setCarbs(e.target.value)} className="border-border" disabled={!plusActive} />
          </div>
          <div className="space-y-2">
            <label className="text-sm font-semibold text-foreground flex items-center gap-2">
              di cui Zuccheri (g)
              {!plusActive && <Badge variant="secondary" className="text-[11px]"><Crown className="h-3 w-3 mr-0.5" />Plus</Badge>}
            </label>
            <Input type="number" value={sugars} onChange={e => setSugars(e.target.value)} className="border-border" disabled={!plusActive} />
          </div>
          <div className="space-y-2">
            <label className="text-sm font-semibold text-foreground flex items-center gap-2">
              Grassi (g)
              {!plusActive && <Badge variant="secondary" className="text-[11px]"><Crown className="h-3 w-3 mr-0.5" />Plus</Badge>}
            </label>
            <Input type="number" value={fats} onChange={e => setFats(e.target.value)} className="border-border" disabled={!plusActive} />
          </div>

          <Button className="w-full h-12 text-base font-bold" onClick={handleSave} disabled={saving}>
            {saving ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Save className="mr-2 h-4 w-4" />}
            Salva obiettivi
          </Button>
        </div>
      </main>
    </div>
  );
};

export default MealsTargetsPage;
