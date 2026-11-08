// CibaFit: tutte le query usano lo schema "cibafit", non public (Cibarius).
import { createClient } from '@supabase/supabase-js';
import type { Database } from './types';

const SUPABASE_URL = "https://dqhzopbjhxyhgcpedskl.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRxaHpvcGJqaHh5aGdjcGVkc2tsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE5NDMwNjMsImV4cCI6MjA4NzUxOTA2M30.mkryGdAt1EdgsgXo753ric4cUEjhO1NRK7bfKEyhclU";

// Import the supabase client like this:
// import { supabase } from "@/integrations/supabase/client";

export const supabase = createClient<Database, 'cibafit'>(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
  db: { schema: 'cibafit' },
  auth: {
    storage: localStorage,
    persistSession: true,
    autoRefreshToken: true,
  }
});