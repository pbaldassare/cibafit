import { NavLink, Outlet, useNavigate } from "react-router-dom";
import {
  BarChart3,
  BookmarkCheck,
  CalendarDays,
  LayoutDashboard,
  LogOut,
  MessageSquare,
  Ticket,
  User,
  Users,
  type LucideIcon,
} from "lucide-react";
import AppTour from "./AppTour";
import AppTourPrompt from "./AppTourPrompt";
import BottomNav from "./BottomNav";
import BrandLogo from "./BrandLogo";
import { useIsMobile } from "@/hooks/use-mobile";
import { useAuth } from "@/hooks/useAuth";

const NAV_ITEMS: { to: string; icon: LucideIcon; label: string; end?: boolean; tourId?: string }[] = [
  { to: "/pro", icon: LayoutDashboard, label: "Dashboard", end: true, tourId: "pro-nav-dashboard" },
  { to: "/pro/clients", icon: Users, label: "Clienti", tourId: "pro-nav-clients" },
  { to: "/pro/templates", icon: BookmarkCheck, label: "Modelli di piano" },
  { to: "/pro/appointments", icon: CalendarDays, label: "Appuntamenti" },
  { to: "/pro/reports", icon: BarChart3, label: "Report", tourId: "pro-nav-reports" },
  { to: "/pro/notes", icon: MessageSquare, label: "Note", tourId: "pro-nav-notes" },
  { to: "/pro/coupon", icon: Ticket, label: "Coupon" },
  { to: "/pro/profile", icon: User, label: "Profilo", tourId: "pro-nav-profile" },
];

/**
 * Area nutrizionista: barra in basso su telefono, barra laterale su computer,
 * dove si svolge il lavoro di studio.
 */
const ProLayout = () => {
  const isMobile = useIsMobile();
  const { signOut } = useAuth();
  const navigate = useNavigate();

  if (isMobile) {
    return (
      <div className="mx-auto min-h-screen max-w-lg bg-background">
        <Outlet />
        <div className="h-[calc(72px+env(safe-area-inset-bottom,0px)+16px)]" />
        <BottomNav />
        <AppTour />
        <AppTourPrompt />
      </div>
    );
  }

  const handleLogout = async () => {
    await signOut();
    navigate("/auth/login", { replace: true });
  };

  return (
    <div className="flex min-h-screen bg-background">
      <aside className="sticky top-0 flex h-screen w-60 shrink-0 flex-col bg-sidebar text-sidebar-foreground">
        <div className="flex h-14 items-center px-5">
          <BrandLogo className="text-sidebar-foreground" />
        </div>
        <nav aria-label="Area nutrizionista" className="flex-1 space-y-0.5 overflow-y-auto px-3 py-2">
          {NAV_ITEMS.map(({ to, icon: Icon, label, end, tourId }) => (
            <NavLink
              key={to}
              to={to}
              end={end}
              data-tour={tourId}
              className={({ isActive }) =>
                `flex items-center gap-3 rounded-md px-3 py-2 text-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-sidebar-ring ${
                  isActive
                    ? "bg-sidebar-accent font-medium text-sidebar-accent-foreground"
                    : "text-sidebar-foreground/80 hover:bg-sidebar-accent/60 hover:text-sidebar-foreground"
                }`
              }
            >
              <Icon className="h-4 w-4 shrink-0" strokeWidth={1.75} aria-hidden="true" />
              {label}
            </NavLink>
          ))}
        </nav>
        <div className="border-t border-sidebar-border p-3">
          <button
            onClick={handleLogout}
            className="flex w-full items-center gap-3 rounded-md px-3 py-2 text-sm text-sidebar-foreground/80 transition-colors hover:bg-sidebar-accent/60 hover:text-sidebar-foreground"
          >
            <LogOut className="h-4 w-4 shrink-0" strokeWidth={1.75} aria-hidden="true" />
            Esci
          </button>
        </div>
      </aside>
      <div className="min-w-0 flex-1">
        <div className="mx-auto max-w-5xl pb-10">
          <Outlet />
        </div>
      </div>
      <AppTour />
      <AppTourPrompt />
    </div>
  );
};

export default ProLayout;
