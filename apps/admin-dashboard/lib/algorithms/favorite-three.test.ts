import { describe, expect, it } from 'vitest';
import { digitalRootOfNumber } from '@/lib/algorithms/digital-root';
import { computeFavoriteTwo, demoFavoriteTwoHistory } from '@/lib/algorithms/favorite-two';
import { computeFavoriteThree } from '@/lib/algorithms/favorite-three';

describe('computeFavoriteThree', () => {
    it('uses the same Date/Time key as Favorite 2', () => {
        const history = demoFavoriteTwoHistory('lotto6');
        const two = computeFavoriteTwo('lotto6', history, 'demo');
        const three = computeFavoriteThree('lotto6', history, 'demo');

        expect(three.keyRoot).toBe(two.keyRoot);
        expect(three.keyRoot).toBe(6);
        expect(three.matchedRow?.drawNumber).toBe(two.matchedRow?.drawNumber);
    });

    it('picks rarest / never-seen key-root digits (opposite of Favorite 2 mode)', () => {
        const history = demoFavoriteTwoHistory('lotto6');
        const two = computeFavoriteTwo('lotto6', history, 'demo');
        const three = computeFavoriteThree('lotto6', history, 'demo');

        // Fav2 D1 tends toward common 6; Fav3 should prefer a rarer DR=6 ball
        expect(digitalRootOfNumber(three.winningNumbers[0]!)).toBe(6);
        expect(three.columns[0]?.frequencies[0]?.count).toBeLessThanOrEqual(
            three.columns[0]!.frequencies.at(-1)!.count,
        );
        // Opposite outcome on D1 for this demo set
        expect(three.winningNumbers[0]).not.toBe(two.winningNumbers[0]);
        expect(three.columns[0]?.absentFromHistory || three.columns[0]!.frequencies[0]!.count === 0).toBe(
            true,
        );
    });
});
