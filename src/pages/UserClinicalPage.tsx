import { useEffect, useState } from "react";
import { Loader2 } from "lucide-react";
import ClinicalForm, { type ClinicalProfile } from "@/components/ClinicalForm";
import ListSkeleton from "@/components/ListSkeleton";
import MobileHeader from "@/components/MobileHeader";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { useAuth } from "@/hooks/useAuth";
import { supabase } from "@/integrations/supabase/client";

const UserClinicalPage = () => {
  const { user } = useAuth();
  const { toast } = useToast();
  const [profile, setProfile] = useState<ClinicalProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [accepted, setAccepted] = useState(false);
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (!user) return;
    supabase
      .from("client_clinical_profiles")
      .select("*")
      .eq("client_user_id", user.id)
      .maybeSingle()
      .then(({ data }) => {
        setProfile(data as ClinicalProfile | null);
        setLoading(false);
      });
  }, [user]);

  const giveConsent = async () => {
    if (!user) return;
    setBusy(true);
    const { data, error } = await supabase
      .from("client_clinical_profiles")
      .insert({ client_user_id: user.id, health_data_consent_at: new Date().toISOString() })
      .select("*")
      .single();
    setBusy(false);
    if (error) {
      toast({ variant: "destructive", title: "Consenso non registrato", description: "Riprova tra qualche istante." });
      return;
    }
    setProfile(data as ClinicalProfile);
  };

  const withdrawConsent = async () => {
    if (!user) return;
    setBusy(true);
    const { error } = await supabase.from("client_clinical_profiles").delete().eq("client_user_id", user.id);
    setBusy(false);
    if (error) {
      toast({ variant: "destructive", title: "Dati non eliminati", description: "Riprova tra qualche istante." });
      return;
    }
    setProfile(null);
    setAccepted(false);
    toast({ title: "Consenso revocato e scheda eliminata" });
  };

  return (
    <div>
      <MobileHeader title="Scheda salute" />
      <main className="space-y-4 px-4 py-5">
        {loading ? (
          <ListSkeleton count={3} variant="card" />
        ) : !profile ? (
          <section className="space-y-4 rounded-lg bg-card p-4 shadow-card">
            <h1 className="text-lg font-semibold text-foreground">Prima serve il tuo consenso</h1>
            <p className="max-w-[65ch] text-sm leading-relaxed text-muted-foreground">
              Allergie, patologie e farmaci sono dati sulla salute. Li usiamo per adattare il tuo piano alimentare e
              li vede solo il nutrizionista a cui sei collegato. Puoi revocare il consenso quando vuoi: la scheda viene eliminata.
            </p>
            <div className="flex items-start gap-3">
              <Checkbox id="clinical-consent" checked={accepted} onCheckedChange={(value) => setAccepted(value === true)} className="mt-0.5" />
              <Label htmlFor="clinical-consent" className="text-sm font-normal leading-snug text-foreground">
                Acconsento al trattamento dei miei dati sulla salute e alla condivisione con il mio nutrizionista.
              </Label>
            </div>
            <Button onClick={giveConsent} disabled={!accepted || busy} className="w-full">
              {busy && <Loader2 className="mr-2 h-4 w-4 animate-spin" aria-hidden="true" />}
              Do il consenso e compilo la scheda
            </Button>
          </section>
        ) : (
          <>
            <section className="rounded-lg bg-card p-4 shadow-card">
              <ClinicalForm profile={profile} onSaved={setProfile} />
            </section>
            <p className="text-xs text-muted-foreground">
              Consenso dato il {new Date(profile.health_data_consent_at!).toLocaleDateString("it-IT")}. CibaFit non sostituisce il parere del medico.
            </p>
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button variant="outline" disabled={busy} className="w-full text-destructive hover:text-destructive">
                  Revoca il consenso ed elimina la scheda
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>Eliminare la scheda salute?</AlertDialogTitle>
                  <AlertDialogDescription>
                    La scheda viene cancellata definitivamente e il tuo nutrizionista non potrà più vederla.
                  </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>Annulla</AlertDialogCancel>
                  <AlertDialogAction onClick={withdrawConsent}>Elimina la scheda</AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          </>
        )}
      </main>
    </div>
  );
};

export default UserClinicalPage;
