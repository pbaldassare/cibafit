# CibaFit

App React + Vite derivata da Cibarius. Condivide il progetto Supabase `dqhzopbjhxyhgcpedskl`
con Cibarius **in produzione**, ma usa solo lo schema `cibafit`.

## Regole per non rompere Cibarius

- Lo schema `public` e le funzioni senza prefisso appartengono a Cibarius: non si toccano da qui.
- **Non eseguire `supabase db push`**: le vecchie migrazioni in `supabase/migrations` puntano a `public`.
  Le modifiche a CibaFit si applicano una per una e solo su `cibafit`.
- Le Edge Functions hanno il prefisso `cibafit-`. Deploy solo per nome:
  `supabase functions deploy cibafit-<nome> --project-ref dqhzopbjhxyhgcpedskl --use-api`.
- I file usano solo i bucket `cibafit-*`. Resta condiviso con Cibarius `auth.users`: gli account sono gli stessi.

## Avvio locale

```sh
npm install
npm run dev
```

Variabili: vedi `.env.example`. Per le mappe serve `VITE_GOOGLE_MAPS_KEY`.

Il database richiede che `cibafit` sia tra gli "Exposed schemas" (Supabase > Data API).

## Funzioni non deployate di proposito

- `cibafit-create-checkout-session`, `cibafit-stripe-webhook`, `cibafit-process-coupon-payment`:
  usano le chiavi Stripe live di Cibarius, serve una configurazione separata.
- `cibafit-delete-user`, `cibafit-create-user`: agiscono sull'account condiviso con Cibarius.
- `cibafit-send-email`, `cibafit-send-expiry-alerts`, `cibafit-auth-email-hook`: email ancora a nome Cibarius.
- `cibafit-seed-template-recipes`, `cibafit-seed-off-products`, `cibafit-extract-product`.
