import type { LotteryType } from '@repo/types';
import type { SupabaseClient } from '@supabase/supabase-js';
import { MAX_WINDOW, MIN_WINDOW } from '@/lib/algorithms/dynamic-window';
import {
    computeFavoriteOne,
    demoDrawWindow,
    type DrawWindowRow,
    type FavoriteOneResult,
} from '@/lib/algorithms/favorite-one';
import {
    computeFavoriteTwo,
    demoFavoriteTwoHistory,
    type FavoriteTwoResult,
} from '@/lib/algorithms/favorite-two';
import {
    computeFavoriteFour,
    demoFavoriteFourWindow,
    type FavoriteFourResult,
} from '@/lib/algorithms/favorite-four';
import {
    computeFavoriteThree,
    demoFavoriteThreeHistory,
    type FavoriteThreeResult,
} from '@/lib/algorithms/favorite-three';
import { mapDrawRow, type DrawRow } from '@/lib/draws/map';
import {
    DEFAULT_RANGES,
    getFavoriteRanges,
    type FavoriteRange,
} from '@/lib/algorithms/algorithm-settings';
import { randomWindowSize, type PickOptions } from '@/lib/algorithms/unique-pick';

export const FAVORITES_PER_TYPE = 4;

/** Live picks skip the newest draw's balls (they rarely repeat next draw). */
export const LIVE_OPTIONS: PickOptions = { excludeLatest: true };

/** Dynamic window bounds for Favorites 1 and 2. */
export const FAVORITE_WINDOW_MIN = MIN_WINDOW;
export const FAVORITE_WINDOW_MAX = MAX_WINDOW;

export type FavoriteSlot = {
    slot: number;
    id: string | null;
    lotteryType: LotteryType;
    winningNumbers: number[];
    bonusNumbers: number[];
    isPublished: boolean;
    generatedAt: string | null;
    algorithmName: string | null;
};

function toWindowRow(row: DrawRow): DrawWindowRow {
    const draw = mapDrawRow(row);
    return {
        drawNumber: draw.drawNumber,
        drawDate: draw.drawDate,
        winningNumbers: [...draw.winningNumbers],
        bonusNumbers: [...draw.bonusNumbers],
    };
}

/** Newest published draws, up to `limit` (the slot's range max). */
export async function fetchLatestPublished(
    client: SupabaseClient,
    lotteryType: LotteryType,
    limit: number,
): Promise<DrawWindowRow[] | null> {
    const { data, error } = await client
        .from('draws')
        .select('*')
        .eq('lottery_type', lotteryType)
        // Drafts may be mistyped or not yet announced — never let them shape picks.
        .eq('is_published', true)
        .order('draw_date', { ascending: false })
        .order('draw_number', { ascending: false })
        .limit(limit);
    if (error) throw error;
    const rows = (data ?? []) as DrawRow[];
    if (rows.length === 0) return null;
    return rows.map(toWindowRow);
}

type Loader<R> = (
    lotteryType: LotteryType,
    history: DrawWindowRow[],
    triggeredBy: 'draw' | 'demo',
    options: PickOptions,
) => R;

async function loadThinking<R>(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
    range: FavoriteRange,
    compute: Loader<R>,
    demo: (t: LotteryType) => DrawWindowRow[],
): Promise<R> {
    if (client) {
        try {
            const live = await fetchLatestPublished(client, lotteryType, range.max);
            if (live && live.length > 0) {
                // Each regeneration draws a fresh random history size inside Min–Max.
                return compute(lotteryType, live, 'draw', {
                    ...LIVE_OPTIONS,
                    window: { ...range, size: randomWindowSize(range.min, range.max) },
                });
            }
        } catch {
            /* demo */
        }
    }
    return compute(lotteryType, demo(lotteryType), 'demo', { window: range });
}

/** Slot 1 (Favorite 1 tab): dynamic-window mode. */
export function loadFavoriteOneThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
    range: FavoriteRange = DEFAULT_RANGES[1],
): Promise<FavoriteOneResult> {
    return loadThinking(client, lotteryType, range, computeFavoriteOne, demoDrawWindow);
}

/** Slot 3 (Favorite 3 tab): Date/Time key, most common. */
export function loadFavoriteTwoThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
    range: FavoriteRange = DEFAULT_RANGES[3],
): Promise<FavoriteTwoResult> {
    return loadThinking(client, lotteryType, range, computeFavoriteTwo, demoFavoriteTwoHistory);
}

/** Slot 2 (Favorite 2 tab): dynamic-window rarest. */
export function loadFavoriteFourThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
    range: FavoriteRange = DEFAULT_RANGES[2],
): Promise<FavoriteFourResult> {
    return loadThinking(client, lotteryType, range, computeFavoriteFour, demoFavoriteFourWindow);
}

/** Slot 4 (Favorite 4 tab): Date/Time key, least common. */
export function loadFavoriteThreeThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
    range: FavoriteRange = DEFAULT_RANGES[4],
): Promise<FavoriteThreeResult> {
    return loadThinking(client, lotteryType, range, computeFavoriteThree, demoFavoriteThreeHistory);
}

function slotFromNumbers(
    lotteryType: LotteryType,
    slot: number,
    winningNumbers: number[],
    bonusNumbers: number[],
    name: string,
    ready: boolean,
): FavoriteSlot {
    return {
        slot,
        id: ready ? `fav-${lotteryType}-${slot}` : null,
        lotteryType,
        winningNumbers: [...winningNumbers],
        bonusNumbers: [...bonusNumbers],
        isPublished: ready,
        generatedAt: ready ? new Date().toISOString() : null,
        algorithmName: ready ? name : null,
    };
}

export async function listAllFavoriteSlots(client: SupabaseClient | null): Promise<{
    lotto6: FavoriteSlot[];
    lotto7: FavoriteSlot[];
    thinkingOne: { lotto6: FavoriteOneResult; lotto7: FavoriteOneResult };
    thinkingTwo: { lotto6: FavoriteTwoResult; lotto7: FavoriteTwoResult };
    thinkingThree: { lotto6: FavoriteThreeResult; lotto7: FavoriteThreeResult };
    thinkingFour: { lotto6: FavoriteFourResult; lotto7: FavoriteFourResult };
}> {
    const ranges = await getFavoriteRanges(client);
    const [one6, one7, two6, two7, three6, three7, four6, four7] = await Promise.all([
        loadFavoriteOneThinking(client, 'lotto6', ranges[1]),
        loadFavoriteOneThinking(client, 'lotto7', ranges[1]),
        loadFavoriteTwoThinking(client, 'lotto6', ranges[3]),
        loadFavoriteTwoThinking(client, 'lotto7', ranges[3]),
        loadFavoriteThreeThinking(client, 'lotto6', ranges[4]),
        loadFavoriteThreeThinking(client, 'lotto7', ranges[4]),
        loadFavoriteFourThinking(client, 'lotto6', ranges[2]),
        loadFavoriteFourThinking(client, 'lotto7', ranges[2]),
    ]);

    /**
     * Slot order is the product decision, the algorithm modules are not:
     * 1 = 7–20-draw mode, 2 = 7–20-draw rarest, 3 = key most common, 4 = key least common.
     */
    const slotsFor = (
        type: LotteryType,
        one: FavoriteOneResult,
        two: FavoriteTwoResult,
        three: FavoriteThreeResult,
        four: FavoriteFourResult,
    ) => [
        slotFromNumbers(
            type,
            1,
            one.winningNumbers,
            one.bonusNumbers,
            'Favorite 1 · 7-draw mode',
            true,
        ),
        slotFromNumbers(
            type,
            2,
            four.winningNumbers,
            four.bonusNumbers,
            'Favorite 2 · 7-draw rarest',
            true,
        ),
        slotFromNumbers(
            type,
            3,
            two.winningNumbers,
            two.bonusNumbers,
            'Favorite 3 · date/time most common',
            two.keyRoot != null && two.winningNumbers.some((n) => n > 0),
        ),
        slotFromNumbers(
            type,
            4,
            three.winningNumbers,
            three.bonusNumbers,
            'Favorite 4 · date/time least common',
            three.keyRoot != null && three.winningNumbers.some((n) => n > 0),
        ),
    ];

    return {
        lotto6: slotsFor('lotto6', one6, two6, three6, four6),
        lotto7: slotsFor('lotto7', one7, two7, three7, four7),
        thinkingOne: { lotto6: one6, lotto7: one7 },
        thinkingTwo: { lotto6: two6, lotto7: two7 },
        thinkingThree: { lotto6: three6, lotto7: three7 },
        thinkingFour: { lotto6: four6, lotto7: four7 },
    };
}

// ---------------------------------------------------------------------------
// Publishing: persist a computed slot to `recommendations` (mains in
// `numbers`, bonus in `bonus_numbers`) so the mobile app can read it.
// One live row per algorithm + lottery type; republishing replaces it.
// ---------------------------------------------------------------------------

export type PublishedFavorite = {
    lotteryType: LotteryType;
    algorithmName: string;
    winningNumbers: number[];
    bonusNumbers: number[];
    /** Last recalculation (every refresh writes a new row). */
    generatedAt: string | null;
    /** When the numbers themselves last differed from the previous set. */
    numbersChangedAt: string | null;
    /** The set shown before the last real change (null = first publish). */
    previousNumbers: number[] | null;
    previousBonusNumbers: number[] | null;
};

export function publishedKey(lotteryType: LotteryType, algorithmName: string): string {
    return `${lotteryType}:${algorithmName}`;
}

type RecommendationRow = {
    numbers: number[];
    bonus_numbers?: number[] | null;
    generated_at: string | null;
    numbers_changed_at?: string | null;
    previous_numbers?: number[] | null;
    previous_bonus_numbers?: number[] | null;
    lottery_type: LotteryType;
    algorithms:
        | { name: string; lottery_type: LotteryType }
        | { name: string; lottery_type: LotteryType }[]
        | null;
};

/** Live (`is_published`) rows keyed by slot identity for pill state. */
export async function loadPublishedFavorites(
    client: SupabaseClient,
): Promise<Map<string, PublishedFavorite>> {
    const { data, error } = await client
        .from('recommendations')
        .select('*, algorithms(name, lottery_type)')
        .eq('is_published', true);
    if (error) throw error;
    const out = new Map<string, PublishedFavorite>();
    for (const row of (data ?? []) as RecommendationRow[]) {
        const algo = Array.isArray(row.algorithms) ? row.algorithms[0] : row.algorithms;
        if (!algo?.name) continue;
        out.set(publishedKey(algo.lottery_type, algo.name), {
            lotteryType: algo.lottery_type,
            algorithmName: algo.name,
            winningNumbers: [...(row.numbers ?? [])],
            bonusNumbers: [...(row.bonus_numbers ?? [])],
            generatedAt: row.generated_at,
            numbersChangedAt: row.numbers_changed_at ?? row.generated_at,
            previousNumbers: row.previous_numbers ?? null,
            previousBonusNumbers: row.previous_bonus_numbers ?? null,
        });
    }
    return out;
}

async function ensureAlgorithmId(
    client: SupabaseClient,
    lotteryType: LotteryType,
    name: string,
): Promise<string> {
    const { data, error } = await client
        .from('algorithms')
        .select('id')
        .eq('name', name)
        .eq('lottery_type', lotteryType)
        .maybeSingle();
    if (error) throw error;
    if (data) return (data as { id: string }).id;
    const { data: created, error: insertError } = await client
        .from('algorithms')
        .insert({ name, lottery_type: lotteryType })
        .select('id')
        .single();
    if (insertError) throw insertError;
    return (created as { id: string }).id;
}

/**
 * Snapshot a computed slot (mains + bonus) as the live mobile pick.
 * One transaction in Postgres (`publish_recommendation`): the previous live row
 * becomes history, so there is never a moment with zero or two live rows.
 */
export async function publishFavoriteSlot(
    client: SupabaseClient,
    slot: FavoriteSlot,
): Promise<{ changed: boolean }> {
    if (!slot.algorithmName) throw new Error('Slot has no algorithm name');
    const algorithmId = await ensureAlgorithmId(client, slot.lotteryType, slot.algorithmName);
    const { data, error } = await client.rpc('publish_recommendation', {
        p_algorithm_id: algorithmId,
        p_lottery_type: slot.lotteryType,
        p_numbers: slot.winningNumbers,
        p_bonus_numbers: slot.bonusNumbers,
    });
    if (error) {
        if (!isMissingPublishRpc(error)) throw error;
        // Migration 20261019000000 not applied yet: keep working the old way.
        console.warn(
            '[favorites] publish_recommendation() missing — run `supabase migration up`. Using legacy publish.',
        );
        return legacyPublish(client, algorithmId, slot);
    }
    const row = (Array.isArray(data) ? data[0] : data) as { changed?: boolean } | null;
    return { changed: Boolean(row?.changed) };
}

function isMissingPublishRpc(error: { code?: string; message?: string }): boolean {
    return (
        error.code === 'PGRST202' ||
        error.code === '42883' ||
        /publish_recommendation/i.test(error.message ?? '')
    );
}

/** Pre-migration path (non-atomic). Only used until the migration is applied. */
async function legacyPublish(
    client: SupabaseClient,
    algorithmId: string,
    slot: FavoriteSlot,
): Promise<{ changed: boolean }> {
    // Demote first, then insert: never two live rows (safe with the unique index).
    const { error: demoteError } = await client
        .from('recommendations')
        .update({ is_published: false })
        .eq('algorithm_id', algorithmId)
        .eq('lottery_type', slot.lotteryType)
        .eq('is_published', true);
    if (demoteError) throw demoteError;
    const { error: insertError } = await client.from('recommendations').insert({
        algorithm_id: algorithmId,
        lottery_type: slot.lotteryType,
        numbers: slot.winningNumbers,
        bonus_numbers: slot.bonusNumbers,
        is_published: true,
    });
    if (insertError) throw insertError;
    return { changed: true };
}

/** Supabase errors are plain objects, not `Error` — keep their message. */
export function errorMessage(err: unknown, fallback: string): string {
    if (err instanceof Error) return err.message;
    if (err && typeof err === 'object' && 'message' in err) {
        const m = (err as { message?: unknown }).message;
        if (typeof m === 'string' && m) return m;
    }
    return fallback;
}

/**
 * A slot is publishable when the algorithm produced a pick for it.
 * Kept here so the Generate button and the per-slot tickets agree on
 * what counts as ready.
 */
export function isSlotReady(slot: FavoriteSlot): boolean {
    return (
        slot.id != null &&
        (slot.winningNumbers.some((n) => n > 0) || slot.bonusNumbers.some((n) => n > 0))
    );
}

/**
 * Recompute every slot from the latest draws and publish the ready ones in a
 * single action. Already-published slots are replaced, so this doubles as
 * "regenerate" — no per-slot clicking required.
 */
export async function generateAndPublishAllFavorites(
    client: SupabaseClient,
): Promise<{
    published: number;
    skipped: number;
    data: Awaited<ReturnType<typeof listAllFavoriteSlots>>;
}> {
    const data = await listAllFavoriteSlots(client);

    const targets = [...data.lotto6, ...data.lotto7];
    let published = 0;
    let skipped = 0;

    for (const slot of targets) {
        if (!isSlotReady(slot) || !slot.algorithmName) {
            skipped += 1;
            continue;
        }
        await publishFavoriteSlot(client, slot);
        published += 1;
    }

    return { published, skipped, data };
}

/**
 * Refresh the picks that are already live for the mobile app.
 *
 * Unlike `generateAndPublishAllFavorites` (the Generate button), this never
 * publishes a slot the admin has unpublished — it only recomputes the slots
 * that are currently `is_published` and replaces them in place. Called after
 * draw changes so favourites always reflect the newest data without overriding
 * a deliberate unpublish.
 */
export async function regeneratePublishedFavorites(
    client: SupabaseClient,
): Promise<FavoritesRefreshResult> {
    const published = await loadPublishedFavorites(client);
    if (published.size === 0) return { refreshed: 0, slots: [] };

    const data = await listAllFavoriteSlots(client);
    const slots = [...data.lotto6, ...data.lotto7];

    let refreshed = 0;
    const out: FavoritesRefreshResult['slots'] = [];
    for (const slot of slots) {
        if (!slot.algorithmName) continue;
        const before = published.get(publishedKey(slot.lotteryType, slot.algorithmName));
        if (!before) continue;
        if (!isSlotReady(slot)) {
            // No pick any more: an old pick must not linger in the app.
            await unpublishFavoriteSlot(client, slot);
            out.push({ lotteryType: slot.lotteryType, slot: slot.slot, status: 'stale', diff: 0, total: 0 });
            continue;
        }
        await publishFavoriteSlot(client, slot);
        refreshed += 1;
        const diff = countDiff(
            [...before.winningNumbers, ...before.bonusNumbers],
            [...slot.winningNumbers, ...slot.bonusNumbers],
        );
        const total = slot.winningNumbers.length + slot.bonusNumbers.length;
        out.push({
            lotteryType: slot.lotteryType,
            slot: slot.slot,
            status: changeLevel(diff, total),
            diff,
            total,
        });
    }
    return { refreshed, slots: out };
}

export type ChangeLevel = 'unchanged' | 'slight' | 'changed';

export type FavoritesRefreshResult = {
    refreshed: number;
    slots: Array<{
        lotteryType: LotteryType;
        slot: number;
        status: ChangeLevel | 'stale';
        /** Positions (per column, mains + bonus) whose number differs. */
        diff: number;
        total: number;
    }>;
};

/** Per-column compare — the algorithms pick one number per column. */
export function countDiff(a: number[], b: number[]): number {
    const len = Math.max(a.length, b.length);
    let diff = 0;
    for (let i = 0; i < len; i += 1) if (a[i] !== b[i]) diff += 1;
    return diff;
}

/** "Slight" = at most 2 balls (or a third of the set) moved. */
export function changeLevel(diff: number, total: number): ChangeLevel {
    if (diff === 0) return 'unchanged';
    if (diff <= Math.max(2, Math.floor(total / 3))) return 'slight';
    return 'changed';
}

/** Hide a slot's picks from the mobile app (rows kept as history). */
export async function unpublishFavoriteSlot(
    client: SupabaseClient,
    slot: FavoriteSlot,
): Promise<void> {
    if (!slot.algorithmName) return;
    const { data, error } = await client
        .from('algorithms')
        .select('id')
        .eq('name', slot.algorithmName)
        .eq('lottery_type', slot.lotteryType)
        .maybeSingle();
    if (error) throw error;
    if (!data) return;
    const { error: updateError } = await client
        .from('recommendations')
        .update({ is_published: false })
        .eq('algorithm_id', (data as { id: string }).id)
        .eq('lottery_type', slot.lotteryType)
        .eq('is_published', true);
    if (updateError) throw updateError;
}
