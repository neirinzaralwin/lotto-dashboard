import type { LotteryType } from '@repo/types';
import { computeWindowSize, MAX_WINDOW, MIN_WINDOW } from '@/lib/algorithms/dynamic-window';
import {
    demoDrawWindow,
    type ColumnPickTrace,
    type DigitFrequency,
    type DrawWindowRow,
} from '@/lib/algorithms/favorite-one';
import type { WindowSizeResult } from '@/lib/algorithms/dynamic-window';
import { firstUnusedInOrder, unseenAscending } from '@/lib/algorithms/unique-pick';

export const FAVORITE_FOUR_MIN_WINDOW = MIN_WINDOW;
export const FAVORITE_FOUR_MAX_WINDOW = MAX_WINDOW;

export type FavoriteFourResult = {
    lotteryType: LotteryType;
    windowSize: number;
    rows: DrawWindowRow[];
    /** How each column decided the window size (same rule as Favorite 1). */
    window: WindowSizeResult;
    /** Newest draw date in the window. */
    latestDate: string;
    winningNumbers: number[];
    bonusNumbers: number[];
    columns: ColumnPickTrace[];
    triggeredBy: 'draw' | 'import' | 'demo';
};

function mainCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 6 : 7;
}

function bonusCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 1 : 2;
}

/** Rarest first; ties break toward the smaller digit (mirror of Favorite 1). */
function rankRarestFrequencies(values: number[]): DigitFrequency[] {
    const counts = new Map<number, number>();
    for (const v of values) {
        if (!Number.isFinite(v) || v <= 0) continue;
        counts.set(v, (counts.get(v) ?? 0) + 1);
    }
    const total = values.filter((v) => v > 0).length || 1;
    return [...counts.entries()]
        .map(([digit, count]) => ({ digit, count, share: count / total }))
        .sort((a, b) => a.count - b.count || a.digit - b.digit);
}

function numberMax(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 43 : 37;
}

function pickRarest(
    frequencies: DigitFrequency[],
    used: Set<number>,
    max: number,
): { picked: number; rarest: number; usedFallback: boolean } {
    if (frequencies.length === 0) {
        return { picked: 0, rarest: 0, usedFallback: false };
    }
    const rarest = frequencies[0]!.digit;
    const ranked = frequencies.map((f) => f.digit);
    // Stay unique without leaving the algorithm: walk the rarest-first
    // ranking, then numbers never seen in this column (true count 0, so
    // rarest — smaller first, the same tie-break as the ranking).
    const picked = firstUnusedInOrder(
        ranked,
        unseenAscending(new Set(ranked), max),
        used,
        max,
    );
    return { picked, rarest, usedFallback: picked > 0 && picked !== rarest };
}

/**
 * Favorite #4: opposite of Favorite #1, sharing its dynamic window
 * (7–20 rows, see {@link computeWindowSize}). Over those rows, each digit
 * column picks its least common value (rarest). Ties break toward the smaller
 * digit. Skips digits already chosen so the set stays unique.
 */
export function computeFavoriteFour(
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    triggeredBy: FavoriteFourResult['triggeredBy'] = 'demo',
): FavoriteFourResult {
    const mains = mainCount(lotteryType);
    const bonuses = bonusCount(lotteryType);
    const max = numberMax(lotteryType);
    const window = computeWindowSize(lotteryType, historyNewestFirst);
    const rows = window.rows;
    /** Algorithm walks oldest → newest for display; rarest does not care about order. */
    const chronological = [...rows].reverse();
    const used = new Set<number>();
    const columns: ColumnPickTrace[] = [];
    const winningNumbers: number[] = [];
    const bonusNumbers: number[] = [];

    for (let col = 0; col < mains; col++) {
        const columnValues = chronological.map((r) => r.winningNumbers[col] ?? 0);
        const frequencies = rankRarestFrequencies(columnValues);
        const { picked, rarest, usedFallback } = pickRarest(frequencies, used, max);
        if (picked > 0) used.add(picked);
        winningNumbers.push(picked);
        columns.push({
            columnIndex: col,
            kind: 'main',
            columnValues,
            frequencies,
            modeDigit: rarest,
            pickedDigit: picked,
            usedFallback,
        });
    }

    for (let col = 0; col < bonuses; col++) {
        const columnValues = chronological.map((r) => r.bonusNumbers[col] ?? 0);
        const frequencies = rankRarestFrequencies(columnValues);
        // Bonus balls are drawn from the remaining balls, so they must avoid
        // the mains as well as each other.
        const { picked, rarest, usedFallback } = pickRarest(frequencies, used, max);
        if (picked > 0) used.add(picked);
        bonusNumbers.push(picked);
        columns.push({
            columnIndex: col,
            kind: 'bonus',
            columnValues,
            frequencies,
            modeDigit: rarest,
            pickedDigit: picked,
            usedFallback,
        });
    }

    return {
        lotteryType,
        windowSize: window.windowSize,
        rows,
        window,
        latestDate: rows[0]?.drawDate ?? '',
        winningNumbers,
        bonusNumbers,
        columns,
        triggeredBy,
    };
}

/** Demo history when live draws are unavailable (same rows as Favorite 1). */
export function demoFavoriteFourWindow(lotteryType: LotteryType): DrawWindowRow[] {
    return demoDrawWindow(lotteryType);
}
