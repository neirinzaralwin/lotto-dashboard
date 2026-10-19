import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { errorMessage, regeneratePublishedFavorites } from '@/lib/algorithms/recommendations-service';

/**
 * Recompute live favourites on the server, so closing the tab mid-refresh
 * cannot leave half the slots updated. Runs as the signed-in admin (cookies),
 * so the same RLS rules apply as in the browser.
 */
export async function POST() {
    try {
        const client = await createClient();
        const {
            data: { user },
        } = await client.auth.getUser();
        if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        const result = await regeneratePublishedFavorites(client);
        return NextResponse.json(result);
    } catch (err) {
        console.error('[favorites/refresh]', err);
        return NextResponse.json(
            { error: errorMessage(err, 'Refresh failed') },
            { status: 500 },
        );
    }
}
