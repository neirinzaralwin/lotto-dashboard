import type { LotteryType } from '@repo/types';
import {
    computeWindowSize,
    MAX_WINDOW,
    MIN_WINDOW,
    type WindowSizeResult,
} from '@/lib/algorithms/dynamic-window';

/** Historical constant. The window is now dynamic — see {@link computeWindowSize}. */
export const FAVORITE_ONE_WINDOW = MIN_WINDOW;
export const FAVORITE_ONE_MIN_WINDOW = MIN_WINDOW;
export const FAVORITE_ONE_MAX_WINDOW = MAX_WINDOW;

export type DrawWindowRow = {
    drawNumber: string;
    drawDate: string;
    winningNumbers: number[];
    bonusNumbers: number[];
};

export type DigitFrequency = {
    digit: number;
    count: number;
    /** Share of the window (0–1). */
    share: number;
};

export type ColumnPickTrace = {
    columnIndex: number;
    kind: 'main' | 'bonus';
    /** Values from the 7-row window for this column (oldest → newest). */
    columnValues: number[];
    frequencies: DigitFrequency[];
    /** Mode winner before uniqueness fallback. */
    modeDigit: number;
    /** Final digit after uniqueness (may differ from modeDigit). */
    pickedDigit: number;
    usedFallback: boolean;
};

export type FavoriteOneResult = {
    lotteryType: LotteryType;
    windowSize: number;
    /** Rows actually used after the dynamic window was resolved. */
    rows: DrawWindowRow[];
    /** How each column decided the window size. */
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

function rankFrequencies(values: number[]): DigitFrequency[] {
    const counts = new Map<number, number>();
    for (const v of values) {
        if (!Number.isFinite(v) || v <= 0) continue;
        counts.set(v, (counts.get(v) ?? 0) + 1);
    }
    const total = values.filter((v) => v > 0).length || 1;
    return [...counts.entries()]
        .map(([digit, count]) => ({ digit, count, share: count / total }))
        .sort((a, b) => b.count - a.count || a.digit - b.digit);
}

function pickFromFrequencies(
    frequencies: DigitFrequency[],
    used: Set<number>,
): { picked: number; mode: number; usedFallback: boolean } {
    if (frequencies.length === 0) {
        return { picked: 0, mode: 0, usedFallback: false };
    }
    const mode = frequencies[0]!.digit;
    for (const freq of frequencies) {
        if (!used.has(freq.digit)) {
            return {
                picked: freq.digit,
                mode,
                usedFallback: freq.digit !== mode,
            };
        }
    }
    return { picked: mode, mode, usedFallback: false };
}

/**
 * Favorite #1: the window size is dynamic (7–20 rows, see
 * {@link computeWindowSize}). Over those rows, each digit column picks its most
 * common value (mode). Ties break toward the smaller digit. Skips digits
 * already chosen so the set stays unique.
 */
export function computeFavoriteOne(
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    triggeredBy: FavoriteOneResult['triggeredBy'] = 'demo',
): FavoriteOneResult {
    const mains = mainCount(lotteryType);
    const bonuses = bonusCount(lotteryType);
    const window = computeWindowSize(lotteryType, historyNewestFirst);
    const rows = window.rows;
    /** Algorithm walks oldest → newest for display; mode does not care about order. */
    const chronological = [...rows].reverse();
    const used = new Set<number>();
    const columns: ColumnPickTrace[] = [];
    const winningNumbers: number[] = [];
    const bonusNumbers: number[] = [];

    for (let col = 0; col < mains; col++) {
        const columnValues = chronological.map((r) => r.winningNumbers[col] ?? 0);
        const frequencies = rankFrequencies(columnValues);
        const { picked, mode, usedFallback } = pickFromFrequencies(frequencies, used);
        if (picked > 0) used.add(picked);
        winningNumbers.push(picked);
        columns.push({
            columnIndex: col,
            kind: 'main',
            columnValues,
            frequencies,
            modeDigit: mode,
            pickedDigit: picked,
            usedFallback,
        });
    }

    for (let col = 0; col < bonuses; col++) {
        const columnValues = chronological.map((r) => r.bonusNumbers[col] ?? 0);
        const frequencies = rankFrequencies(columnValues);
        // Bonus digits may overlap mains in some games; keep them independent of main `used`.
        const bonusUsed = new Set<number>();
        for (const n of bonusNumbers) if (n > 0) bonusUsed.add(n);
        const { picked, mode, usedFallback } = pickFromFrequencies(frequencies, bonusUsed);
        if (picked > 0) bonusUsed.add(picked);
        bonusNumbers.push(picked);
        columns.push({
            columnIndex: col,
            kind: 'bonus',
            columnValues,
            frequencies,
            modeDigit: mode,
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

/**
 * Demo history when live draws are unavailable. Kept at 20 rows so the dynamic
 * window has room to grow instead of pinning every demo run to the 7-row floor.
 */
export function demoDrawWindow(lotteryType: LotteryType): DrawWindowRow[] {
    if (lotteryType === 'lotto6') {
        return [
            {
                drawNumber: '2140',
                drawDate: '2026-09-18',
                winningNumbers: [5, 12, 19, 27, 34, 41],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2139',
                drawDate: '2026-09-15',
                winningNumbers: [5, 11, 22, 28, 33, 40],
                bonusNumbers: [16],
            },
            {
                drawNumber: '2138',
                drawDate: '2026-09-11',
                winningNumbers: [3, 12, 17, 25, 34, 43],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2137',
                drawDate: '2026-09-08',
                winningNumbers: [5, 9, 19, 27, 36, 41],
                bonusNumbers: [21],
            },
            {
                drawNumber: '2136',
                drawDate: '2026-09-04',
                winningNumbers: [2, 12, 21, 28, 34, 39],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2135',
                drawDate: '2026-09-01',
                winningNumbers: [5, 14, 19, 30, 33, 41],
                bonusNumbers: [7],
            },
            {
                drawNumber: '2134',
                drawDate: '2026-08-28',
                winningNumbers: [1, 12, 22, 27, 35, 42],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2133',
                drawDate: '2026-08-25',
                winningNumbers: [4, 10, 20, 29, 31, 43],
                bonusNumbers: [13],
            },
            {
                drawNumber: '2132',
                drawDate: '2026-08-22',
                winningNumbers: [7, 14, 21, 26, 32, 40],
                bonusNumbers: [6],
            },
            {
                drawNumber: '2131',
                drawDate: '2026-08-19',
                winningNumbers: [2, 16, 18, 30, 36, 39],
                bonusNumbers: [11],
            },
            {
                drawNumber: '2130',
                drawDate: '2026-08-15',
                winningNumbers: [6, 13, 23, 28, 37, 42],
                bonusNumbers: [9],
            },
            {
                drawNumber: '2129',
                drawDate: '2026-08-12',
                winningNumbers: [8, 15, 19, 25, 30, 41],
                bonusNumbers: [14],
            },
            {
                drawNumber: '2128',
                drawDate: '2026-08-08',
                winningNumbers: [3, 9, 24, 27, 33, 40],
                bonusNumbers: [7],
            },
            {
                drawNumber: '2127',
                drawDate: '2026-08-05',
                winningNumbers: [10, 17, 22, 26, 35, 38],
                bonusNumbers: [12],
            },
            {
                drawNumber: '2126',
                drawDate: '2026-08-01',
                winningNumbers: [1, 11, 20, 32, 39, 43],
                bonusNumbers: [5],
            },
            {
                drawNumber: '2125',
                drawDate: '2026-07-29',
                winningNumbers: [5, 14, 21, 29, 34, 40],
                bonusNumbers: [10],
            },
            {
                drawNumber: '2124',
                drawDate: '2026-07-25',
                winningNumbers: [3, 12, 18, 31, 37, 42],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2123',
                drawDate: '2026-07-22',
                winningNumbers: [9, 16, 23, 28, 33, 41],
                bonusNumbers: [15],
            },
            {
                drawNumber: '2122',
                drawDate: '2026-07-18',
                winningNumbers: [2, 13, 19, 26, 35, 43],
                bonusNumbers: [6],
            },
        ];
    }

    return [
        {
            drawNumber: '620',
            drawDate: '2026-09-19',
            winningNumbers: [1, 7, 14, 20, 26, 31, 37],
            bonusNumbers: [4, 18],
        },
        {
            drawNumber: '619',
            drawDate: '2026-09-16',
            winningNumbers: [3, 7, 15, 23, 26, 32, 35],
            bonusNumbers: [4, 27],
        },
        {
            drawNumber: '618',
            drawDate: '2026-09-12',
            winningNumbers: [1, 8, 14, 19, 26, 30, 36],
            bonusNumbers: [11, 18],
        },
        {
            drawNumber: '617',
            drawDate: '2026-09-09',
            winningNumbers: [2, 7, 13, 20, 24, 31, 37],
            bonusNumbers: [4, 22],
        },
        {
            drawNumber: '616',
            drawDate: '2026-09-05',
            winningNumbers: [1, 10, 14, 23, 26, 29, 34],
            bonusNumbers: [6, 18],
        },
        {
            drawNumber: '615',
            drawDate: '2026-09-02',
            winningNumbers: [5, 7, 15, 20, 28, 31, 36],
            bonusNumbers: [4, 12],
        },
        {
            drawNumber: '614',
            drawDate: '2026-08-29',
            winningNumbers: [1, 9, 14, 21, 26, 33, 37],
            bonusNumbers: [8, 18],
        },
        {
            drawNumber: '613',
            drawDate: '2026-08-26',
            winningNumbers: [4, 11, 17, 25, 30, 35],
            bonusNumbers: [9, 13],
        },
        {
            drawNumber: '612',
            drawDate: '2026-08-22',
            winningNumbers: [6, 13, 20, 28, 32, 36],
            bonusNumbers: [5, 16],
        },
        {
            drawNumber: '611',
            drawDate: '2026-08-19',
            winningNumbers: [2, 8, 16, 24, 29, 34],
            bonusNumbers: [7, 12],
        },
        {
            drawNumber: '610',
            drawDate: '2026-08-15',
            winningNumbers: [5, 12, 22, 27, 31, 37],
            bonusNumbers: [6, 10],
        },
        {
            drawNumber: '609',
            drawDate: '2026-08-12',
            winningNumbers: [3, 10, 19, 23, 30, 35],
            bonusNumbers: [4, 15],
        },
        {
            drawNumber: '608',
            drawDate: '2026-08-08',
            winningNumbers: [7, 15, 18, 26, 33, 36],
            bonusNumbers: [9, 11],
        },
        {
            drawNumber: '607',
            drawDate: '2026-08-05',
            winningNumbers: [1, 9, 21, 25, 32, 34],
            bonusNumbers: [8, 14],
        },
        {
            drawNumber: '606',
            drawDate: '2026-08-01',
            winningNumbers: [4, 14, 17, 28, 30, 37],
            bonusNumbers: [6, 13],
        },
        {
            drawNumber: '605',
            drawDate: '2026-07-29',
            winningNumbers: [2, 11, 20, 24, 29, 33],
            bonusNumbers: [5, 16],
        },
        {
            drawNumber: '604',
            drawDate: '2026-07-25',
            winningNumbers: [6, 8, 16, 23, 31, 35],
            bonusNumbers: [7, 12],
        },
        {
            drawNumber: '603',
            drawDate: '2026-07-22',
            winningNumbers: [3, 12, 19, 27, 34, 36],
            bonusNumbers: [4, 10],
        },
        {
            drawNumber: '602',
            drawDate: '2026-07-18',
            winningNumbers: [5, 10, 22, 25, 30, 37],
            bonusNumbers: [9, 15],
        },
    ];
}
