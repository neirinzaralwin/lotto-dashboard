import { describe, expect, it } from 'vitest';
import {
    digitalRootOfDate,
    digitalRootOfNumber,
    digitalRootOfTime,
} from '@/lib/algorithms/digital-root';
import {
    computeFavoriteTwo,
    demoFavoriteTwoHistory,
} from '@/lib/algorithms/favorite-two';

describe('digitalRoot', () => {
    it('reduces multi-digit numbers', () => {
        expect(digitalRootOfNumber(5)).toBe(5);
        expect(digitalRootOfNumber(21)).toBe(3);
        expect(digitalRootOfNumber(43)).toBe(7);
    });

    it('uses all digits in date and time (draw number)', () => {
        expect(digitalRootOfDate('2026-09-23')).toBe(6);
        expect(digitalRootOfTime('2139')).toBe(6);
        expect(digitalRootOfDate('2026-09-18')).toBe(1);
        expect(digitalRootOfTime('2140')).toBe(7);
    });
});

describe('computeFavoriteTwo', () => {
    it('skips rows until Date DR equals Time DR, then modes eligible digits', () => {
        const result = computeFavoriteTwo('lotto6', demoFavoriteTwoHistory('lotto6'), 'demo');

        expect(result.scanRows[0]?.matched).toBe(false);
        expect(result.matchedRow?.matched).toBe(true);
        expect(result.keyRoot).toBe(6);
        // D1 history is rich in 6 (DR=6); 5/3/2 are filtered out
        expect(result.winningNumbers[0]).toBe(6);
        expect(result.columns[0]?.eligibleValues.every((v) => digitalRootOfNumber(v) === 6)).toBe(
            true,
        );
    });
});
