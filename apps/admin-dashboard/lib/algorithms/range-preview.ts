import type { LotteryType } from '@repo/types';
import {
    type FavoriteRange,
    type FavoriteSlotNo,
} from '@/lib/algorithms/algorithm-settings';
import { computeFavoriteFour } from '@/lib/algorithms/favorite-four';
import { computeFavoriteOne, type DrawWindowRow } from '@/lib/algorithms/favorite-one';
import { computeFavoriteThree } from '@/lib/algorithms/favorite-three';
import { computeFavoriteTwo } from '@/lib/algorithms/favorite-two';
import { randomWindowSize, type PickOptions } from '@/lib/algorithms/unique-pick';

/** Why a range produced the history size it did — shown next to the inputs. */
export type PreviewReason =
    | 'random' // Min < Max: a random size inside the range (this is one sample)
    | 'fixed' // Min == Max: exactly that many draws
    | 'atMin' // data wanted fewer draws than Min → Min wins
    | 'atMax' // data wanted more draws than Max → Max wins
    | 'data' // data decided, inside [Min, Max] → widening the range changes nothing
    | 'noKey' // Favorite 3/4: no Date/Time key inside the newest Max draws
    | 'short'; // fewer published draws than Min

export type RangePreview = {
    /** Draws actually used (newest first). */
    rows: DrawWindowRow[];
    size: number;
    /** Mains followed by bonus. */
    numbers: number[];
    reason: PreviewReason;
    /** Favorite 3/4: 1-based draw where the Date/Time key matched. */
    keyRow: number | null;
    /** False when the favorite would have no pick (Favorite 3/4 without a key). */
    hasPick: boolean;
};

const LIVE: PickOptions = { excludeLatest: true };

/**
 * Dry-run one favorite with a given range over already-fetched history
 * (newest first) — the same code path the live picks use, so a preview can
 * never disagree with what Save + Generate will produce.
 */
export function previewSlot(
    slot: FavoriteSlotNo,
    lotteryType: LotteryType,
    historyNewestFirst: DrawWindowRow[],
    range: FavoriteRange,
    options: PickOptions = LIVE,
    /** Sample size to preview; defaults to a fresh random one inside the range. */
    sampleSize: number = randomWindowSize(range.min, range.max),
): RangePreview {
    const input = historyNewestFirst.slice(0, range.max);
    const opts: PickOptions = { ...options, window: { ...range, size: sampleSize } };

    if (slot === 1 || slot === 2) {
        const r =
            slot === 1
                ? computeFavoriteOne(lotteryType, input, 'draw', opts)
                : computeFavoriteFour(lotteryType, input, 'draw', opts);
        const size = r.windowSize;
        const reason: PreviewReason = r.window.shortHistory
            ? 'short'
            : range.min === range.max
              ? 'fixed'
              : 'random';
        return {
            rows: r.rows,
            size,
            numbers: [...r.winningNumbers, ...r.bonusNumbers],
            reason,
            keyRow: null,
            hasPick: r.winningNumbers.some((n) => n > 0),
        };
    }

    const r =
        slot === 3
            ? computeFavoriteTwo(lotteryType, input, 'draw', opts)
            : computeFavoriteThree(lotteryType, input, 'draw', opts);
    const keyRow = r.keyRoot == null ? null : r.scanRows.length;
    const reason: PreviewReason =
        keyRow == null
            ? 'noKey'
            : range.min === range.max
              ? 'fixed'
              : 'random';
    return {
        rows: r.history,
        size: r.history.length,
        numbers: [...r.winningNumbers, ...r.bonusNumbers],
        reason,
        keyRow,
        hasPick: keyRow != null && r.winningNumbers.some((n) => n > 0),
    };
}
