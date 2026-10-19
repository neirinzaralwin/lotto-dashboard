import { describe, expect, it } from 'vitest';
import { changeLevel, countDiff } from '@/lib/algorithms/recommendations-service';

describe('countDiff', () => {
    it('compares per column', () => {
        expect(countDiff([1, 2, 3], [1, 2, 3])).toBe(0);
        expect(countDiff([1, 2, 3], [1, 9, 3])).toBe(1);
        expect(countDiff([1, 2], [2, 1])).toBe(2);
        expect(countDiff([1, 2], [1, 2, 3])).toBe(1);
    });
});

describe('changeLevel', () => {
    it('classifies lotto6 (7 balls)', () => {
        expect(changeLevel(0, 7)).toBe('unchanged');
        expect(changeLevel(1, 7)).toBe('slight');
        expect(changeLevel(2, 7)).toBe('slight');
        expect(changeLevel(3, 7)).toBe('changed');
    });
    it('classifies lotto7 (9 balls)', () => {
        expect(changeLevel(3, 9)).toBe('slight');
        expect(changeLevel(4, 9)).toBe('changed');
    });
});
