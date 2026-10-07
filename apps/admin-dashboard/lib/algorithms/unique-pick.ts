/**
 * Shared uniqueness repair for the Favorite pickers.
 *
 * Each algorithm ranks its own candidates first (column mode, column rarest,
 * key-root order, …) — that ranking is passed in as `ranked` and is always
 * honoured in order, so the algorithmic intent is preserved. Only when every
 * ranked candidate is already used elsewhere in the same draw does the walk
 * continue into `extras` (still algorithm-flavoured: unseen key candidates,
 * unseen numbers, …) and finally the whole 1..max ball range ascending.
 * Returns 0 only when the range itself is exhausted (unreachable for
 * Lotto 6/7, which need at most 9 distinct balls from 37–43).
 */
export function firstUnusedInOrder(
    ranked: number[],
    extras: number[],
    used: Set<number>,
    max: number,
): number {
    for (const n of ranked) {
        if (Number.isFinite(n) && n >= 1 && n <= max && !used.has(n)) return n;
    }
    for (const n of extras) {
        if (Number.isFinite(n) && n >= 1 && n <= max && !used.has(n)) return n;
    }
    for (let n = 1; n <= max; n++) {
        if (!used.has(n)) return n;
    }
    return 0;
}

/** 1..max absent from `seen`, ascending — the algorithm-neutral tail. */
export function unseenAscending(seen: Set<number>, max: number): number[] {
    const out: number[] = [];
    for (let n = 1; n <= max; n++) {
        if (!seen.has(n)) out.push(n);
    }
    return out;
}

/**
 * Whole 1..max range ordered by how often each ball appears in `values`
 * (ties break toward the smaller ball, matching the column rankings).
 * Most-common flavors read it hottest-first, least-common flavors
 * coldest-first, so the beyond-algorithm fallback still follows the
 * algorithm's intent instead of converging on the same ascending fill.
 */
export function globalFrequencyOrder(
    values: number[],
    max: number,
    rarestFirst: boolean,
): number[] {
    const counts = new Map<number, number>();
    for (let n = 1; n <= max; n++) counts.set(n, 0);
    for (const v of values) {
        if (Number.isFinite(v) && v >= 1 && v <= max) {
            counts.set(v, (counts.get(v) ?? 0) + 1);
        }
    }
    return [...counts.entries()]
        .sort((a, b) => (rarestFirst ? a[1] - b[1] : b[1] - a[1]) || a[0] - b[0])
        .map(([n]) => n);
}
