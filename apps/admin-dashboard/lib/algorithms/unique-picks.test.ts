import { describe, expect, it } from 'vitest';
import { digitalRootOfNumber } from '@/lib/algorithms/digital-root';
import {
    computeFavoriteOne,
    type DrawWindowRow,
} from '@/lib/algorithms/favorite-one';
import { computeFavoriteTwo } from '@/lib/algorithms/favorite-two';
import { computeFavoriteThree } from '@/lib/algorithms/favorite-three';
import { computeFavoriteFour } from '@/lib/algorithms/favorite-four';

/**
 * Regression: every column used to fall back to its mode/rarest winner even
 * when that number was already picked, producing draws like
 * [4, 13, 22, 31, 22, 31, 31] + bonus [4, 31]. A valid Lotto 6/7 draw needs
 * distinct balls across mains AND bonus (bonus comes from the remaining
 * balls), so the repair must walk the algorithm's own ranking for an unused
 * number instead of repeating.
 */
function staleRow(main: number, bonus: number, mains: number): DrawWindowRow {
    return {
        drawNumber: '2139',
        drawDate: '2026-09-23',
        winningNumbers: Array.from({ length: mains }, () => main),
        bonusNumbers: [bonus, bonus],
    };
}

function staleHistory(main: number, bonus: number, mains: number): DrawWindowRow[] {
    return Array.from({ length: 12 }, () => staleRow(main, bonus, mains));
}

function customHistory(mainsRows: number[][], bonus: number[]): DrawWindowRow[] {
    return mainsRows.map((winningNumbers) => ({
        drawNumber: '2139',
        drawDate: '2026-09-23',
        winningNumbers,
        bonusNumbers: [bonus[0] ?? 0, bonus[1] ?? 0],
    }));
}

function drawSet(winningNumbers: number[], bonusNumbers: number[]): string {
    return [...winningNumbers, ...bonusNumbers].sort((a, b) => a - b).join(',');
}

function expectValidDraw(
    winningNumbers: number[],
    bonusNumbers: number[],
    mains: number,
    bonuses: number,
    max: number,
) {
    expect(winningNumbers).toHaveLength(mains);
    expect(bonusNumbers).toHaveLength(bonuses);
    const all = [...winningNumbers, ...bonusNumbers];
    for (const n of all) {
        expect(n).toBeGreaterThanOrEqual(1);
        expect(n).toBeLessThanOrEqual(max);
    }
    // No duplicates anywhere in the displayed draw.
    expect(new Set(all).size).toBe(all.length);
    // Bonus never repeats a main (drawn from the remaining balls).
    for (const b of bonusNumbers) {
        expect(winningNumbers).not.toContain(b);
    }
}

describe('favorite uniqueness repair', () => {
    it('Favorite 1 keeps the mode but repairs the rest', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const mains = type === 'lotto6' ? 6 : 7;
            const bonuses = type === 'lotto6' ? 1 : 2;
            const result = computeFavoriteOne(type, staleHistory(9, 9, mains), 'demo');
            // Algorithm still followed: the free mode 9 is picked first.
            expect(result.winningNumbers[0]).toBe(9);
            expectValidDraw(
                result.winningNumbers,
                result.bonusNumbers,
                mains,
                bonuses,
                type === 'lotto6' ? 43 : 37,
            );
        }
    });

    it('Favorite 4 keeps rarest-first but repairs duplicates', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const mains = type === 'lotto6' ? 6 : 7;
            const bonuses = type === 'lotto6' ? 1 : 2;
            const result = computeFavoriteFour(type, staleHistory(9, 9, mains), 'demo');
            // 9 is the only observed ball, so it still wins the first free
            // column; the repair only kicks in where a repeat would occur.
            expect(result.winningNumbers[0]).toBe(9);
            expectValidDraw(
                result.winningNumbers,
                result.bonusNumbers,
                mains,
                bonuses,
                type === 'lotto6' ? 43 : 37,
            );
        }
    });

    it('Favorite 2 (date/time most common) never repeats, even past the key pool', () => {
        // Screenshot case: lotto7 slot 3 showed 22/31 repeated in mains and
        // 4/31 repeated from mains into bonus.
        for (const type of ['lotto6', 'lotto7'] as const) {
            const mains = type === 'lotto6' ? 6 : 7;
            const bonuses = type === 'lotto6' ? 1 : 2;
            const result = computeFavoriteTwo(type, staleHistory(6, 6, mains), 'demo');
            expect(result.keyRoot).toBe(6);
            // Algorithm still followed: the free mode 6 is picked first.
            expect(result.winningNumbers[0]).toBe(6);
            expectValidDraw(
                result.winningNumbers,
                result.bonusNumbers,
                mains,
                bonuses,
                type === 'lotto6' ? 43 : 37,
            );
        }
    });

    it('Favorite 3 (date/time least common) stays in-key while the pool lasts', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const mains = type === 'lotto6' ? 6 : 7;
            const bonuses = type === 'lotto6' ? 1 : 2;
            const result = computeFavoriteThree(type, staleHistory(6, 6, mains), 'demo');
            expect(result.keyRoot).toBe(6);
            // Rarest-first: an unseen key ball (DR 6) wins while one is free.
            expect(digitalRootOfNumber(result.winningNumbers[0]!)).toBe(6);
            expect(result.winningNumbers[0]).toBe(15);
            expectValidDraw(
                result.winningNumbers,
                result.bonusNumbers,
                mains,
                bonuses,
                type === 'lotto6' ? 43 : 37,
            );
        }
    });

    it('Favorite 1 and Favorite 4 stay distinct flavors past exhaustion', () => {
        // Column 0 mixes a globally hot ball (43) into all-5 columns. Both
        // flavors consume the observed balls, but the fillers must differ:
        // hottest-first vs coldest-first.
        const rows = customHistory(
            [
                [43, 5, 5, 5, 5, 5],
                [5, 5, 5, 5, 5, 5],
                [43, 5, 5, 5, 5, 5],
                [5, 5, 5, 5, 5, 5],
                [43, 5, 5, 5, 5, 5],
                [5, 5, 5, 5, 5, 5],
                [43, 5, 5, 5, 5, 5],
            ],
            [9, 9],
        );
        const one = computeFavoriteOne('lotto6', rows, 'demo');
        const four = computeFavoriteFour('lotto6', rows, 'demo');
        expectValidDraw(one.winningNumbers, one.bonusNumbers, 6, 1, 43);
        expectValidDraw(four.winningNumbers, four.bonusNumbers, 6, 1, 43);
        expect(drawSet(one.winningNumbers, one.bonusNumbers)).not.toBe(
            drawSet(four.winningNumbers, four.bonusNumbers),
        );
    });

    it('Favorite 3 and Favorite 4 stay distinct flavors past the key pool', () => {
        // Regression for identical tickets: the date/time key pool (4 balls
        // for lotto7) is smaller than the 9 slots, so both flavors consume
        // the whole pool — the fillers must then differ (hottest vs coldest).
        const rows = customHistory(
            [
                [37, 6, 6, 6, 6, 6, 6],
                [6, 6, 6, 6, 6, 6, 6],
                [37, 6, 6, 6, 6, 6, 6],
                [6, 6, 6, 6, 6, 6, 6],
                [37, 6, 6, 6, 6, 6, 6],
                [6, 6, 6, 6, 6, 6, 6],
                [37, 6, 6, 6, 6, 6, 6],
            ],
            [37, 37],
        );
        const two = computeFavoriteTwo('lotto7', rows, 'demo');
        const three = computeFavoriteThree('lotto7', rows, 'demo');
        expect(two.keyRoot).toBe(6);
        expect(three.keyRoot).toBe(6);
        expectValidDraw(two.winningNumbers, two.bonusNumbers, 7, 2, 37);
        expectValidDraw(three.winningNumbers, three.bonusNumbers, 7, 2, 37);
        expect(drawSet(two.winningNumbers, two.bonusNumbers)).not.toBe(
            drawSet(three.winningNumbers, three.bonusNumbers),
        );
    });
});
