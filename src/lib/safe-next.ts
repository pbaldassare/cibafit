/** Accetta solo percorsi interni: un valore come //sito.com o https://... porterebbe fuori dall'app. */
export function safeNextPath(value: string | null | undefined): string | null {
  if (!value || !value.startsWith("/") || value.startsWith("//") || value.startsWith("/\\")) return null;
  if (value.startsWith("/auth/")) return null;
  return value;
}
