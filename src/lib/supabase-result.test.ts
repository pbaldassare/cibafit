import { describe, expect, it } from "vitest";
import {
  activatePlanExclusive,
  must,
  mustRows,
  PlanActivationError,
  replaceChildRows,
  SupabaseOperationError,
} from "./supabase-result";

type Row = Record<string, unknown> & { id: string };
type Failure = { op: "insert" | "update" | "delete" | "select"; when?: (query: FakeQuery) => boolean };

/** Tabella in memoria con le stesse regole del database: un solo piano attivo per ambito. */
class FakeQuery {
  op: Failure["op"] = "select";
  values: Record<string, unknown> | Record<string, unknown>[] = {};
  filters: ((row: Row) => boolean)[] = [];

  constructor(private db: FakeDb) {}

  select() { return this; }
  insert(values: Record<string, unknown>[]) { this.op = "insert"; this.values = values; return this; }
  update(values: Record<string, unknown>) { this.op = "update"; this.values = values; return this; }
  delete() { this.op = "delete"; return this; }
  eq(column: string, value: unknown) { this.filters.push((r) => r[column] === value); return this; }
  neq(column: string, value: unknown) { this.filters.push((r) => r[column] !== value); return this; }
  in(column: string, values: unknown[]) { this.filters.push((r) => values.includes(r[column])); return this; }

  then<T>(resolve: (result: { data: unknown; error: { message: string } | null }) => T) {
    return Promise.resolve(resolve(this.db.run(this)));
  }
}

class FakeDb {
  failures: Failure[] = [];
  private nextId = 1;
  constructor(public rows: Row[], private exclusiveActive = false) {}

  from = (_table: string) => new FakeQuery(this);

  run(query: FakeQuery) {
    const failure = this.failures.find((f) => f.op === query.op && (!f.when || f.when(query)));
    if (failure) return { data: null, error: { message: `${query.op} fallito` } };

    const matching = this.rows.filter((row) => query.filters.every((filter) => filter(row)));
    if (query.op === "select") return { data: matching.map((r) => ({ id: r.id })), error: null };
    if (query.op === "insert") {
      const inserted = (query.values as Record<string, unknown>[]).map((v) => ({ id: `new-${this.nextId++}`, ...v }));
      this.rows.push(...inserted);
      return { data: inserted.map((r) => ({ id: r.id })), error: null };
    }
    if (query.op === "delete") {
      this.rows = this.rows.filter((row) => !matching.includes(row));
      return { data: matching.map((r) => ({ id: r.id })), error: null };
    }
    const values = query.values as Record<string, unknown>;
    if (this.exclusiveActive && values.is_active === true) {
      const conflict = this.rows.some((r) => r.is_active === true && !matching.includes(r));
      if (conflict) return { data: null, error: { message: "duplicate key" } };
    }
    matching.forEach((row) => Object.assign(row, values));
    return { data: matching.map((r) => ({ id: r.id })), error: null };
  }

  active() {
    return this.rows.filter((r) => r.is_active === true).map((r) => r.id);
  }
}

const planDb = () =>
  new FakeDb(
    [
      { id: "vecchio", professional_id: "pro", client_user_id: "cli", is_active: true },
      { id: "nuovo", professional_id: "pro", client_user_id: "cli", is_active: false },
    ],
    true,
  );
const scope = { professional_id: "pro", client_user_id: "cli" };
const activatesNew = (query: FakeQuery) => (query.values as Record<string, unknown>).is_active === true;

describe("must", () => {
  it("restituisce i dati se non c'è errore", () => {
    expect(must({ data: [1], error: null })).toEqual([1]);
  });

  it("lancia se c'è un errore", () => {
    expect(() => must({ data: null, error: { message: "negato", code: "42501" } })).toThrow(SupabaseOperationError);
  });
});

describe("mustRows", () => {
  it("restituisce le righe toccate", () => {
    expect(mustRows({ data: [{ id: "a" }], error: null })).toEqual([{ id: "a" }]);
  });

  it("lancia se le regole di accesso hanno lasciato fuori tutte le righe", () => {
    expect(() => mustRows({ data: [], error: null })).toThrow(SupabaseOperationError);
    expect(() => mustRows({ data: null, error: null })).toThrow(SupabaseOperationError);
  });
});

describe("activatePlanExclusive", () => {
  it("lascia attivo solo il piano scelto, rispettando l'indice unico", async () => {
    const db = planDb();
    await activatePlanExclusive(db, "diet_plans", "nuovo", scope);
    expect(db.active()).toEqual(["nuovo"]);
  });

  it("non tocca i piani fuori ambito", async () => {
    const db = new FakeDb([
      { id: "altro", professional_id: "altro-pro", client_user_id: "cli", is_active: true },
      { id: "nuovo", professional_id: "pro", client_user_id: "cli", is_active: false },
    ]);
    await activatePlanExclusive(db, "diet_plans", "nuovo", scope);
    expect(db.active().sort()).toEqual(["altro", "nuovo"]);
  });

  it("funziona anche se il piano scelto è già attivo", async () => {
    const db = planDb();
    await activatePlanExclusive(db, "diet_plans", "vecchio", scope);
    expect(db.active()).toEqual(["vecchio"]);
  });

  it("se la disattivazione fallisce non cambia nulla", async () => {
    const db = planDb();
    db.failures = [{ op: "update" }];
    await expect(activatePlanExclusive(db, "diet_plans", "nuovo", scope)).rejects.toThrow(SupabaseOperationError);
    expect(db.active()).toEqual(["vecchio"]);
  });

  it("se l'attivazione fallisce riattiva il piano precedente", async () => {
    const db = planDb();
    let attempts = 0;
    db.failures = [{ op: "update", when: (q) => activatesNew(q) && ++attempts === 1 }];
    const error = await activatePlanExclusive(db, "diet_plans", "nuovo", scope).catch((e) => e);
    expect(error).toBeInstanceOf(PlanActivationError);
    expect(error.previousRestored).toBe(true);
    expect(db.active()).toEqual(["vecchio"]);
  });

  it("se le regole di accesso bloccano l'attivazione (zero righe) la considera fallita", async () => {
    const db = planDb();
    const error = await activatePlanExclusive(db, "diet_plans", "inesistente", scope).catch((e) => e);
    expect(error).toBeInstanceOf(PlanActivationError);
    expect(db.active()).toEqual(["vecchio"]);
  });

  it("segnala quando non riesce nemmeno a riattivare il precedente", async () => {
    const db = planDb();
    db.failures = [{ op: "update", when: activatesNew }];
    const error = await activatePlanExclusive(db, "diet_plans", "nuovo", scope).catch((e) => e);
    expect(error).toBeInstanceOf(PlanActivationError);
    expect(error.previousRestored).toBe(false);
  });
});

describe("replaceChildRows", () => {
  const itemsDb = () => new FakeDb([{ id: "a", plan: "p1", food: "pasta" }, { id: "b", plan: "p2", food: "riso" }]);
  const foods = (db: FakeDb) => db.rows.map((r) => r.food);

  it("sostituisce solo le righe del record indicato", async () => {
    const db = itemsDb();
    await replaceChildRows(db, "items", "plan", "p1", [{ plan: "p1", food: "pollo" }]);
    expect(foods(db).sort()).toEqual(["pollo", "riso"]);
  });

  it("con una lista vuota cancella le vecchie righe", async () => {
    const db = itemsDb();
    await replaceChildRows(db, "items", "plan", "p1", []);
    expect(foods(db)).toEqual(["riso"]);
  });

  it("se l'inserimento fallisce le vecchie righe restano", async () => {
    const db = itemsDb();
    db.failures = [{ op: "insert" }];
    await expect(replaceChildRows(db, "items", "plan", "p1", [{ plan: "p1", food: "pollo" }])).rejects.toThrow(
      SupabaseOperationError,
    );
    expect(foods(db).sort()).toEqual(["pasta", "riso"]);
  });

  it("se la cancellazione fallisce toglie le nuove righe e tiene le vecchie", async () => {
    const db = itemsDb();
    let attempts = 0;
    db.failures = [{ op: "delete", when: () => ++attempts === 1 }];
    await expect(replaceChildRows(db, "items", "plan", "p1", [{ plan: "p1", food: "pollo" }])).rejects.toThrow(
      SupabaseOperationError,
    );
    expect(foods(db).sort()).toEqual(["pasta", "riso"]);
  });

  it("se non ci sono righe precedenti si limita a inserire", async () => {
    const db = new FakeDb([]);
    await replaceChildRows(db, "items", "plan", "p1", [{ plan: "p1", food: "pollo" }]);
    expect(foods(db)).toEqual(["pollo"]);
  });
});
