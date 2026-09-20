import type { LotteryType } from '@repo/types';

/** Returns an i18n key (e.g. draws.validateL6Mains) or null when valid. */
export function validateDrawNumbers(
    lotteryType: LotteryType,
    winningNumbers: number[],
    bonusNumbers: number[],
): string | null {
    if (lotteryType === 'lotto6') {
        if (winningNumbers.length !== 6) return 'draws.validateL6Mains';
        if (bonusNumbers.length !== 1) return 'draws.validateL6Bonus';
        if (!allInRange(winningNumbers, 1, 43) || !allInRange(bonusNumbers, 1, 43)) {
            return 'draws.validateL6Range';
        }
        if (hasDupes(winningNumbers)) return 'draws.validateMainUnique';
        return null;
    }

    if (winningNumbers.length !== 7) return 'draws.validateL7Mains';
    if (bonusNumbers.length !== 2) return 'draws.validateL7Bonus';
    if (!allInRange(winningNumbers, 1, 37) || !allInRange(bonusNumbers, 1, 37)) {
        return 'draws.validateL7Range';
    }
    if (hasDupes(winningNumbers)) return 'draws.validateMainUnique';
    if (hasDupes(bonusNumbers)) return 'draws.validateBonusUnique';
    return null;
}

function allInRange(nums: number[], min: number, max: number) {
    return nums.every((n) => Number.isInteger(n) && n >= min && n <= max);
}

function hasDupes(nums: number[]) {
    return new Set(nums).size !== nums.length;
}
