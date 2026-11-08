import { createContext, useContext, useState, useCallback, useRef, ReactNode } from "react";

export type TourActionType = "navigate" | "open-add-food" | "close-add-food" | "scroll" | "wait";

export interface TourAction {
  type: TourActionType;
  target?: string;
  delay?: number;
}

export interface TourStep {
  selector: string;
  title: string;
  description: string;
  page?: string;
  position?: "top" | "bottom" | "left" | "right";
  action?: TourAction;
  duration?: number;
}

export type TourRole = "user" | "professional";

interface TourContextType {
  isActive: boolean;
  currentStep: number;
  steps: TourStep[];
  startTour: (role?: TourRole) => void;
  stopTour: () => void;
  nextStep: () => void;
  prevStep: () => void;
  goToStep: (step: number) => void;
  totalSteps: number;
  registerAddFoodControl: (open: () => void, close: () => void) => void;
  openAddFood: () => void;
  closeAddFood: () => void;
}

const TourContext = createContext<TourContextType | null>(null);

export const useTour = () => {
  const ctx = useContext(TourContext);
  if (!ctx) throw new Error("useTour must be used within TourProvider");
  return ctx;
};

/* ═══════════════ USER TOUR ═══════════════ */
export const USER_TOUR_STEPS: TourStep[] = [
  { selector: "home-greeting", title: "Benvenuto su CibaFit", description: "Qui trovi la tua giornata: calorie, macro, pasti e peso a colpo d'occhio.", page: "/" },
  { selector: "home-today", title: "La tua giornata", description: "Calorie e macronutrienti di oggi rispetto ai tuoi obiettivi o al piano del nutrizionista.", page: "/" },
  { selector: "home-meals", title: "I pasti di oggi", description: "Tocca un pasto per registrarlo. Puoi usare foto, barcode o ricerca.", page: "/" },
  { selector: "home-actions", title: "Azioni rapide", description: "Fotografa un pasto, scansiona un prodotto, chiedi cosa mangiare o sfoglia le ricette.", page: "/" },
  { selector: "nav-meals", title: "Diario pasti", description: "Il diario completo della giornata, con calorie e macro di ogni alimento.", page: "/" },
  { selector: "nav-plan", title: "Piano alimentare", description: "Il piano preparato dal tuo nutrizionista, giorno per giorno.", page: "/" },
  { selector: "nav-progress", title: "Progressi", description: "Peso, misure corporee e andamento nel tempo.", page: "/" },
  { selector: "nav-profile", title: "Profilo", description: "Impostazioni, collegamento con il nutrizionista, messaggi e notifiche.", page: "/" },
];

/* ═══════════════ PROFESSIONAL TOUR ═══════════════ */
export const PRO_TOUR_STEPS: TourStep[] = [
  // Dashboard (/pro) — 5 step
  { selector: "pro-greeting", title: "Benvenuto nella piattaforma Pro! 🩺", description: "Questa è la tua dashboard professionale. Da qui gestisci clienti, piani alimentari, template, appuntamenti, report e comunicazioni in tempo reale.", page: "/pro" },
  { selector: "pro-clients-card", title: "I tuoi clienti 👥", description: "Visualizza il numero di clienti attivi collegati. Un tap ti porta alla lista completa dove puoi gestire piani, monitorare progressi e chattare.", page: "/pro", action: { type: "scroll", target: "pro-clients-card" } },
  { selector: "pro-report-card", title: "Report settimanale 📊", description: "Monitora l'andamento globale dei tuoi clienti: aderenza ai piani, calorie medie, macro rispettati. Report automatici ogni settimana.", page: "/pro", action: { type: "scroll", target: "pro-report-card" } },
  { selector: "pro-quick-actions", title: "Azioni rapide ⚡", description: "Gestisci clienti, accedi ai template di piani alimentari, calendario appuntamenti e traccia i guadagni dai coupon — tutto con un tap.", page: "/pro", action: { type: "scroll", target: "pro-quick-actions" } },
  { selector: "pro-notes-card", title: "Note recenti 📝", description: "Le ultime note sui tuoi clienti: osservazioni cliniche, appunti sulle visite, progressi rilevanti. Tutto organizzato per data e cliente.", page: "/pro", action: { type: "scroll", target: "pro-notes-card" } },

  // Clienti (/pro/clients) — 5 step
  { selector: "pro-clients-page", title: "Lista Clienti 👥", description: "Ecco la lista dei tuoi clienti. Ogni scheda mostra nome, email e badge 'Piano attivo' o 'No piano'. Da qui gestisci tutto il rapporto professionale.", page: "/pro/clients", action: { type: "navigate", target: "/pro/clients", delay: 600 } },
  { selector: "pro-generate-invite", title: "Invitare nuovi clienti 📨", description: "Premi 'Genera invito' per creare un codice univoco. Condividilo con il cliente: potrà usarlo nell'app per collegarsi al tuo profilo professionale.", page: "/pro/clients" },
  { selector: "pro-link-requests", title: "Richieste di collegamento 🔗", description: "I clienti possono anche cercarti nella directory e inviarti una richiesta. Qui le approvi o le rifiuti. All'approvazione, il sistema invia automaticamente il tuo coupon sconto al cliente.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Azioni per cliente 🎯", description: "Per ogni cliente hai 5 azioni rapide: 📋 Piano (obiettivi e piano settimanale), 📈 Monitor (aderenza giornaliera), 💡 Suggerisci (AI consiglia pasti), 🧑‍🍳 Dispensa e 🥗 Ricette del cliente.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Dettaglio cliente (badge) 🏷️", description: "Il badge colorato indica se il cliente ha un piano attivo. Clicca sull'occhio per il dettaglio completo: misurazioni, storico piani, chat e export PDF.", page: "/pro/clients" },

  // Funzionalità dettaglio cliente (spiegate su /pro/clients) — 8 step
  { selector: "pro-clients-page", title: "Piano obiettivi — Step 1 🎯", description: "Dal bottone 'Piano' crei gli obiettivi del cliente in 3 step: 1) Dati base (peso attuale, target, altezza, attività), 2) Calcolo kcal e macro giornalieri, 3) Distribuzione per pasto (colazione, pranzo, cena, spuntini).", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Piano settimanale — 7 giorni 📅", description: "Il piano settimanale copre 7 giorni × 6 pasti. Per ogni pasto scrivi gli alimenti con l'autocomplete intelligente che suggerisce ingredienti con macro pre-calcolati. Puoi duplicare giorni e copiare tra settimane.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Monitor — Aderenza in tempo reale 📈", description: "La pagina Monitor mostra l'aderenza giornaliera del cliente: calorie consumate vs target, macro (proteine, carboidrati, grassi) con barre di confronto. Alert automatici se il cliente è sotto o sopra soglia.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Chat in tempo reale 💬", description: "Messaggistica Realtime integrata. Scrivi al cliente e ricevi risposte istantanee. I messaggi sono organizzati per conversazione e puoi inviare consigli rapidi durante la giornata.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Misurazioni corporee 📐", description: "Registra peso, misure (vita, fianchi, braccia, petto, coscia), percentuale di grasso corporeo e note. Visualizza i trend nel tempo con grafici di progresso.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Suggerisci pasto con AI 🤖", description: "L'AI analizza la dispensa del cliente e suggerisce ricette che rispettano il piano alimentare. Tieni conto degli ingredienti disponibili e delle preferenze.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Dispensa e ricette del cliente 🏠", description: "Vedi cosa ha il cliente in casa: prodotti in frigo, freezer e dispensa con scadenze. Suggerisci ricette anti-spreco basate sugli ingredienti reali.", page: "/pro/clients" },
  { selector: "pro-clients-page", title: "Storico piani e PDF 📄", description: "Consulta tutti i piani precedenti del cliente. Ogni piano può essere esportato in PDF professionale con logo, macro e indicazioni per pasto.", page: "/pro/clients" },

  // Template (/pro/templates) — 4 step
  { selector: "pro-templates-page", title: "Libreria Template 📋", description: "I template sono piani alimentari riutilizzabili. Creali una volta, applicali a più clienti. Ogni template ha kcal, macro e distribuzione per pasto.", page: "/pro/templates", action: { type: "navigate", target: "/pro/templates", delay: 600 } },
  { selector: "pro-templates-page", title: "Creare un template ✏️", description: "Premi 'Crea template' per definire kcal giornaliere, proteine, carboidrati e grassi. Poi nell'editor aggiungi la distribuzione per pasto con alimenti specifici.", page: "/pro/templates" },
  { selector: "pro-templates-page", title: "Importa e duplica 📥", description: "Importa template da file PDF o CSV: l'AI estrae automaticamente macro e pasti. Oppure duplica template di base pre-configurati e personalizzali.", page: "/pro/templates" },
  { selector: "pro-templates-page", title: "Applicare ai clienti 🎯", description: "Dalla scheda cliente, applica un template al piano alimentare. I macro vengono copiati e puoi personalizzare gli alimenti per ogni giorno della settimana.", page: "/pro/templates" },

  // Appuntamenti (/pro/appointments) — 2 step
  { selector: "pro-appointments-page", title: "Calendario appuntamenti 📅", description: "Gestisci le visite con i clienti. Vedi i prossimi appuntamenti e lo storico completo. Ogni appuntamento ha data, ora, cliente e note.", page: "/pro/appointments", action: { type: "navigate", target: "/pro/appointments", delay: 600 } },
  { selector: "pro-appointments-page", title: "Nuovo appuntamento ➕", description: "Premi il + per creare: seleziona il cliente dalla lista, scegli data e ora con il calendario, aggiungi titolo (visita, controllo, follow-up) e note.", page: "/pro/appointments" },

  // Report e Coupon — 2 step
  { selector: "pro-nav-reports", title: "Report settimanale 📊", description: "Il tab Report mostra l'aderenza globale dei clienti ai piani alimentari: chi è in target, chi è sotto, chi non ha registrato pasti. Utile per le sessioni di follow-up.", page: "/pro/appointments" },
  { selector: "pro-nav-dashboard", title: "Guadagni Coupon 💰", description: "Dalla dashboard accedi ai 'Guadagni Coupon': traccia quanti clienti hanno usato il tuo codice sconto, lo sconto applicato, la tua commissione e lo stato dei pagamenti.", page: "/pro/appointments" },

  // Bottom Nav — 1 step
  { selector: "pro-nav-clients", title: "Navigazione 🧭", description: "Usa la barra in basso per navigare: Dashboard (panoramica), Clienti (gestione completa), Report (aderenza), Note (appunti professionali) e Profilo (impostazioni e visibilità).", page: "/pro/appointments" },

  // Finale
  { selector: "pro-greeting", title: "Grazie per la tua attenzione! 🎊", description: "Ora conosci tutte le funzionalità della piattaforma Pro: gestione clienti, piani alimentari con autocomplete, monitoraggio in tempo reale, chat, template e appuntamenti. Inizia invitando i tuoi primi clienti! 💪", page: "/pro", action: { type: "navigate", target: "/pro", delay: 400 } },
];

/** Legacy alias */
export const TOUR_STEPS = USER_TOUR_STEPS;

export function getTourSteps(role: TourRole): TourStep[] {
  switch (role) {
    case "professional": return PRO_TOUR_STEPS;
    default: return USER_TOUR_STEPS;
  }
}

export const TourProvider = ({ children }: { children: ReactNode }) => {
  const [isActive, setIsActive] = useState(false);
  const [currentStep, setCurrentStep] = useState(0);
  const [steps, setSteps] = useState<TourStep[]>(USER_TOUR_STEPS);
  const stepsRef = useRef(steps);
  stepsRef.current = steps;
  const addFoodOpenRef = useRef<(() => void) | null>(null);
  const addFoodCloseRef = useRef<(() => void) | null>(null);

  const registerAddFoodControl = useCallback((open: () => void, close: () => void) => {
    addFoodOpenRef.current = open;
    addFoodCloseRef.current = close;
  }, []);

  const openAddFood = useCallback(() => { addFoodOpenRef.current?.(); }, []);
  const closeAddFood = useCallback(() => { addFoodCloseRef.current?.(); }, []);

  const startTour = useCallback((role?: TourRole) => {
    const tourSteps = getTourSteps(role ?? "user");
    setSteps(tourSteps);
    stepsRef.current = tourSteps;
    setCurrentStep(0);
    setIsActive(true);
  }, []);

  const stopTour = useCallback(() => {
    setIsActive(false);
    setCurrentStep(0);
    localStorage.setItem("cibarius_tour_done", "1");
    addFoodCloseRef.current?.();
  }, []);

  const nextStep = useCallback(() => {
    setCurrentStep(prev => {
      if (prev >= stepsRef.current.length - 1) {
        setIsActive(false);
        localStorage.setItem("cibarius_tour_done", "1");
        addFoodCloseRef.current?.();
        return 0;
      }
      return prev + 1;
    });
  }, []);

  const prevStep = useCallback(() => {
    setCurrentStep(prev => Math.max(0, prev - 1));
  }, []);

  const goToStep = useCallback((step: number) => {
    setCurrentStep(step);
  }, []);

  return (
    <TourContext.Provider value={{
      isActive, currentStep, steps, startTour, stopTour, nextStep, prevStep, goToStep,
      totalSteps: steps.length,
      registerAddFoodControl, openAddFood, closeAddFood,
    }}>
      {children}
    </TourContext.Provider>
  );
};
