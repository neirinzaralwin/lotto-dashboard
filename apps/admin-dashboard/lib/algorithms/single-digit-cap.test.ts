import { describe, expect, it } from 'vitest';
import { computeFavoriteFour, demoFavoriteFourWindow } from '@/lib/algorithms/favorite-four';
import { computeFavoriteOne, demoDrawWindow } from '@/lib/algorithms/favorite-one';
import { computeFavoriteThree } from '@/lib/algorithms/favorite-three';
import { computeFavoriteTwo, demoFavoriteTwoHistory } from '@/lib/algorithms/favorite-two';
import { capSingleDigitMains, MAX_SINGLE_DIGIT_MAINS } from '@/lib/algorithms/unique-pick';

const singles = (ns: number[]) => ns.filter((n) => n >= 1 && n <= 9).length;

describe('capSingleDigitMains', () => {
    // 4 6 8 19 31 43 → one of 4/6/8 must become two-digit; forced column i yields 10+i.
    const run = (forced: ReadonlySet<number>) => ({
        winningNumbers: [4, 6, 8, 19, 31, 43].map((n, i) => (forced.has(i) ? 10 + i : n)),
    });

    it('keeps two single digits and makes the third two-digit', () => {
        const r = capSingleDigitMains(run, () => 0);
        expect(singles(r.winningNumbers)).toBe(MAX_SINGLE_DIGIT_MAINS);
        expect(r.winningNumbers.slice(3)).toEqual([19, 31, 43]);
    });

    it('which single digit is replaced depends on the random source', () => {
        const a = capSingleDigitMains(run, () => 0).winningNumbers;
        const b = capSingleDigitMains(run, () => 0.99).winningNumbers;
        expect(a).not.toEqual(b);
    });

    it('leaves sets with ≤ 2 single digits untouched', () => {
        let calls = 0;
        const ok = () => {
            calls += 1;
            return { winningNumbers: [4, 6, 18, 19, 31, 43] };
        };
        expect(capSingleDigitMains(ok).winningNumbers).toEqual([4, 6, 18, 19, 31, 43]);
        expect(calls).toBe(1);
    });
});

describe('every favorite has at most two single-digit mains', () => {
    const window6 = demoDrawWindow('lotto6');
    const window4 = demoFavoriteFourWindow('lotto6');
    const key6 = demoFavoriteTwoHistory('lotto6');
    for (let size = 7; size <= 12; size++) {
        it(`window ${size}`, () => {
            const opts = { excludeLatest: true, window: { min: 7, max: 20, size } };
            for (const r of [
                computeFavoriteOne('lotto6', window6, 'demo', opts),
                computeFavoriteFour('lotto6', window4, 'demo', opts),
                computeFavoriteTwo('lotto6', key6, 'demo', opts),
                computeFavoriteThree('lotto6', key6, 'demo', opts),
            ]) {
                expect(singles(r.winningNumbers)).toBeLessThanOrEqual(MAX_SINGLE_DIGIT_MAINS);
                const all = [...r.winningNumbers, ...r.bonusNumbers].filter((n) => n > 0);
                expect(new Set(all).size).toBe(all.length);
            }
        });
    }
});
