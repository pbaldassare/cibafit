import { describe, expect, it } from "vitest";
import { localDateString } from "./date";

describe("localDateString", () => {
  it("usa il giorno locale anche subito dopo mezzanotte", () => {
    expect(localDateString(new Date(2026, 10, 9, 0, 30))).toBe("2026-11-09");
  });

  it("aggiunge gli zeri a mese e giorno", () => {
    expect(localDateString(new Date(2026, 0, 5, 12))).toBe("2026-01-05");
  });
});
