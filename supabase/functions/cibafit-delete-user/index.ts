import { createClient as createBaseClient } from "https://esm.sh/@supabase/supabase-js@2";
// CibaFit: tutte le query di questa funzione usano lo schema cibafit.
const createClient = (url: string, key: string, options: Record<string, unknown> = {}) =>
  createBaseClient(url, key, { ...options, db: { schema: "cibafit" } });

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });

/**
 * Cancella un account CibaFit: l'utente per se stesso, l'admin per gli altri.
 * Gli account sono condivisi con Cibarius: l'accesso viene rimosso solo se la persona
 * non ha anche un profilo Cibarius, altrimenti spariscono solo i dati CibaFit.
 */
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) return json({ error: "Accesso richiesto" }, 401);

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    const callerClient = createClient(supabaseUrl, Deno.env.get("SUPABASE_ANON_KEY")!, {
      global: { headers: { Authorization: authHeader } },
    });
    const { data: { user: caller } } = await callerClient.auth.getUser();
    if (!caller) return json({ error: "Accesso richiesto" }, 401);

    const adminClient = createClient(supabaseUrl, serviceRoleKey);
    const { data: callerProfile } = await adminClient
      .from("profiles")
      .select("role")
      .eq("id", caller.id)
      .maybeSingle();
    const callerIsAdmin = callerProfile?.role === "admin";

    const body = await req.json().catch(() => ({}));
    const target: string = body?.user_id || caller.id;

    if (target !== caller.id && !callerIsAdmin) {
      return json({ error: "Operazione non consentita" }, 403);
    }
    if (target === caller.id && callerIsAdmin) {
      return json({ error: "Un amministratore non può eliminare il proprio account" }, 400);
    }

    const { data: files, error: dataError } = await adminClient.rpc("delete_account_data", { target });
    if (dataError) {
      console.error("delete_account_data failed", dataError.message);
      return json({ error: "Non è stato possibile eliminare i dati. Riprova." }, 500);
    }

    // I dati sono già eliminati: un file rimasto non deve bloccare il resto, ma va segnalato.
    let filesFailed = 0;
    const byBucket = new Map<string, string[]>();
    for (const file of (files ?? []) as { bucket_id: string; name: string }[]) {
      byBucket.set(file.bucket_id, [...(byBucket.get(file.bucket_id) ?? []), file.name]);
    }
    for (const [bucket, names] of byBucket) {
      const { error } = await adminClient.storage.from(bucket).remove(names);
      if (error) {
        filesFailed += names.length;
        console.error("storage remove failed", bucket, error.message);
      }
    }

    const { data: cibariusProfile, error: cibariusError } = await adminClient
      .schema("public")
      .from("profiles")
      .select("id")
      .eq("id", target)
      .maybeSingle();
    if (cibariusError) {
      console.error("cibarius profile check failed", cibariusError.message);
      return json({ error: "Dati eliminati, ma l'accesso non è stato rimosso. Contatta l'assistenza." }, 500);
    }

    const accountKept = !!cibariusProfile;
    if (!accountKept) {
      const { error } = await adminClient.auth.admin.deleteUser(target);
      if (error) {
        console.error("auth delete failed", error.message);
        return json({ error: "Dati eliminati, ma l'accesso non è stato rimosso. Contatta l'assistenza." }, 500);
      }
    }

    return json({ success: true, account_kept: accountKept, files_failed: filesFailed });
  } catch (e) {
    console.error("delete-user failed", e);
    return json({ error: "Non è stato possibile eliminare l'account. Riprova." }, 500);
  }
});
