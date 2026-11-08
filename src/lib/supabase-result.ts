/**
 * Il client Supabase restituisce `{ error }` senza lanciare, e un update o un delete bloccati dalle
 * regole di accesso (RLS) non danno errore: toccano zero righe. Queste funzioni rendono visibili
 * entrambi i casi, così un salvataggio fallito non può finire in un messaggio di successo.
 */

type ErrorLike = { message: string; code?: string } | null;
type ResultLike<T> = { data: T; error: ErrorLike };

// Basta `from`: le pagine passano il client vero, i test uno finto.
// eslint-disable-next-line @typescript-eslint/no-explicit-any
type ClientLike = { from: (table: any) => any };

export class SupabaseOperationError extends Error {
  code?: string;
  constructor(message: string, code?: string) {
    super(message);
    this.name = "SupabaseOperationError";
    this.code = code;
  }
}

/** Il messaggio resta per i log: all'utente va mostrato un testo scritto per lui. */
export class PlanActivationError extends Error {
  /** false se il piano precedente non è stato riattivato: il cliente può essere senza piano attivo. */
  previousRestored: boolean;
  constructor(message: string, previousRestored: boolean) {
    super(message);
    this.name = "PlanActivationError";
    this.previousRestored = previousRestored;
  }
}

/** Restituisce `data`, oppure lancia se la query ha dato errore. */
export function must<T>(result: ResultLike<T>): T {
  if (result.error) throw new SupabaseOperationError(result.error.message, result.error.code);
  return result.data;
}

/** Come `must`, ma lancia anche se nessuna riga è stata toccata. Richiede `.select()` sulla query. */
export function mustRows<T>(result: ResultLike<T[] | null>): T[] {
  const rows = must(result);
  if (!rows || rows.length === 0) throw new SupabaseOperationError("Nessuna riga modificata");
  return rows;
}

const idsOf = (rows: { id: string }[] | null | undefined) => (rows ?? []).map((row) => row.id);

/**
 * Attiva un piano disattivando gli altri dello stesso ambito. L'indice unico su `diet_plans` vieta
 * due piani attivi per la stessa coppia nutrizionista-cliente: il nuovo può diventare attivo solo
 * dopo la disattivazione del vecchio. Se l'attivazione fallisce, riattiva i piani appena disattivati.
 */
export async function activatePlanExclusive(
  client: ClientLike,
  table: string,
  planId: string,
  scope: Record<string, string>,
): Promise<void> {
  let deactivate = client.from(table).update({ is_active: false });
  for (const [column, value] of Object.entries(scope)) deactivate = deactivate.eq(column, value);
  const previousIds = idsOf(must(await deactivate.eq("is_active", true).neq("id", planId).select("id")));

  const activation = await client.from(table).update({ is_active: true }).eq("id", planId).select("id");
  if (!activation.error && activation.data?.length > 0) return;

  let previousRestored = true;
  if (previousIds.length > 0) {
    const restore = await client.from(table).update({ is_active: true }).in("id", previousIds).select("id");
    previousRestored = !restore.error && restore.data?.length === previousIds.length;
  }
  throw new PlanActivationError(activation.error?.message ?? "Piano non attivato", previousRestored);
}

/**
 * Sostituisce le righe figlie di un record: prima inserisce le nuove, poi cancella le vecchie.
 * Se qualcosa fallisce, le vecchie restano al loro posto.
 */
export async function replaceChildRows(
  client: ClientLike,
  table: string,
  parentColumn: string,
  parentId: string,
  rows: Record<string, unknown>[],
): Promise<void> {
  const previousIds = idsOf(must(await client.from(table).select("id").eq(parentColumn, parentId)));
  const insertedIds = rows.length > 0 ? idsOf(mustRows(await client.from(table).insert(rows).select("id"))) : [];

  if (previousIds.length === 0) return;

  const removal = await client.from(table).delete().in("id", previousIds).select("id");
  if (removal.error || !removal.data?.length) {
    if (insertedIds.length > 0) await client.from(table).delete().in("id", insertedIds);
    throw new SupabaseOperationError(removal.error?.message ?? "Righe precedenti non rimosse", removal.error?.code);
  }
}
