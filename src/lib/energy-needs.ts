export type Sex = "female" | "male";
export type ActivityLevel = "sedentary" | "light" | "moderate" | "active" | "very_active";

export const ACTIVITY_LEVELS: Record<ActivityLevel, { label: string; factor: number }> = {
  sedentary: { label: "Sedentario", factor: 1.2 },
  light: { label: "Leggermente attivo", factor: 1.375 },
  moderate: { label: "Moderatamente attivo", factor: 1.55 },
  active: { label: "Molto attivo", factor: 1.725 },
  very_active: { label: "Estremamente attivo", factor: 1.9 },
};

export interface EnergyInput {
  sex: Sex;
  weightKg: number;
  heightCm: number;
  ageYears: number;
  activity: ActivityLevel;
}

export interface EnergyNeeds {
  /** Metabolismo basale stimato, kcal/giorno. */
  bmr: number;
  /** Fabbisogno totale stimato, kcal/giorno. */
  tdee: number;
}

/** Anni compiuti alla data indicata. */
export function ageFromBirthDate(birthDate: string, on: Date = new Date()): number {
  const birth = new Date(`${birthDate}T00:00:00`);
  let age = on.getFullYear() - birth.getFullYear();
  const beforeBirthday =
    on.getMonth() < birth.getMonth() || (on.getMonth() === birth.getMonth() && on.getDate() < birth.getDate());
  if (beforeBirthday) age -= 1;
  return age;
}

/**
 * Stima con l'equazione di Mifflin-St Jeor. Restituisce null se mancano dati o
 * sono fuori dall'intervallo per adulti: la formula non vale per i minori.
 */
export function estimateEnergyNeeds({ sex, weightKg, heightCm, ageYears, activity }: EnergyInput): EnergyNeeds | null {
  const valid =
    Number.isFinite(weightKg) && weightKg >= 30 && weightKg <= 300 &&
    Number.isFinite(heightCm) && heightCm >= 120 && heightCm <= 250 &&
    Number.isFinite(ageYears) && ageYears >= 18 && ageYears <= 110 &&
    ACTIVITY_LEVELS[activity] !== undefined;
  if (!valid) return null;

  const base = 10 * weightKg + 6.25 * heightCm - 5 * ageYears;
  const bmr = sex === "male" ? base + 5 : base - 161;
  return {
    bmr: Math.round(bmr),
    tdee: Math.round(bmr * ACTIVITY_LEVELS[activity].factor),
  };
}
