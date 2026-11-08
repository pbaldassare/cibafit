import { describe, expect, it } from "vitest";
import { safeNextPath } from "./safe-next";

describe("safeNextPath", () => {
  it("accetta i percorsi interni con parametri", () => {
    expect(safeNextPath("/invite?code=ABC")).toBe("/invite?code=ABC");
  });

  it.each(["https://sito.com", "//sito.com", "/\\sito.com", "/auth/login", "", null, undefined])(
    "rifiuta %s",
    (value) => {
      expect(safeNextPath(value)).toBeNull();
    },
  );
});
