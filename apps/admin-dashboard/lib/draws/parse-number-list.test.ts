import { describe, expect, it } from 'vitest';
import { applyPastedNumbers, parseNumberList, parsePastedNumbers } from './parse-number-list';

describe('parsePastedNumbers', () => {
    it('splits spaces, commas, and tabs', () => {
        expect(parsePastedNumbers('3 12,18\t27 31 42')).toEqual([3, 12, 18, 27, 31, 42]);
    });

    it('skips zeros and junk', () => {
        expect(parsePastedNumbers('3 12 18 0 0 0 + bonus 8')).toEqual([3, 12, 18, 8]);
    });
});

describe('applyPastedNumbers', () => {
    it('fills from the start when the paste covers the whole row', () => {
        expect(applyPastedNumbers([0, 0, 0, 0, 0, 0], 4, [3, 12, 18, 27, 31, 42])).toEqual([
            3, 12, 18, 27, 31, 42,
        ]);
    });

    it('fills from the focused cell for a short paste', () => {
        expect(applyPastedNumbers([3, 12, 0, 0, 0, 0], 2, [18, 27])).toEqual([3, 12, 18, 27, 0, 0]);
    });
});

describe('parseNumberList', () => {
    it('pads to the requested count with zeros', () => {
        expect(parseNumberList('3 12 18', 6)).toEqual([3, 12, 18, 0, 0, 0]);
    });
});
