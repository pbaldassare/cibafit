import { Navigate } from "react-router-dom";
import { useRole, AppRole, getRoleHomePath } from "@/hooks/useRole";
import { useAuth } from "@/hooks/useAuth";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";

interface RoleGuardProps {
  allowedRoles: AppRole[];
  children: React.ReactNode;
}

const RoleGuard = ({ allowedRoles, children }: RoleGuardProps) => {
  const { session, loading: authLoading, signOut } = useAuth();
  const { role, isLoading } = useRole();

  if (authLoading || isLoading) {
    return (
      <div className="flex h-screen items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!session) {
    return <Navigate to="/auth/login" replace />;
  }

  if (!role) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-background p-6">
        <div className="max-w-sm text-center">
          <h1 className="text-lg font-semibold text-foreground">Non riusciamo a caricare il tuo profilo</h1>
          <p className="mt-1 text-sm text-muted-foreground">Controlla la connessione e riprova.</p>
          <div className="mt-4 flex justify-center gap-2">
            <Button onClick={() => window.location.reload()}>Riprova</Button>
            <Button variant="outline" onClick={signOut}>Esci</Button>
          </div>
        </div>
      </div>
    );
  }

  if (!allowedRoles.includes(role)) {
    // Redirect to role-appropriate home instead of showing error
    const homePath = getRoleHomePath(role);
    return <Navigate to={homePath} replace />;
  }

  return <>{children}</>;
};

export default RoleGuard;
