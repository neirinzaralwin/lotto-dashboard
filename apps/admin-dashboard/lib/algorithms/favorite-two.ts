import type { LotteryType } from '@repo/types';
import {
    digitalRootOfDate,
    digitalRootOfNumber,
    digitalRootOfTime,
} from '@/lib/algorithms/digital-root';
import type { DigitFrequency, DrawWindowRow } from '@/lib/algorithms/favorite-one';
import { firstUnusedInOrder } from '@/lib/algorithms/unique-pick';

export type DateTimeScanRow = DrawWindowRow & {
    dateRoot: number;
    timeRoot: number;
    matched: boolean;
};

export type FavoriteTwoColumnTrace = {
    columnIndex: number;
    kind: 'main' | 'bonus';
    /** All historical values in this column (oldest → newest). */
    columnValues: number[];
    /** Values kept because digitalRoot(value) === keyRoot. */
    eligibleValues: number[];
    /** Frequency among eligible values only. */
    frequencies: DigitFrequency[];
    /** Mode among eligible before uniqueness. */
    modeDigit: number;
    pickedDigit: number;
    usedFallback: boolean;
};

export type FavoriteTwoResult = {
    lotteryType: LotteryType;
    /** Shared digital root when Date DR === Time DR. */
    keyRoot: number | null;
    /** Newest→older walk until the first Date/Time match (inclusive). */
    scanRows: DateTimeScanRow[];
    /** Row that produced the key (if any). */
    matchedRow: DateTimeScanRow | null;
    /** Full history used for column frequency (newest first). */
    history: DrawWindowRow[];
    winningNumbers: number[];
    bonusNumbers: number[];
    columns: FavoriteTwoColumnTrace[];
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
    max: number,
    extras: number[],
): { picked: number; mode: number; usedFallback: boolean } {
    if (frequencies.length === 0 && extras.length === 0) {
        return { picked: 0, mode: 0, usedFallback: false };
    }
    const mode = frequencies[0]?.digit ?? extras[0] ?? 0;
    const ranked = frequencies.map((f) => f.digit);
    // Stay unique without leaving the algorithm: walk the most-common
    // ranking first, then key-matching balls never seen in this column
    // (smaller first — the same tie-break as the ranking).
    const picked = firstUnusedInOrder(ranked, extras, used, max);
    return { picked, mode, usedFallback: picked > 0 && picked !== mode };
}

function annotate(row: DrawWindowRow): DateTimeScanRow {
    const dateRoot = digitalRootOfDate(row.drawDate);
    const timeRoot = digitalRootOfTime(row.drawNumber);
    return {
        ...row,
        dateRoot,
        timeRoot,
        matched: dateRoot > 0 && timeRoot > 0 && dateRoot === timeRoot,
    };
}

/** Newest→older until Date DR === Time DR. Shared by Favorite 2 & 3. */
export function scanDateTimeKey(historyNewestFirst: DrawWindowRow[]): {
    scanRows: DateTimeScanRow[];
    matchedRow: DateTimeScanRow | null;
    keyRoot: number | null;
} {
    const scanRows: DateTimeScanRow[] = [];
    let matchedRow: DateTimeScanRow | null = null;
    for (const row of historyNewestFirst) {
        const annotated = annotate(row);
        scanRows.push(annotated);
        if (annotated.matched) {
            matchedRow = annotated;
            break;
        }
    }
    return {
        scanRows,
        matchedRow,
        keyRoot: matchedRow?.dateRoot ?? null,
    };
}

export function numberMaxForType(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 43 : 37;
}

/** Every ball in range whose digital root equals the key. */
export function candidatesForKeyRoot(keyRoot: number, max: number): number[] {
    const out: number[] = [];
    for (let n = 1; n <= max; n++) {
        if (digitalRootOfNumber(n) === keyRoot) out.push(n);
    }
    return out;
}

/**
 * Favorite #2:
 * 1. Walk newest → older until digitalRoot(Date) === digitalRoot(Time/回).
 * 2. That shared root is the key digit K.
 * 3. Across all history, for each number column keep only values whose
 *    digital root equals K, then pick the most common (mode).
 */
export function computeFavoriteTwo(
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    triggeredBy: FavoriteTwoResult['triggeredBy'] = 'demo',
): FavoriteTwoResult {
    const history = historyNewestFirst;
    const { scanRows, matchedRow, keyRoot } = scanDateTimeKey(history);
    const max = numberMaxForType(lotteryType);
    /** Every ball in range whose digital root equals the key. */
    const pool = keyRoot == null ? [] : candidatesForKeyRoot(keyRoot, max);
    const mains = mainCount(lotteryType);
    const bonuses = bonusCount(lotteryType);
    const chronological = [...history].reverse();
    const used = new Set<number>();
    const columns: FavoriteTwoColumnTrace[] = [];
    const winningNumbers: number[] = [];
    const bonusNumbers: number[] = [];

    const buildColumn = (
        kind: 'main' | 'bonus',
        columnIndex: number,
        columnValues: number[],
        usedSet: Set<number>,
    ): { trace: FavoriteTwoColumnTrace; picked: number } => {
        const eligibleValues =
            keyRoot == null
                ? []
                : columnValues.filter(
                      (v) => v > 0 && digitalRootOfNumber(v) === keyRoot,
                  );
        const frequencies = rankFrequencies(eligibleValues);
        const rankedSet = new Set(frequencies.map((f) => f.digit));
        const extras = pool.filter((n) => !rankedSet.has(n));
        const { picked, mode, usedFallback } = pickFromFrequencies(
            frequencies,
            usedSet,
            max,
            extras,
        );
        if (picked > 0) usedSet.add(picked);
        return {
            picked,
            trace: {
                columnIndex,
                kind,
                columnValues,
                eligibleValues,
                frequencies,
                modeDigit: mode,
                pickedDigit: picked,
                usedFallback,
            },
        };
    };

    for (let col = 0; col < mains; col++) {
        const columnValues = chronological.map((r) => r.winningNumbers[col] ?? 0);
        const { trace, picked } = buildColumn('main', col, columnValues, used);
        winningNumbers.push(picked);
        columns.push(trace);
    }

    for (let col = 0; col < bonuses; col++) {
        const columnValues = chronological.map((r) => r.bonusNumbers[col] ?? 0);
        // Bonus balls are drawn from the remaining balls, so they must avoid
        // the mains as well as each other.
        const { trace, picked } = buildColumn('bonus', col, columnValues, used);
        bonusNumbers.push(picked);
        columns.push(trace);
    }

    return {
        lotteryType,
        keyRoot,
        scanRows,
        matchedRow,
        history,
        winningNumbers,
        bonusNumbers,
        columns,
        triggeredBy,
    };
}

/**
 * Demo history with intentional Date/Time digital-root skips, then a match.
 * Time column = draw number (回/Time) per Excel import mapping.
 */
export function demoFavoriteTwoHistory(lotteryType: LotteryType): DrawWindowRow[] {
    if (lotteryType === 'lotto6') {
        return [
            // date DR 1, time DR 7 — skip
            {
                drawNumber: '2140',
                drawDate: '2026-09-18',
                winningNumbers: [5, 12, 19, 27, 34, 41],
                bonusNumbers: [8],
            },
            // date DR 6, time DR 6 — MATCH key=6
            // 2026-09-23 → 2+0+2+6+0+9+2+3=24→6 ; 2139 → 15→6
            {
                drawNumber: '2139',
                drawDate: '2026-09-23',
                winningNumbers: [6, 15, 21, 28, 33, 42],
                bonusNumbers: [24],
            },
            {
                drawNumber: '2138',
                drawDate: '2026-09-11',
                winningNumbers: [6, 11, 17, 25, 34, 43],
                bonusNumbers: [15],
            },
            {
                drawNumber: '2137',
                drawDate: '2026-09-08',
                winningNumbers: [5, 15, 19, 27, 36, 41],
                bonusNumbers: [6],
            },
            {
                drawNumber: '2136',
                drawDate: '2026-09-04',
                winningNumbers: [6, 12, 21, 28, 34, 39],
                bonusNumbers: [15],
            },
            {
                drawNumber: '2135',
                drawDate: '2026-09-01',
                winningNumbers: [3, 14, 19, 24, 33, 41],
                bonusNumbers: [7],
            },
            {
                drawNumber: '2134',
                drawDate: '2026-08-28',
                winningNumbers: [6, 12, 22, 27, 33, 42],
                bonusNumbers: [15],
            },
            {
                drawNumber: '2133',
                drawDate: '2026-08-25',
                winningNumbers: [6, 15, 20, 29, 35, 40],
                bonusNumbers: [8],
            },
            {
                drawNumber: '2132',
                drawDate: '2026-08-21',
                winningNumbers: [2, 9, 18, 24, 31, 42],
                bonusNumbers: [6],
            },
            {
                drawNumber: '2131',
                drawDate: '2026-08-18',
                winningNumbers: [6, 15, 21, 30, 33, 39],
                bonusNumbers: [24],
            },
            {
                drawNumber: '2130',
                drawDate: '2026-08-14',
                winningNumbers: [5, 11, 16, 25, 34, 43],
                bonusNumbers: [9],
            },
            {
                drawNumber: '2129',
                drawDate: '2026-08-11',
                winningNumbers: [6, 10, 22, 28, 33, 41],
                bonusNumbers: [15],
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
        // 2026-09-23 DR6, 618 → 15→6 MATCH
        {
            drawNumber: '618',
            drawDate: '2026-09-23',
            winningNumbers: [6, 9, 15, 18, 24, 30, 33],
            bonusNumbers: [6, 15],
        },
        {
            drawNumber: '617',
            drawDate: '2026-09-09',
            winningNumbers: [6, 7, 15, 20, 24, 31, 37],
            bonusNumbers: [4, 24],
        },
        {
            drawNumber: '616',
            drawDate: '2026-09-05',
            winningNumbers: [1, 10, 15, 23, 26, 29, 33],
            bonusNumbers: [6, 18],
        },
        {
            drawNumber: '615',
            drawDate: '2026-09-02',
            winningNumbers: [6, 8, 14, 21, 24, 30, 36],
            bonusNumbers: [15, 12],
        },
        {
            drawNumber: '614',
            drawDate: '2026-08-29',
            winningNumbers: [3, 9, 15, 20, 27, 33, 37],
            bonusNumbers: [6, 18],
        },
        {
            drawNumber: '613',
            drawDate: '2026-08-26',
            winningNumbers: [6, 12, 15, 22, 24, 31, 35],
            bonusNumbers: [9, 15],
        },
        {
            drawNumber: '612',
            drawDate: '2026-08-22',
            winningNumbers: [2, 7, 14, 18, 25, 30, 36],
            bonusNumbers: [6, 21],
        },
        {
            drawNumber: '611',
            drawDate: '2026-08-19',
            winningNumbers: [6, 11, 15, 19, 24, 33, 37],
            bonusNumbers: [15, 8],
        },
        {
            drawNumber: '610',
            drawDate: '2026-08-15',
            winningNumbers: [5, 9, 16, 24, 28, 32, 36],
            bonusNumbers: [6, 12],
        },
    ];
}
