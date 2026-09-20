import type { LotteryType } from '@repo/types';

/**
 * Quick-fill prize copy staff can drop in, then edit.
 * Prefer per-tier prize money (円 / ¥). Winner counts (口) are optional extras.
 */
export const PRIZE_SUGGESTIONS: Record<LotteryType, string[]> = {
    lotto6: [
        '1st: ¥200,000,000 · 2nd: ¥10,000,000 · 3rd: ¥300,000 · 4th: ¥6,800 · 5th: ¥1,000',
        '1等: 200,000,000円 · 2等: 10,000,000円 · 3等: 300,000円 · 4等: 6,800円 · 5等: 1,000円',
        '1st: ¥0 (carryover) · 2nd: ¥8,500,000 · 3rd: ¥280,000 · 4th: ¥6,800 · 5th: ¥1,000',
        '1等: 0円（繰越） · 2等: 8,500,000円 · 3等: 280,000円 · 4等: 6,800円 · 5等: 1,000円',
    ],
    lotto7: [
        '1st: ¥600,000,000 · 2nd: ¥8,500,000 · 3rd: ¥620,000 · 4th: ¥9,800 · 5th: ¥1,500 · 6th: ¥1,000',
        '1等: 600,000,000円 · 2等: 8,500,000円 · 3等: 620,000円 · 4等: 9,800円 · 5等: 1,500円 · 6等: 1,000円',
        '1st: ¥0 (carryover) · 2nd: ¥7,200,000 · 3rd: ¥500,000 · 4th: ¥9,800 · 5th: ¥1,500 · 6th: ¥1,000',
        '1等: 0円（繰越） · 2等: 7,200,000円 · 3等: 500,000円 · 4等: 9,800円 · 5等: 1,500円 · 6等: 1,000円',
    ],
};
