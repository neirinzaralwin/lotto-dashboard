import type { Draw, DrawCreateInput, LotteryType } from '@repo/types';

export type DrawRow = {
    id: string;
    lottery_type: LotteryType;
    draw_number: string;
    draw_date: string;
    winning_numbers: number[];
    bonus_numbers: number[];
    prize_info: string | null;
    is_published: boolean;
    created_at: string;
    updated_at: string;
};

export function mapDrawRow(row: DrawRow): Draw {
    return {
        id: row.id,
        lotteryType: row.lottery_type,
        drawNumber: row.draw_number,
        drawDate: row.draw_date,
        winningNumbers: row.winning_numbers ?? [],
        bonusNumbers: row.bonus_numbers ?? [],
        prizeInfo: row.prize_info,
        isPublished: row.is_published,
        createdAt: row.created_at,
        updatedAt: row.updated_at,
    };
}

export function toDrawInsert(input: DrawCreateInput) {
    return {
        lottery_type: input.lotteryType,
        draw_number: input.drawNumber,
        draw_date: input.drawDate,
        winning_numbers: input.winningNumbers,
        bonus_numbers: input.bonusNumbers ?? [],
        prize_info: input.prizeInfo ?? null,
        is_published: input.isPublished ?? false,
    };
}

export function normalizeDrawNumber(raw: string): string {
    const trimmed = raw.trim();
    const match = trimmed.match(/(\d+)/);
    if (!match?.[1]) return trimmed;
    return String(Number.parseInt(match[1], 10));
}
