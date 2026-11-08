import { useEffect, useMemo, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { ShieldAlert } from "lucide-react";
import ClinicalForm, { type ClinicalProfile } from "@/components/ClinicalForm";
import EmptyState from "@/components/EmptyState";
import ListSkeleton from "@/components/ListSkeleton";
import MobileHeader from "@/components/MobileHeader";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { supabase } from "@/integrations/supabase/client";
import { ACTIVITY_LEVELS, ageFromBirthDate, estimateEnergyNeeds, type ActivityLevel, type Sex } from "@/lib/energy-needs";

const ProClientClinicalPage = () => {
  const { clientId } = useParams<{ clientId: string }>();
  const navigate = useNavigate();
  const [profile, setProfile] = useState<ClinicalProfile | null>(null);
  const [clientName, setClientName] = useState("");
  const [weight, setWeight] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!clientId) return;
    Promise.all([
      supabase.from("client_clinical_profiles").select("*").eq("client_user_id", clientId).maybeSingle(),
      supabase.from("profiles").select("full_name").eq("id", clientId).maybeSingle(),
      supabase
        .from("body_measurements")
        .select("weight_kg")
        .eq("user_id", clientId)
        .not("weight_kg", "is", null)
        .order("measured_at", { ascending: false })
        .limit(1)
        .maybeSingle(),
    ]).then(([clinicalRes, profileRes, weightRes]) => {
      setProfile(clinicalRes.data as ClinicalProfile | null);
      setClientName(profileRes.data?.full_name || "Cliente");
      if (weightRes.data?.weight_kg != null) setWeight(String(weightRes.data.weight_kg));
      setLoading(false);
    });
  }, [clientId]);

  const needs = useMemo(() => {
    if (!profile?.birth_date || !profile.sex || !profile.height_cm || !profile.activity_level) return null;
    return estimateEnergyNeeds({
      sex: profile.sex as Sex,
      weightKg: Number(weight),
      heightCm: Number(profile.height_cm),
      ageYears: ageFromBirthDate(profile.birth_date),
      activity: profile.activity_level as ActivityLevel,
    });
  }, [profile, weight]);

  if (loading) {
    return (
      <div>
        <MobileHeader title="Scheda clinica" />
        <main className="px-4 py-5"><ListSkeleton count={3} variant="card" /></main>
      </div>
    );
  }

  if (!profile) {
    return (
      <div>
        <MobileHeader title="Scheda clinica" />
        <main className="px-4 py-5">
          <EmptyState
            icon={ShieldAlert}
            title="Manca il consenso del cliente"
            description={`${clientName} deve dare il consenso dalla sua Scheda salute. Dopo potrai vedere e aggiornare i dati.`}
          />
        </main>
      </div>
    );
  }

  const activityLabel = profile.activity_level ? ACTIVITY_LEVELS[profile.activity_level as ActivityLevel]?.label : null;

  return (
    <div>
      <MobileHeader title={`Scheda clinica · ${clientName}`} />
      <main className="grid gap-4 px-4 py-5 lg:grid-cols-[1fr_320px] lg:items-start">
        <section className="rounded-lg bg-card p-4 shadow-card">
          <ClinicalForm profile={profile} onSaved={setProfile} />
        </section>

        <aside className="space-y-4 lg:sticky lg:top-20">
          {(profile.allergies?.length > 0 || profile.intolerances?.length > 0) && (
            <section className="rounded-lg border border-destructive/30 bg-destructive/5 p-4">
              <h2 className="text-sm font-semibold text-foreground">Da escludere dal piano</h2>
              <p className="mt-1 text-sm text-foreground">
                {[...(profile.allergies ?? []), ...(profile.intolerances ?? [])].join(", ")}
              </p>
            </section>
          )}

          <section className="rounded-lg bg-card p-4 shadow-card">
            <h2 className="text-base font-semibold text-foreground">Fabbisogno stimato</h2>
            <div className="mt-3 space-y-1.5">
              <Label htmlFor="clinical-weight">Peso (kg)</Label>
              <Input id="clinical-weight" type="number" inputMode="decimal" value={weight} onChange={(e) => setWeight(e.target.value)} />
            </div>
            {needs ? (
              <>
                <dl className="mt-4 space-y-2">
                  <div className="flex items-baseline justify-between">
                    <dt className="text-sm text-muted-foreground">Metabolismo basale</dt>
                    <dd className="text-sm font-medium tabular-nums text-foreground">{needs.bmr} kcal</dd>
                  </div>
                  <div className="flex items-baseline justify-between">
                    <dt className="text-sm text-muted-foreground">Con attività: {activityLabel?.toLowerCase()}</dt>
                    <dd className="text-xl font-semibold tabular-nums text-foreground">{needs.tdee} kcal</dd>
                  </div>
                </dl>
                <Button className="mt-4 w-full" onClick={() => navigate(`/pro/client/${clientId}/plan?kcal=${needs.tdee}`)}>
                  Usa nel piano
                </Button>
                <p className="mt-2 text-xs leading-snug text-muted-foreground">
                  Stima con la formula di Mifflin-St Jeor, valida per adulti. La valutazione finale spetta a te.
                </p>
              </>
            ) : (
              <p className="mt-3 text-sm text-muted-foreground">
                Per la stima servono peso, data di nascita (solo adulti), sesso, altezza e attività fisica.
              </p>
            )}
          </section>
        </aside>
      </main>
    </div>
  );
};

export default ProClientClinicalPage;
