import { useEffect, useState, type FormEvent } from "react";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { supabase } from "@/integrations/supabase/client";
import { ACTIVITY_LEVELS, type ActivityLevel, type Sex } from "@/lib/energy-needs";

export interface ClinicalProfile {
  client_user_id: string;
  health_data_consent_at: string | null;
  birth_date: string | null;
  sex: string | null;
  height_cm: number | null;
  activity_level: string | null;
  goal: string | null;
  allergies: string[];
  intolerances: string[];
  conditions: string | null;
  medications: string | null;
  dietary_preferences: string | null;
  notes: string | null;
}

const toList = (value: string) =>
  value
    .split(",")
    .map((entry) => entry.trim())
    .filter(Boolean);

interface ClinicalFormProps {
  profile: ClinicalProfile;
  onSaved: (profile: ClinicalProfile) => void;
}

const ClinicalForm = ({ profile, onSaved }: ClinicalFormProps) => {
  const { toast } = useToast();
  const [saving, setSaving] = useState(false);
  const [birthDate, setBirthDate] = useState("");
  const [sex, setSex] = useState<Sex | "">("");
  const [height, setHeight] = useState("");
  const [activity, setActivity] = useState<ActivityLevel | "">("");
  const [goal, setGoal] = useState("");
  const [allergies, setAllergies] = useState("");
  const [intolerances, setIntolerances] = useState("");
  const [conditions, setConditions] = useState("");
  const [medications, setMedications] = useState("");
  const [preferences, setPreferences] = useState("");
  const [notes, setNotes] = useState("");

  useEffect(() => {
    setBirthDate(profile.birth_date ?? "");
    setSex((profile.sex as Sex) ?? "");
    setHeight(profile.height_cm != null ? String(profile.height_cm) : "");
    setActivity((profile.activity_level as ActivityLevel) ?? "");
    setGoal(profile.goal ?? "");
    setAllergies((profile.allergies ?? []).join(", "));
    setIntolerances((profile.intolerances ?? []).join(", "));
    setConditions(profile.conditions ?? "");
    setMedications(profile.medications ?? "");
    setPreferences(profile.dietary_preferences ?? "");
    setNotes(profile.notes ?? "");
  }, [profile]);

  const handleSubmit = async (event: FormEvent) => {
    event.preventDefault();
    setSaving(true);
    const { data, error } = await supabase
      .from("client_clinical_profiles")
      .update({
        birth_date: birthDate || null,
        sex: sex || null,
        height_cm: height ? Number(height) : null,
        activity_level: activity || null,
        goal: goal.trim() || null,
        allergies: toList(allergies),
        intolerances: toList(intolerances),
        conditions: conditions.trim() || null,
        medications: medications.trim() || null,
        dietary_preferences: preferences.trim() || null,
        notes: notes.trim() || null,
      })
      .eq("client_user_id", profile.client_user_id)
      .select("*")
      .single();
    setSaving(false);
    if (error) {
      toast({ variant: "destructive", title: "Scheda non salvata", description: "Controlla i dati inseriti e riprova." });
      return;
    }
    toast({ title: "Scheda salvata" });
    onSaved(data as ClinicalProfile);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="clinical-birth">Data di nascita</Label>
          <Input id="clinical-birth" type="date" value={birthDate} onChange={(e) => setBirthDate(e.target.value)} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="clinical-sex">Sesso biologico</Label>
          <Select value={sex} onValueChange={(value) => setSex(value as Sex)}>
            <SelectTrigger id="clinical-sex"><SelectValue placeholder="Seleziona" /></SelectTrigger>
            <SelectContent>
              <SelectItem value="female">Femmina</SelectItem>
              <SelectItem value="male">Maschio</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="clinical-height">Altezza (cm)</Label>
          <Input id="clinical-height" type="number" inputMode="decimal" min={50} max={260} value={height} onChange={(e) => setHeight(e.target.value)} />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="clinical-activity">Attività fisica</Label>
          <Select value={activity} onValueChange={(value) => setActivity(value as ActivityLevel)}>
            <SelectTrigger id="clinical-activity"><SelectValue placeholder="Seleziona" /></SelectTrigger>
            <SelectContent>
              {Object.entries(ACTIVITY_LEVELS).map(([value, { label }]) => (
                <SelectItem key={value} value={value}>{label}</SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="clinical-goal">Obiettivo</Label>
        <Input id="clinical-goal" value={goal} onChange={(e) => setGoal(e.target.value)} placeholder="Es. perdere 5 kg, aumentare la massa" />
      </div>
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="clinical-allergies">Allergie</Label>
          <Input id="clinical-allergies" value={allergies} onChange={(e) => setAllergies(e.target.value)} placeholder="Separate da virgola" />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="clinical-intolerances">Intolleranze</Label>
          <Input id="clinical-intolerances" value={intolerances} onChange={(e) => setIntolerances(e.target.value)} placeholder="Separate da virgola" />
        </div>
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="clinical-conditions">Patologie</Label>
        <Textarea id="clinical-conditions" rows={2} value={conditions} onChange={(e) => setConditions(e.target.value)} />
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="clinical-medications">Farmaci e integratori</Label>
        <Textarea id="clinical-medications" rows={2} value={medications} onChange={(e) => setMedications(e.target.value)} />
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="clinical-preferences">Preferenze alimentari</Label>
        <Textarea id="clinical-preferences" rows={2} value={preferences} onChange={(e) => setPreferences(e.target.value)} placeholder="Es. vegetariana, non mangia pesce" />
      </div>
      <div className="space-y-1.5">
        <Label htmlFor="clinical-notes">Note</Label>
        <Textarea id="clinical-notes" rows={3} value={notes} onChange={(e) => setNotes(e.target.value)} />
      </div>

      <Button type="submit" disabled={saving} className="w-full sm:w-auto">
        {saving && <Loader2 className="mr-2 h-4 w-4 animate-spin" aria-hidden="true" />}
        Salva scheda
      </Button>
    </form>
  );
};

export default ClinicalForm;
