import { describe, expect, it } from "vitest";
import { ageFromBirthDate, estimateEnergyNeeds } from "./energy-needs";

describe("estimateEnergyNeeds", () => {
  it("calcola il metabolismo basale maschile con Mifflin-St Jeor", () => {
    // 10*80 + 6.25*180 - 5*30 + 5 = 1780
    const result = estimateEnergyNeeds({ sex: "male", weightKg: 80, heightCm: 180, ageYears: 30, activity: "sedentary" });
    expect(result).toEqual({ bmr: 1780, tdee: 2136 });
  });

  it("calcola il metabolismo basale femminile con Mifflin-St Jeor", () => {
    // 10*60 + 6.25*165 - 5*40 - 161 = 1270.25
    const result = estimateEnergyNeeds({ sex: "female", weightKg: 60, heightCm: 165, ageYears: 40, activity: "moderate" });
    expect(result).toEqual({ bmr: 1270, tdee: 1969 });
  });

  it("non stima per i minori", () => {
    expect(estimateEnergyNeeds({ sex: "female", weightKg: 50, heightCm: 160, ageYears: 17, activity: "light" })).toBeNull();
  });

  it.each([
    ["peso", { weightKg: Number.NaN, heightCm: 170 }],
    ["peso troppo basso", { weightKg: 10, heightCm: 170 }],
    ["altezza in metri", { weightKg: 70, heightCm: 1.7 }],
  ])("rifiuta dati non validi: %s", (_label, values) => {
    expect(estimateEnergyNeeds({ sex: "male", ageYears: 30, activity: "light", ...values })).toBeNull();
  });
});

describe("ageFromBirthDate", () => {
  it("non conta il compleanno non ancora arrivato", () => {
    expect(ageFromBirthDate("1990-06-15", new Date(2026, 5, 14))).toBe(35);
  });

  it("conta il compleanno nel giorno stesso", () => {
    expect(ageFromBirthDate("1990-06-15", new Date(2026, 5, 15))).toBe(36);
  });
});
