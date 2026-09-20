export type LotteryType = 'lotto6' | 'lotto7';

export interface Draw {
    id: string;
    lotteryType: LotteryType;
    drawNumber: string;
    drawDate: string;
    winningNumbers: number[];
    bonusNumbers: number[];
    prizeInfo?: string | null;
    isPublished: boolean;
    createdAt: string;
    updatedAt: string;
}

export interface DrawCreateInput {
    lotteryType: LotteryType;
    drawNumber: string;
    drawDate: string;
    winningNumbers: number[];
    bonusNumbers?: number[];
    prizeInfo?: string | null;
    isPublished?: boolean;
}
