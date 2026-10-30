import { describe, expect, it } from 'vitest';
import { matchesDrawNumber } from '@/lib/draws/search';

describe('matchesDrawNumber', () => {
    it('matches the exact draw number', () => {
        expect(matchesDrawNumber('233', '233')).toBe(true);
    });

    it('does not match a draw number that only contains the query', () => {
        expect(matchesDrawNumber('2334', '233')).toBe(false);
        expect(matchesDrawNumber('1233', '233')).toBe(false);
    });

    it('ignores formatting and leading zeroes', () => {
        expect(matchesDrawNumber('233', '第233回')).toBe(true);
        expect(matchesDrawNumber('233', '0233')).toBe(true);
        expect(matchesDrawNumber('233', ' 233 ')).toBe(true);
    });

    it('does not match an empty or digit-free query', () => {
        expect(matchesDrawNumber('233', '')).toBe(false);
        expect(matchesDrawNumber('233', '   ')).toBe(false);
        expect(matchesDrawNumber('233', 'abc')).toBe(false);
    });
});
