import { render, screen, waitFor } from "@testing-library/react";
import { MemoryRouter, Route, Routes } from "react-router-dom";
import { describe, expect, it, vi } from "vitest";
import type { ReactElement } from "react";

/** Client finto: ogni query risponde senza dati, come per un utente appena registrato. */
vi.mock("@/integrations/supabase/client", () => {
  const session = { user: { id: "u1", email: "t@example.invalid", user_metadata: {} }, access_token: "t" };
  const query = () => {
    const builder: Record<string, unknown> = {};
    let one = false;
    for (const method of ["select", "eq", "neq", "is", "not", "in", "gte", "lte", "lt", "gt", "ilike", "or", "order", "limit", "range", "insert", "update", "upsert", "delete"]) {
      builder[method] = () => builder;
    }
    builder.single = builder.maybeSingle = () => {
      one = true;
      return builder;
    };
    builder.then = (resolve: (value: unknown) => unknown) => Promise.resolve({ data: one ? null : [], error: null, count: 0 }).then(resolve);
    return builder;
  };
  const channel = () => {
    const c: Record<string, unknown> = {};
    c.on = () => c;
    c.subscribe = () => c;
    return c;
  };
  return {
    SUPABASE_URL: "http://test",
    SUPABASE_PUBLISHABLE_KEY: "test",
    supabase: {
      from: query,
      rpc: async () => ({ data: null, error: null }),
      channel,
      removeChannel: () => undefined,
      functions: { invoke: async () => ({ data: null, error: null }) },
      storage: { from: () => ({ getPublicUrl: () => ({ data: { publicUrl: "" } }) }) },
      auth: {
        getSession: async () => ({ data: { session } }),
        getUser: async () => ({ data: { user: session.user } }),
        onAuthStateChange: () => ({ data: { subscription: { unsubscribe: () => undefined } } }),
        signOut: async () => ({ error: null }),
      },
    },
  };
});

// jsdom non ha IndexedDB: la coda offline non serve per aprire le schermate.
vi.stubGlobal("indexedDB", { open: () => ({}) });

const renderAt = async (element: ReactElement, path = "/", route = "*") => {
  const { AuthProvider } = await import("@/hooks/useAuth");
  const { TourProvider } = await import("@/components/AppTourContext");
  return render(
    <MemoryRouter initialEntries={[path]}>
      <TourProvider>
        <AuthProvider>
          <Routes>
            <Route path={route} element={element} />
          </Routes>
        </AuthProvider>
      </TourProvider>
    </MemoryRouter>,
  );
};

describe("schermate principali senza dati", () => {
  it("la scheda salute chiede il consenso prima di tutto", async () => {
    const { default: Page } = await import("@/pages/UserClinicalPage");
    await renderAt(<Page />);
    expect(await screen.findByText("Prima serve il tuo consenso")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /Do il consenso/ })).toBeDisabled();
  });

  it("il nutrizionista non vede la scheda senza consenso", async () => {
    const { default: Page } = await import("@/pages/pro/ProClientClinicalPage");
    await renderAt(<Page />, "/pro/client/c1/clinical", "/pro/client/:clientId/clinical");
    expect(await screen.findByText("Manca il consenso del cliente")).toBeInTheDocument();
  });

  it("l'abbonamento non promette pagamenti finché sono spenti", async () => {
    const { default: Page } = await import("@/pages/SubscriptionPage");
    await renderAt(<Page />);
    expect(await screen.findByText("Tutte le funzioni sono incluse")).toBeInTheDocument();
  });

  it("le ricette mostrano lo stato vuoto", async () => {
    const { default: Page } = await import("@/pages/PublicRecipesPage");
    await renderAt(<Page />);
    expect(await screen.findByText("Nessuna ricetta trovata")).toBeInTheDocument();
  });

  it.each([
    ["home", () => import("@/pages/Index")],
    ["pasti", () => import("@/pages/PastiPage")],
    ["profilo", () => import("@/pages/ProfiloPage")],
    ["dashboard nutrizionista", () => import("@/pages/pro/ProPage")],
    ["clienti", () => import("@/pages/pro/ProClientsPage")],
    ["note", () => import("@/pages/pro/ProNotesPage")],
  ])("%s si apre senza errori", async (_name, load) => {
    const { default: Page } = await load();
    const { container } = await renderAt(<Page />);
    await waitFor(() => expect(container.textContent?.length ?? 0).toBeGreaterThan(0));
  });
});
