import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';

/** Server-side gate for dashboard routes. Middleware is primary; this is defense in depth. */
export async function requireAdminUser() {
    const supabase = await createClient();
    const {
        data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
        redirect('/login');
    }
    return user;
}
