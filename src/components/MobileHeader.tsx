import { ChevronLeft } from "lucide-react";
import { useLocation, useNavigate } from "react-router-dom";
import { useIsMobile } from "@/hooks/use-mobile";
import BrandLogo from "@/components/BrandLogo";
import UserNotificationsBell from "@/components/UserNotificationsBell";

interface MobileHeaderProps {
  title: string;
  showBack?: boolean;
  right?: React.ReactNode;
  hideNotifications?: boolean;
}

const MobileHeader = ({ title, showBack = true, right, hideNotifications = false }: MobileHeaderProps) => {
  const navigate = useNavigate();
  const { pathname } = useLocation();
  const isMobile = useIsMobile();

  // Su computer l'area nutrizionista ha la barra laterale: qui serve solo il titolo della pagina.
  if (pathname.startsWith("/pro") && !isMobile) {
    return (
      <header className="sticky top-0 z-40 flex h-14 items-center gap-2 border-b border-border bg-background/95 px-4 backdrop-blur">
        {showBack && (
          <button
            onClick={() => navigate(-1)}
            aria-label="Indietro"
            className="rounded-md p-1 text-muted-foreground transition-colors hover:bg-muted hover:text-foreground"
          >
            <ChevronLeft size={20} strokeWidth={2} />
          </button>
        )}
        <h1 className="flex-1 truncate text-base font-semibold text-foreground">{title}</h1>
        {right}
        {!hideNotifications && <UserNotificationsBell />}
      </header>
    );
  }

  return (
    <header className="sticky top-0 z-40 flex h-12 items-center bg-[hsl(var(--shell))] px-4 text-white">
      <div className="flex w-10 items-center">
        {showBack && (
          <button onClick={() => navigate(-1)} aria-label="Indietro" className="-ml-1 p-1 text-white/90 transition-opacity active:opacity-70">
            <ChevronLeft size={22} strokeWidth={2} />
          </button>
        )}
      </div>
      <div className="flex flex-1 items-center justify-center">
        <BrandLogo className="text-lg text-white" />
      </div>
      <div className="flex min-w-10 items-center justify-end gap-1">
        {right}
        {!hideNotifications && <UserNotificationsBell />}
      </div>
    </header>
  );
};

export default MobileHeader;
