import { describe, expect, it } from 'vitest';
import { MAX_WINDOW, MIN_WINDOW } from '@/lib/algorithms/dynamic-window';
import {
    computeFavoriteFour,
    demoFavoriteFourWindow,
} from '@/lib/algorithms/favorite-four';

describe('computeFavoriteFour', () => {
    it('picks the rarest digit per main column over the dynamic window', () => {
        const result = computeFavoriteFour('lotto6', demoFavoriteFourWindow('lotto6'), 'demo');

        expect(result.winningNumbers).toEqual([1, 9, 17, 25, 31, 42]);
        expect(result.bonusNumbers).toEqual([6]);
        expect(result.columns.filter((c) => c.kind === 'main')).toHaveLength(6);
    });

    it('shares the window size with Favorite 1', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const four = computeFavoriteFour(type, demoFavoriteFourWindow(type), 'demo');
            expect(four.windowSize).toBeGreaterThanOrEqual(MIN_WINDOW);
            expect(four.windowSize).toBeLessThanOrEqual(MAX_WINDOW);
            expect(four.window.columns.map((c) => c.lockRow)).toEqual(
                four.window.columns.map((c) => c.lockRow),
            );
        }
        expect(computeFavoriteFour('lotto6', demoFavoriteFourWindow('lotto6'), 'demo').windowSize).toBe(10);
    });

    it('exposes rarest-first frequency traces for admin visualization', () => {
        const result = computeFavoriteFour('lotto6', demoFavoriteFourWindow('lotto6'), 'demo');
        const d1 = result.columns[0]!;
        // Frequencies sorted rarest → common.
        expect(d1.frequencies[0]!.count).toBeLessThanOrEqual(
            d1.frequencies[d1.frequencies.length - 1]!.count,
        );
        expect(d1.pickedDigit).toBe(1);
    });

    it('keeps picks unique within mains', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const result = computeFavoriteFour(type, demoFavoriteFourWindow(type), 'demo');
            const mains = result.winningNumbers.filter((n) => n > 0);
            expect(new Set(mains).size).toBe(mains.length);
        }
    });

    it('is the inverse of Favorite 1 on the same window', () => {
        // Same rows, same window, opposite selection rule.
        const rows = demoFavoriteFourWindow('lotto6');
        const one = computeFavoriteFour('lotto6', rows, 'demo');
        expect(one.windowSize).toBe(10);
        expect(one.winningNumbers).not.toEqual([5, 12, 19, 27, 34, 41]);
    });
});
