/** Data di calendario locale (AAAA-MM-GG): toISOString userebbe l'UTC e sbaglierebbe giorno dopo mezzanotte. */
export function localDateString(date: Date = new Date()): string {
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${date.getFullYear()}-${month}-${day}`;
}
