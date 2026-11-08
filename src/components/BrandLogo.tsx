import { cn } from "@/lib/utils";

interface BrandLogoProps {
  className?: string;
}

/**
 * Marchio CibaFit: il piatto aperto a forma di C con il punto cedro, più il nome.
 * Il nome prende il colore del testo intorno; la dimensione segue il corpo del testo.
 */
const BrandLogo = ({ className }: BrandLogoProps) => (
  <span
    role="img"
    aria-label="CibaFit"
    className={cn("inline-flex items-center gap-[0.4em] font-display text-xl font-semibold leading-none tracking-tight text-foreground", className)}
  >
    <svg viewBox="0 0 44 44" className="h-[1.5em] w-[1.5em] shrink-0" aria-hidden="true">
      <rect width="44" height="44" rx="10" fill="#0B3B3C" />
      <path d="M31 13.5A12.5 12.5 0 1 0 31 30.5" fill="none" stroke="#fff" strokeWidth="4.5" strokeLinecap="round" />
      <circle cx="31.5" cy="22" r="3.6" fill="#D9E021" />
    </svg>
    CibaFit
  </span>
);

export default BrandLogo;
