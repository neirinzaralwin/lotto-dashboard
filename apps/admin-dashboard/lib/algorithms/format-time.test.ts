import { describe, expect, it } from 'vitest';
import { formatDrawDate, formatExactTime } from '@/lib/algorithms/format-time';

describe('formatExactTime', () => {
    it('formats the date and exact time with the Japan offset and no weekday', () => {
        expect(formatExactTime('2026-10-19T12:08:16.000Z', 'en')).toBe(
            '10/19/2026, 21:08:16 GMT+9',
        );
    });

    it('returns null when no timestamp is available', () => {
        expect(formatExactTime(null, 'en')).toBeNull();
    });
});

describe('formatDrawDate', () => {
    it('displays draw dates in ISO format', () => {
        expect(formatDrawDate('2001-07-05')).toBe('2001-07-05');
    });

    it('leaves unrecognized date values unchanged', () => {
        expect(formatDrawDate('not-a-date')).toBe('not-a-date');
    });
});
