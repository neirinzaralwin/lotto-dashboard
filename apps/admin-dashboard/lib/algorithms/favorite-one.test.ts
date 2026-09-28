import { describe, expect, it } from 'vitest';
import { MAX_WINDOW, MIN_WINDOW } from '@/lib/algorithms/dynamic-window';
import {
    computeFavoriteOne,
    demoDrawWindow,
} from '@/lib/algorithms/favorite-one';

describe('computeFavoriteOne', () => {
    it('picks the mode digit per main column over the dynamic window', () => {
        const result = computeFavoriteOne('lotto6', demoDrawWindow('lotto6'), 'demo');

        expect(result.winningNumbers).toEqual([5, 12, 19, 27, 34, 41]);
        expect(result.bonusNumbers).toEqual([8]);
        expect(result.columns.filter((c) => c.kind === 'main')).toHaveLength(6);
    });

    it('sizes the window between 7 and 20 rows', () => {
        for (const type of ['lotto6', 'lotto7'] as const) {
            const result = computeFavoriteOne(type, demoDrawWindow(type), 'demo');
            expect(result.windowSize).toBeGreaterThanOrEqual(MIN_WINDOW);
            expect(result.windowSize).toBeLessThanOrEqual(MAX_WINDOW);
            expect(result.rows).toHaveLength(result.windowSize);
        }
        // The demo history is shaped so Lotto 6 needs more than the 7-row floor.
        expect(computeFavoriteOne('lotto6', demoDrawWindow('lotto6'), 'demo').windowSize).toBe(10);
    });

    it('exposes the per-column window trace alongside the frequency trace', () => {
        const result = computeFavoriteOne('lotto6', demoDrawWindow('lotto6'), 'demo');
        expect(result.window.columns).toHaveLength(7);
        for (const col of result.window.columns) {
            expect(col.lockRow).toBeGreaterThanOrEqual(MIN_WINDOW);
            expect(col.lockRow).toBeLessThanOrEqual(MAX_WINDOW);
        }
        // Every column locks at or before the resolved window.
        for (const col of result.window.columns) {
            expect(col.lockRow).toBeLessThanOrEqual(result.window.windowSize);
        }
    });

    it('exposes frequency traces for admin visualization', () => {
        const result = computeFavoriteOne('lotto6', demoDrawWindow('lotto6'), 'demo');
        const d1 = result.columns[0]!;
        const five = d1.frequencies.find((f) => f.digit === 5);
        expect(five?.count).toBeGreaterThan(0);
        expect(d1.modeDigit).toBe(5);
        expect(d1.pickedDigit).toBe(5);
    });
});
