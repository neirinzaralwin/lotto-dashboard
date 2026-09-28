/** Repeated digit sum until a single digit (1–9, or 0 if empty). */
export function digitalRootFromDigits(digits: Iterable<number>): number {
    let sum = 0;
    let any = false;
    for (const d of digits) {
        if (!Number.isFinite(d) || d < 0) continue;
        any = true;
        sum += d;
    }
    if (!any) return 0;
    while (sum > 9) {
        let next = 0;
        while (sum > 0) {
            next += sum % 10;
            sum = Math.floor(sum / 10);
        }
        sum = next;
    }
    return sum;
}

export function digitalRootOfNumber(value: number): number {
    if (!Number.isFinite(value) || value <= 0) return 0;
    const n = Math.trunc(Math.abs(value));
    const r = n % 9;
    return r === 0 ? 9 : r;
}

/** Digital root of every digit in a string (dates, draw numbers, etc.). */
export function digitalRootOfString(raw: string): number {
    const digits: number[] = [];
    for (const ch of raw) {
        if (ch >= '0' && ch <= '9') digits.push(Number(ch));
    }
    return digitalRootFromDigits(digits);
}

/** Date column → digital root of YYYY-MM-DD (or any digit-bearing date string). */
export function digitalRootOfDate(drawDate: string): number {
    return digitalRootOfString(drawDate);
}

/** Time column (回/Time) → digital root of the draw number. */
export function digitalRootOfTime(drawNumber: string): number {
    return digitalRootOfString(drawNumber);
}
