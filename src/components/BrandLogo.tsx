import { cn } from "@/lib/utils";

interface BrandLogoProps {
  className?: string;
}

/** Marchio testuale di CibaFit: un unico punto da aggiornare quando il logo è definitivo. */
const BrandLogo = ({ className }: BrandLogoProps) => (
  <span
    role="img"
    aria-label="CibaFit"
    className={cn("inline-flex items-center font-display text-xl font-semibold leading-none tracking-tight text-foreground", className)}
  >
    CibaFit
  </span>
);

export default BrandLogo;
