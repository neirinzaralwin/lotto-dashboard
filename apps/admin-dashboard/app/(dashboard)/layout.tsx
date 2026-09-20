import { AppShell } from '@/components/app-shell';
import { requireAdminUser } from '@/lib/auth/require-admin';

export default async function DashboardLayout({
    children,
}: Readonly<{ children: React.ReactNode }>) {
    await requireAdminUser();
    return <AppShell>{children}</AppShell>;
}
