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
