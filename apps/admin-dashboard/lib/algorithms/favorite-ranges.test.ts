import { describe, expect, it } from 'vitest';
import { validateRange } from '@/lib/algorithms/algorithm-settings';
import { computeWindowSize } from '@/lib/algorithms/dynamic-window';
import { demoDrawWindow } from '@/lib/algorithms/favorite-one';
import { demoFavoriteTwoHistory, scanKeyInRange } from '@/lib/algorithms/favorite-two';

describe('validateRange', () => {
    it('accepts sane ranges', () => {
        expect(validateRange({ min: 7, max: 20 })).toBeNull();
        expect(validateRange({ min: 15, max: 15 })).toBeNull();
        expect(validateRange({ min: 1, max: 200 })).toBeNull();
    });
    it('rejects bad ranges', () => {
        expect(validateRange({ min: 20, max: 7 })).toBe('order');
        expect(validateRange({ min: 0, max: 10 })).toBe('limits');
        expect(validateRange({ min: 5, max: 201 })).toBe('limits');
        expect(validateRange({ min: Number.NaN, max: 10 })).toBe('integer');
        expect(validateRange({ min: 1.5, max: 10 })).toBe('integer');
    });
});

describe('computeWindowSize with a custom range', () => {
    const history = demoDrawWindow('lotto6');
    it('never goes outside [min, max]', () => {
        const r = computeWindowSize('lotto6', history, 10, 12);
        expect(r.windowSize).toBeGreaterThanOrEqual(Math.min(10, history.length));
        expect(r.windowSize).toBeLessThanOrEqual(12);
        expect(r.min).toBe(10);
        expect(r.max).toBe(12);
    });
});

describe('scanKeyInRange (Favorite 3/4)', () => {
    const demo = demoFavoriteTwoHistory('lotto6');
    it('without a range keeps the whole history', () => {
        expect(scanKeyInRange(demo).history).toHaveLength(demo.length);
    });
    it('searches the key only inside the newest max rows', () => {
        const r = scanKeyInRange(demo, { min: 1, max: 1 });
        expect(r.history).toHaveLength(1);
        expect(r.keyRoot).toBeNull(); // the key row is the 2nd row in the demo
    });
    it('uses at least min rows even when the key matches earlier', () => {
        const r = scanKeyInRange(demo, { min: 4, max: 5 });
        expect(r.keyRoot).not.toBeNull();
        expect(r.history.length).toBe(Math.min(demo.length, 4));
    });
    it('never returns more than max rows', () => {
        expect(scanKeyInRange(demo, { min: 1, max: 3 }).history.length).toBeLessThanOrEqual(3);
    });
});
