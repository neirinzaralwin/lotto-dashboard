import type { SupabaseClient } from '@supabase/supabase-js';

/** Favorite slot 1–4 as shown on the Algorithms tabs. */
export type FavoriteSlotNo = 1 | 2 | 3 | 4;
export type FavoriteRange = { min: number; max: number };
export type FavoriteRanges = Record<FavoriteSlotNo, FavoriteRange>;

/** Hard limits for any range (rows of history). */
export const RANGE_LIMIT_MIN = 1;
export const RANGE_LIMIT_MAX = 200;

export const DEFAULT_RANGES: FavoriteRanges = {
    1: { min: 7, max: 20 },
    2: { min: 7, max: 20 },
    3: { min: 15, max: 20 },
    4: { min: 15, max: 20 },
};

const SLOTS: FavoriteSlotNo[] = [1, 2, 3, 4];

export function validateRange(r: FavoriteRange): string | null {
    if (!Number.isInteger(r.min) || !Number.isInteger(r.max)) return 'integer';
    if (r.min < RANGE_LIMIT_MIN || r.max > RANGE_LIMIT_MAX) return 'limits';
    if (r.min > r.max) return 'order';
    return null;
}

function normalize(raw: unknown): FavoriteRanges {
    const out: FavoriteRanges = { ...DEFAULT_RANGES };
    if (!raw || typeof raw !== 'object') return out;
    for (const s of SLOTS) {
        const v = (raw as Record<string, unknown>)[String(s)] as Partial<FavoriteRange> | undefined;
        const r = { min: Number(v?.min), max: Number(v?.max) };
        if (validateRange(r) === null) out[s] = r;
    }
    return out;
}

/** Thrown when `app_settings.favorite_ranges` is missing (migration not applied). */
export class RangesStorageMissingError extends Error {
    constructor() {
        super('favorite_ranges column missing — run `supabase migration up`');
        this.name = 'RangesStorageMissingError';
    }
}

function isMissingRangesColumn(err: { code?: string; message?: string } | null): boolean {
    if (!err) return false;
    return (
        err.code === '42703' || // undefined_column
        err.code === 'PGRST204' || // column not in schema cache
        /favorite_ranges/i.test(err.message ?? '')
    );
}

async function latestRow(client: SupabaseClient) {
    const { data, error } = await client
        .from('app_settings')
        .select('id, favorite_ranges')
        .order('updated_at', { ascending: false })
        .limit(1)
        .maybeSingle();
    if (error) {
        if (isMissingRangesColumn(error)) throw new RangesStorageMissingError();
        throw error;
    }
    return data as { id: string; favorite_ranges: unknown } | null;
}

export type FavoriteRangesState = {
    ranges: FavoriteRanges;
    /** False → using defaults because storage is unavailable (migration missing / offline). */
    ready: boolean;
};

/** Saved ranges plus whether storage works; never throws. */
export async function loadFavoriteRangesState(
    client: SupabaseClient | null,
): Promise<FavoriteRangesState> {
    if (!client) return { ranges: { ...DEFAULT_RANGES }, ready: false };
    try {
        const row = await latestRow(client);
        return { ranges: normalize(row?.favorite_ranges), ready: true };
    } catch {
        return { ranges: { ...DEFAULT_RANGES }, ready: false };
    }
}

/** Saved ranges; defaults if the row/column is missing (e.g. migration not applied). */
export async function getFavoriteRanges(client: SupabaseClient | null): Promise<FavoriteRanges> {
    return (await loadFavoriteRangesState(client)).ranges;
}

export async function saveFavoriteRange(
    client: SupabaseClient,
    slot: FavoriteSlotNo,
    range: FavoriteRange,
): Promise<FavoriteRanges> {
    const problem = validateRange(range);
    if (problem) throw new Error(`Invalid range (${problem})`);
    const row = await latestRow(client);
    const next = { ...normalize(row?.favorite_ranges), [slot]: range };
    const payload = { favorite_ranges: next, updated_at: new Date().toISOString() };
    const { error } = row
        ? await client.from('app_settings').update(payload).eq('id', row.id)
        : await client.from('app_settings').insert(payload);
    if (error) {
        if (isMissingRangesColumn(error)) throw new RangesStorageMissingError();
        throw error;
    }
    return next;
}
