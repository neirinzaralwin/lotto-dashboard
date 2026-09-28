import type { LotteryType } from '@repo/types';
import type { DrawWindowRow } from '@/lib/algorithms/favorite-one';

/** Never take fewer than this many rows, even if a column repeats early. */
export const MIN_WINDOW = 7;
/** Never walk further back than this. */
export const MAX_WINDOW = 20;

export type WindowColumnTrace = {
    name: string;
    kind: 'main' | 'bonus';
    columnValues: number[];
    /** Row where a digit first repeated, ignoring rows before MIN_WINDOW. */
    lockRow: number;
    /** The digit that caused the lock, if a real repeat was found. */
    lockDigit: number | null;
    /** Repeats found before MIN_WINDOW — skipped, the column kept walking. */
    earlyRepeats: { row: number; digit: number }[];
    /** True when no qualifying repeat existed, so the column locked at MAX_WINDOW. */
    exhausted: boolean;
};

export type WindowSizeResult = {
    rows: DrawWindowRow[];
    windowSize: number;
    columns: WindowColumnTrace[];
    /** True when history was shorter than MIN_WINDOW so no clamp was needed. */
    shortHistory: boolean;
};

function mainCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 6 : 7;
}

function bonusCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 1 : 2;
}

function columnSpecs(lotteryType: LotteryType) {
    return [
        ...Array.from({ length: mainCount(lotteryType) }, (_, i) => ({
            name: `D${i + 1}`,
            kind: 'main' as const,
            get: (r: DrawWindowRow) => r.winningNumbers[i],
        })),
        ...Array.from({ length: bonusCount(lotteryType) }, (_, i) => ({
            name: `B${i + 1}`,
            kind: 'bonus' as const,
            get: (r: DrawWindowRow) => r.bonusNumbers[i],
        })),
    ];
}

/**
 * Dynamic window size.
 *
 * Walk down from the newest row. For each digit column, find the first row
 * where that column repeats a digit it already showed. Repeats landing before
 * MIN_WINDOW are ignored — the column keeps walking, which is what lets the
 * window grow past 7. A column with no qualifying repeat locks at MAX_WINDOW.
 *
 * The window is the row where the last column locks.
 */
export function computeWindowSize(
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    min: number = MIN_WINDOW,
    max: number = MAX_WINDOW,
): WindowSizeResult {
    const available = Math.min(max, historyNewestFirst.length);
    const shortHistory = historyNewestFirst.length < min;
    const rows = historyNewestFirst.slice(0, available);

    const columns: WindowColumnTrace[] = columnSpecs(lotteryType).map((spec) => {
        const columnValues = rows.map((r) => spec.get(r) ?? 0);
        const seen = new Set<number>();
        const earlyRepeats: { row: number; digit: number }[] = [];
        let lockRow = max;
        let lockDigit: number | null = null;
        let exhausted = true;

        columnValues.forEach((v, i) => {
            const row = i + 1;
            if (v <= 0) return;
            if (seen.has(v)) {
                if (row < min) {
                    earlyRepeats.push({ row, digit: v });
                } else if (lockDigit === null) {
                    lockRow = row;
                    lockDigit = v;
                    exhausted = false;
                }
                return;
            }
            seen.add(v);
        });

        return {
            name: spec.name,
            kind: spec.kind,
            columnValues,
            lockRow,
            lockDigit,
            earlyRepeats,
            exhausted,
        };
    });

    const lastLock = columns.reduce((acc, c) => Math.max(acc, c.lockRow), min);
    const windowSize = shortHistory
        ? historyNewestFirst.length
        : Math.min(max, Math.max(min, Math.min(lastLock, available)));

    return { rows: rows.slice(0, windowSize), windowSize, columns, shortHistory };
}
