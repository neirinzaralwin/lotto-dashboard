export type LotteryType = 'lotto6' | 'lotto7';

export interface Algorithm {
    id: string;
    name: string;
    description?: string | null;
    lotteryType: LotteryType;
    isEnabled: boolean;
    parameters: Record<string, unknown>;
    createdAt: string;
    updatedAt: string;
}

export interface Recommendation {
    id: string;
    algorithmId: string;
    lotteryType: LotteryType;
    numbers: number[];
    generatedAt: string;
    isPublished: boolean;
}
