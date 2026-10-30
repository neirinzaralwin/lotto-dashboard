import { normalizeDrawNumber } from '@/lib/draws/map';

/**
 * True when `query` names exactly this draw number.
 *
 * Draw numbers are stored as normalized digit strings ("233"), so a search for
 * 233 must not also return 2334 or 1233. Both sides are normalized first, which
 * also lets "第233回" or "0233" find draw 233.
 */
export function matchesDrawNumber(drawNumber: string, query: string): boolean {
    const needle = normalizeDrawNumber(query);
    if (!needle) return false;
    return normalizeDrawNumber(drawNumber) === needle;
}
