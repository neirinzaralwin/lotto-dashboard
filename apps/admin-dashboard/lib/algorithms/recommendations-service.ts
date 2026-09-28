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

export const FAVORITES_PER_TYPE = 4;

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

/**
 * Fetches the deepest slice the dynamic window can ever need (MAX_WINDOW).
 * Favorites 1 and 2 size their own window from these rows, so a short history
 * is not a failure — computeWindowSize clamps down and flags shortHistory.
 */
async function fetchLatestDrawWindow(
    client: SupabaseClient,
    lotteryType: LotteryType,
): Promise<DrawWindowRow[] | null> {
    const { data, error } = await client
        .from('draws')
        .select('*')
        .eq('lottery_type', lotteryType)
        .order('draw_date', { ascending: false })
        .order('draw_number', { ascending: false })
        .limit(MAX_WINDOW);
    if (error) throw error;
    const rows = (data ?? []) as DrawRow[];
    if (rows.length === 0) return null;
    return rows.map(toWindowRow);
}

async function fetchAllDrawHistory(
    client: SupabaseClient,
    lotteryType: LotteryType,
): Promise<DrawWindowRow[] | null> {
    const { data, error } = await client
        .from('draws')
        .select('*')
        .eq('lottery_type', lotteryType)
        .order('draw_date', { ascending: false })
        .order('draw_number', { ascending: false })
        .limit(500);
    if (error) throw error;
    const rows = (data ?? []) as DrawRow[];
    if (rows.length === 0) return null;
    return rows.map(toWindowRow);
}

export async function loadFavoriteOneThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
): Promise<FavoriteOneResult> {
    if (client) {
        try {
            const live = await fetchLatestDrawWindow(client, lotteryType);
            if (live) return computeFavoriteOne(lotteryType, live, 'draw');
        } catch {
            /* demo */
        }
    }
    return computeFavoriteOne(lotteryType, demoDrawWindow(lotteryType), 'demo');
}

export async function loadFavoriteTwoThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
): Promise<FavoriteTwoResult> {
    if (client) {
        try {
            const live = await fetchAllDrawHistory(client, lotteryType);
            if (live && live.length > 0) {
                return computeFavoriteTwo(lotteryType, live, 'draw');
            }
        } catch {
            /* demo */
        }
    }
    return computeFavoriteTwo(lotteryType, demoFavoriteTwoHistory(lotteryType), 'demo');
}

export async function loadFavoriteFourThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
): Promise<FavoriteFourResult> {
    if (client) {
        try {
            const live = await fetchLatestDrawWindow(client, lotteryType);
            if (live) return computeFavoriteFour(lotteryType, live, 'draw');
        } catch {
            /* demo */
        }
    }
    return computeFavoriteFour(lotteryType, demoFavoriteFourWindow(lotteryType), 'demo');
}

export async function loadFavoriteThreeThinking(
    client: SupabaseClient | null,
    lotteryType: LotteryType,
): Promise<FavoriteThreeResult> {
    if (client) {
        try {
            const live = await fetchAllDrawHistory(client, lotteryType);
            if (live && live.length > 0) {
                return computeFavoriteThree(lotteryType, live, 'draw');
            }
        } catch {
            /* demo */
        }
    }
    return computeFavoriteThree(lotteryType, demoFavoriteThreeHistory(lotteryType), 'demo');
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
    const [one6, one7, two6, two7, three6, three7, four6, four7] = await Promise.all([
        loadFavoriteOneThinking(client, 'lotto6'),
        loadFavoriteOneThinking(client, 'lotto7'),
        loadFavoriteTwoThinking(client, 'lotto6'),
        loadFavoriteTwoThinking(client, 'lotto7'),
        loadFavoriteThreeThinking(client, 'lotto6'),
        loadFavoriteThreeThinking(client, 'lotto7'),
        loadFavoriteFourThinking(client, 'lotto6'),
        loadFavoriteFourThinking(client, 'lotto7'),
    ]);

    /**
     * Slot order is the product decision, the algorithm modules are not:
     * 1 = 7-draw mode, 2 = 7-draw rarest, 3 = key most common, 4 = key least common.
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
    generatedAt: string | null;
};

export function publishedKey(lotteryType: LotteryType, algorithmName: string): string {
    return `${lotteryType}:${algorithmName}`;
}

type RecommendationRow = {
    numbers: number[];
    bonus_numbers?: number[] | null;
    generated_at: string | null;
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

/** Snapshot a computed slot (mains + bonus) as the live mobile pick. */
export async function publishFavoriteSlot(
    client: SupabaseClient,
    slot: FavoriteSlot,
): Promise<void> {
    if (!slot.algorithmName) throw new Error('Slot has no algorithm name');
    const algorithmId = await ensureAlgorithmId(client, slot.lotteryType, slot.algorithmName);
    const { data: inserted, error: insertError } = await client
        .from('recommendations')
        .insert({
            algorithm_id: algorithmId,
            lottery_type: slot.lotteryType,
            numbers: slot.winningNumbers,
            bonus_numbers: slot.bonusNumbers,
            is_published: true,
        })
        .select('id')
        .single();
    if (insertError) throw insertError;
    const newId = (inserted as { id: string }).id;
    // Keep a single live row per algorithm + type.
    const { error: cleanupError } = await client
        .from('recommendations')
        .delete()
        .eq('algorithm_id', algorithmId)
        .eq('lottery_type', slot.lotteryType)
        .neq('id', newId);
    if (cleanupError) throw cleanupError;
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
