import type { LotteryType } from '@repo/types';
import type { DigitFrequency, DrawWindowRow } from '@/lib/algorithms/favorite-one';
import {
    candidatesForKeyRoot,
    demoFavoriteTwoHistory,
    numberMaxForType,
    scanDateTimeKey,
    type DateTimeScanRow,
} from '@/lib/algorithms/favorite-two';
import { firstUnusedInOrder } from '@/lib/algorithms/unique-pick';

export type FavoriteThreeColumnTrace = {
    columnIndex: number;
    kind: 'main' | 'bonus';
    columnValues: number[];
    /** Full candidate pool with digitalRoot === keyRoot (includes never-seen). */
    candidates: number[];
    /** Frequencies for every candidate (count may be 0). Sorted rarest → common. */
    frequencies: DigitFrequency[];
    /** Rarest before uniqueness. */
    rarestDigit: number;
    pickedDigit: number;
    usedFallback: boolean;
    /** True when the pick never appeared in this column's history. */
    absentFromHistory: boolean;
};

export type FavoriteThreeResult = {
    lotteryType: LotteryType;
    keyRoot: number | null;
    scanRows: DateTimeScanRow[];
    matchedRow: DateTimeScanRow | null;
    history: DrawWindowRow[];
    winningNumbers: number[];
    bonusNumbers: number[];
    columns: FavoriteThreeColumnTrace[];
    triggeredBy: 'draw' | 'import' | 'demo';
};

function mainCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 6 : 7;
}

function bonusCount(lotteryType: LotteryType): number {
    return lotteryType === 'lotto6' ? 1 : 2;
}

/** Count every candidate in range; include zeros for absent digits. Rarest first. */
function rankRarestFrequencies(
    columnValues: number[],
    candidates: number[],
): DigitFrequency[] {
    const counts = new Map<number, number>();
    for (const c of candidates) counts.set(c, 0);
    for (const v of columnValues) {
        if (!counts.has(v)) continue;
        counts.set(v, (counts.get(v) ?? 0) + 1);
    }
    const total = Math.max(1, columnValues.filter((v) => v > 0).length);
    return [...counts.entries()]
        .map(([digit, count]) => ({ digit, count, share: count / total }))
        .sort((a, b) => a.count - b.count || a.digit - b.digit);
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
    // The ranking already covers the whole key pool rarest-first (including
    // never-seen candidates at count 0); only the full ball range remains as
    // the safety net, and it still cannot repeat an already-picked number.
    const picked = firstUnusedInOrder(
        frequencies.map((f) => f.digit),
        [],
        used,
        max,
    );
    return { picked, rarest, usedFallback: picked > 0 && picked !== rarest };
}

/**
 * Favorite #3 — opposite of Favorite 2:
 * Same Date/Time digital-root key walk, then per column pick the
 * least common (or never-seen) digit whose digital root equals the key.
 */
export function computeFavoriteThree(
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    triggeredBy: FavoriteThreeResult['triggeredBy'] = 'demo',
): FavoriteThreeResult {
    const history = historyNewestFirst;
    const { scanRows, matchedRow, keyRoot } = scanDateTimeKey(history);
    const max = numberMaxForType(lotteryType);
    const candidates =
        keyRoot == null ? [] : candidatesForKeyRoot(keyRoot, max);
    const mains = mainCount(lotteryType);
    const bonuses = bonusCount(lotteryType);
    const chronological = [...history].reverse();
    const used = new Set<number>();
    const columns: FavoriteThreeColumnTrace[] = [];
    const winningNumbers: number[] = [];
    const bonusNumbers: number[] = [];

    const buildColumn = (
        kind: 'main' | 'bonus',
        columnIndex: number,
        columnValues: number[],
        usedSet: Set<number>,
    ): { trace: FavoriteThreeColumnTrace; picked: number } => {
        const frequencies = rankRarestFrequencies(columnValues, candidates);
        const { picked, rarest, usedFallback } = pickRarest(frequencies, usedSet, max);
        if (picked > 0) usedSet.add(picked);
        const histCount = columnValues.filter((v) => v === picked).length;
        return {
            picked,
            trace: {
                columnIndex,
                kind,
                columnValues,
                candidates: [...candidates],
                frequencies,
                rarestDigit: rarest,
                pickedDigit: picked,
                usedFallback,
                absentFromHistory: picked > 0 && histCount === 0,
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

export function demoFavoriteThreeHistory(lotteryType: LotteryType): DrawWindowRow[] {
    return demoFavoriteTwoHistory(lotteryType);
}
