import type { FavoritesRefreshResult } from '@/lib/algorithms/recommendations-service';

/**
 * Result of the automatic favourites refresh that runs after every draw
 * mutation. Broadcast on `window` so the shell toast and the Algorithms page
 * can react without every draw-service caller threading the result through.
 */
export type FavoritesRefreshReport =
    | ({ status: 'ok'; at: string } & FavoritesRefreshResult)
    | { status: 'none'; at: string }
    | { status: 'error'; at: string; message: string };

export const FAVORITES_REFRESHED_EVENT = 'lotto:favorites-refreshed';

export function emitFavoritesRefreshed(report: FavoritesRefreshReport): void {
    if (typeof window === 'undefined') return;
    window.dispatchEvent(new CustomEvent(FAVORITES_REFRESHED_EVENT, { detail: report }));
}

export function onFavoritesRefreshed(
    listener: (report: FavoritesRefreshReport) => void,
): () => void {
    if (typeof window === 'undefined') return () => {};
    const handler = (e: Event) => listener((e as CustomEvent<FavoritesRefreshReport>).detail);
    window.addEventListener(FAVORITES_REFRESHED_EVENT, handler);
    return () => window.removeEventListener(FAVORITES_REFRESHED_EVENT, handler);
}
