import { describe, expect, it } from 'vitest';
import { demoDrawWindow } from '@/lib/algorithms/favorite-one';
import { demoFavoriteTwoHistory } from '@/lib/algorithms/favorite-two';
import { previewSlot } from '@/lib/algorithms/range-preview';
import { randomWindowSize } from '@/lib/algorithms/unique-pick';

const window6 = demoDrawWindow('lotto6');
const key6 = demoFavoriteTwoHistory('lotto6');

describe('randomWindowSize', () => {
    it('always lands inside [min, max] and can hit both ends', () => {
        expect(randomWindowSize(7, 20, () => 0)).toBe(7);
        expect(randomWindowSize(7, 20, () => 0.999999)).toBe(20);
        for (let i = 0; i < 200; i++) {
            const n = randomWindowSize(7, 20);
            expect(n).toBeGreaterThanOrEqual(7);
            expect(n).toBeLessThanOrEqual(20);
        }
    });
    it('Min == Max is fixed', () => {
        expect(randomWindowSize(12, 12)).toBe(12);
    });
});

describe('previewSlot — Favorite 1/2 (random size inside Min–Max)', () => {
    it('Min == Max is a fixed window', () => {
        for (const slot of [1, 2] as const) {
            const p = previewSlot(slot, 'lotto6', window6, { min: 10, max: 10 });
            expect(p.size).toBe(10);
            expect(p.reason).toBe('fixed');
        }
    });
    it('uses exactly the sampled size, inside [min, max]', () => {
        for (const slot of [1, 2] as const) {
            for (const sample of [8, 10, 12]) {
                const p = previewSlot(slot, 'lotto6', window6, { min: 8, max: 12 }, undefined, sample);
                expect(p.size).toBe(sample);
                expect(p.reason).toBe('random');
            }
        }
    });
    it('different sizes use different rows', () => {
        const a = previewSlot(1, 'lotto6', window6, { min: 7, max: 20 }, undefined, 7);
        const b = previewSlot(1, 'lotto6', window6, { min: 7, max: 20 }, undefined, 14);
        expect(a.rows).toHaveLength(7);
        expect(b.rows).toHaveLength(14);
    });
});

describe('previewSlot — Favorite 3/4 (history size random inside Min–Max)', () => {
    it('no key inside Max → no pick', () => {
        for (const slot of [3, 4] as const) {
            const p = previewSlot(slot, 'lotto6', key6, { min: 1, max: 1 });
            expect(p.reason).toBe('noKey');
            expect(p.hasPick).toBe(false);
        }
    });
    it('history is exactly the sampled size', () => {
        const range = { min: 2, max: key6.length };
        for (const sample of [2, 3, key6.length]) {
            const p = previewSlot(3, 'lotto6', key6, range, undefined, sample);
            if (p.keyRow != null) {
                expect(p.size).toBe(Math.min(sample, key6.length));
                expect(p.reason).toBe('random');
            }
        }
    });
});
