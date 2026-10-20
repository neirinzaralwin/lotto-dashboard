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

/**
 * Balls from the newest draw. A number that just came out is less likely to
 * repeat next time, so the pickers treat these as already "used" and fall to
 * their next-ranked candidate — the algorithm itself is unchanged.
 */
export function latestDrawBalls(
    historyNewestFirst: { winningNumbers: number[]; bonusNumbers: number[] }[],
): number[] {
    const latest = historyNewestFirst[0];
    if (!latest) return [];
    return [...latest.winningNumbers, ...latest.bonusNumbers].filter((n) => n > 0);
}

export type PickOptions = {
    /** Skip every ball of the newest draw (default off; the live service turns it on). */
    excludeLatest?: boolean;
    /** Random source for tie-free choices (which single-digit ball to replace); injectable for tests. */
    rng?: () => number;
    /** History range in rows (admin setting); each algorithm applies it its own way. */
    window?: {
        min: number;
        max: number;
        /**
         * Exact number of draws to use (already inside Min–Max). When set it
         * replaces the data-driven size. The live service draws a fresh random
         * size in [Min, Max] on every regeneration.
         */
        size?: number;
    };
};

/** Random whole number in [min, max]; `rng` is injectable for tests. */
export function randomWindowSize(min: number, max: number, rng: () => number = Math.random): number {
    const lo = Math.min(min, max);
    const hi = Math.max(min, max);
    return lo + Math.floor(rng() * (hi - lo + 1));
}

/** At most this many single-digit (1–9) main balls in one favorite set. Bonus balls are not counted. */
export const MAX_SINGLE_DIGIT_MAINS = 2;

/** `used` plus 1–9, so a forced column can only pick its best two-digit candidate. */
export function blockSingleDigits(used: Set<number>): Set<number> {
    const out = new Set(used);
    for (let n = 1; n <= 9; n++) out.add(n);
    return out;
}

/**
 * Keep at most {@link MAX_SINGLE_DIGIT_MAINS} single-digit mains.
 * `run(forced)` computes the favorite with the given main columns restricted
 * to two-digit balls (each still takes its own best-ranked candidate).
 * When there are too many single digits, a random subset is kept and the rest
 * of those columns are re-picked as two-digit; repeats until the set is valid
 * (a re-pick can shift a later column onto a single digit).
 */
export function capSingleDigitMains<R extends { winningNumbers: number[] }>(
    run: (forced: ReadonlySet<number>) => R,
    rng: () => number = Math.random,
): R {
    const forced = new Set<number>();
    let result = run(forced);
    for (let guard = 0; guard < 10; guard++) {
        const singles = result.winningNumbers
            .map((n, i) => ({ n, i }))
            .filter(({ n, i }) => n >= 1 && n <= 9 && !forced.has(i))
            .map(({ i }) => i);
        const excess = singles.length - MAX_SINGLE_DIGIT_MAINS;
        if (excess <= 0) return result;
        // Fisher–Yates: which single digits survive is random.
        for (let k = singles.length - 1; k > 0; k--) {
            const j = Math.floor(rng() * (k + 1));
            [singles[k], singles[j]] = [singles[j]!, singles[k]!];
        }
        for (const i of singles.slice(0, excess)) forced.add(i);
        result = run(forced);
    }
    return result;
}
