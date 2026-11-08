import { createClient as createBaseClient } from "https://esm.sh/@supabase/supabase-js@2";
// CibaFit: tutte le query di questa funzione usano lo schema cibafit.
const createClient = (url: string, key: string, options: Record<string, unknown> = {}) =>
  createBaseClient(url, key, { ...options, db: { schema: "cibafit" } });

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type, x-supabase-client-platform, x-supabase-client-platform-version, x-supabase-client-runtime, x-supabase-client-runtime-version",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) throw new Error("Missing auth");

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    // Verify caller is admin
    const callerClient = createClient(supabaseUrl, Deno.env.get("SUPABASE_ANON_KEY")!, {
      global: { headers: { Authorization: authHeader } },
    });
    const { data: { user: caller } } = await callerClient.auth.getUser();
    if (!caller) throw new Error("Unauthorized");

    const adminClient = createClient(supabaseUrl, serviceRoleKey);
    const { data: profile } = await adminClient.from("profiles").select("role").eq("id", caller.id).single();
    if (profile?.role !== "admin") throw new Error("Forbidden");

    const { email, password, full_name, role } = await req.json();
    if (!email || !password) throw new Error("email and password required");

    const validRoles = ["user", "professional", "admin"];
    const userRole = validRoles.includes(role) ? role : "user";

    // Create auth user with email confirmed
    const { data: newUser, error: createError } = await adminClient.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      // La chiave cibafit evita che il trigger di Cibarius crei un profilo anche lì.
      user_metadata: { full_name: full_name || "", email, cibafit: { role: userRole, full_name: full_name || "" } },
    });
    if (createError) throw createError;

    if (newUser.user) {
      const { error: profileError } = await adminClient
        .from("profiles")
        .upsert({ id: newUser.user.id, email, full_name: full_name || "", role: userRole });
      if (profileError) throw profileError;

      if (userRole === "professional") {
        const slug = `${(full_name || "nutrizionista").toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "") || "nutrizionista"}-${newUser.user.id.slice(0, 6)}`;
        const { error: proError } = await adminClient
          .from("professional_profiles")
          .insert({ user_id: newUser.user.id, display_name: full_name || "", specialization: "", public_slug: slug });
        if (proError) throw proError;
      }
    }

    return new Response(JSON.stringify({ success: true, user_id: newUser.user?.id }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: e.message }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
