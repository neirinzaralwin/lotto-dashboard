import { describe, expect, it } from 'vitest';
import { computeWindowSize, MAX_WINDOW, MIN_WINDOW } from '@/lib/algorithms/dynamic-window';
import type { DrawWindowRow } from '@/lib/algorithms/favorite-one';

function row(n: number, mains: number[], bonuses: number[]): DrawWindowRow {
    return {
        drawNumber: String(2000 - n),
        drawDate: `2026-01-${String(28 - n).padStart(2, '0')}`,
        winningNumbers: mains,
        bonusNumbers: bonuses,
    };
}

describe('computeWindowSize', () => {
    it('never returns fewer than the 7-row floor', () => {
        // Every column repeats on row 2 — a naive first-repeat rule would pick 2.
        const h = [
            row(1, [5, 11, 19, 27, 34, 41], [8]),
            row(2, [5, 11, 19, 27, 34, 41], [8]),
            row(3, [6, 12, 20, 28, 35, 42], [9]),
            row(4, [7, 13, 21, 29, 36, 43], [10]),
            row(5, [1, 14, 22, 30, 37, 40], [11]),
            row(6, [2, 15, 23, 31, 38, 39], [12]),
            row(7, [3, 16, 24, 32, 33, 38], [13]),
        ];
        const result = computeWindowSize('lotto6', h);
        expect(result.windowSize).toBe(MIN_WINDOW);
        // The early repeats are recorded, not silently dropped.
        expect(result.columns.every((c) => c.earlyRepeats.length > 0)).toBe(true);
    });

    it('ignores repeats before the floor and keeps walking past them', () => {
        // D1 repeats at r2 (skipped) then again at r9 (locks).
        const h = [
            row(1, [5, 21, 22, 23, 24, 25], [30]),
            row(2, [5, 21, 22, 23, 24, 26], [31]),
            row(3, [6, 21, 22, 23, 24, 27], [32]),
            row(4, [7, 21, 22, 23, 24, 28], [33]),
            row(5, [8, 21, 22, 23, 24, 29], [34]),
            row(6, [9, 21, 22, 23, 24, 30], [35]),
            row(7, [10, 21, 22, 23, 24, 31], [36]),
            row(8, [11, 21, 22, 23, 24, 32], [37]),
            row(9, [5, 21, 22, 23, 24, 33], [38]),
        ];
        const d1 = computeWindowSize('lotto6', h).columns[0]!;
        expect(d1.lockRow).toBe(9);
        expect(d1.lockDigit).toBe(5);
        expect(d1.earlyRepeats.map((r) => r.row)).toEqual([2]);
    });

    it('caps at 20 rows when no column finds a qualifying repeat', () => {
        // All-distinct values per column for 20 rows.
        const h = Array.from({ length: MAX_WINDOW }, (_, i) =>
            row(i + 1, [i + 1, i + 2, i + 3, i + 4, i + 5, i + 6], [i + 7]),
        );
        const result = computeWindowSize('lotto6', h);
        expect(result.windowSize).toBe(MAX_WINDOW);
        expect(result.columns.every((c) => c.exhausted && c.lockDigit === null)).toBe(true);
    });

    it('handles short history without exceeding available rows', () => {
        const h = [
            row(1, [5, 11, 19, 27, 34, 41], [8]),
            row(2, [5, 11, 19, 27, 34, 41], [8]),
        ];
        const result = computeWindowSize('lotto6', h);
        expect(result.shortHistory).toBe(true);
        expect(result.windowSize).toBe(2);
        expect(result.rows).toHaveLength(2);
    });

    it('grows the window past 7 when a late column locks', () => {
        const h = Array.from({ length: MAX_WINDOW }, (_, i) =>
            row(i + 1, [5, 11 + i, 19, 27, 34, 41], [8 + (i % 3)]),
        );
        const result = computeWindowSize('lotto6', h);
        // D2 is all-distinct so it locks at the ceiling; bonus repeats at r3 but
        // that is below the floor so it keeps walking to r9.
        expect(result.windowSize).toBe(MAX_WINDOW);
        const b1 = result.columns[6]!;
        expect(b1.earlyRepeats.length).toBeGreaterThan(0);
    });
});
