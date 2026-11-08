import { useState } from "react";
import { Navigate, Outlet, useLocation } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import { useRole } from "@/hooks/useRole";
import { Loader2 } from "lucide-react";
import OnboardingWalkthrough, { shouldShowOnboarding } from "@/components/OnboardingWalkthrough";

const ProtectedRoute = () => {
  const { session, loading } = useAuth();
  const location = useLocation();
  const { role, isLoading: roleLoading } = useRole();
  const [showOnboarding, setShowOnboarding] = useState(() => shouldShowOnboarding());

  if (loading || (session && roleLoading)) {
    return (
      <div className="flex h-screen items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!session) {
    const destination = location.pathname + location.search;
    const login = destination === "/" ? "/auth/login" : `/auth/login?next=${encodeURIComponent(destination)}`;
    return <Navigate to={login} replace />;
  }

  if (showOnboarding) {
    return (
      <OnboardingWalkthrough
        role={role}
        onComplete={() => setShowOnboarding(false)}
      />
    );
  }

  return <Outlet />;
};

export default ProtectedRoute;
