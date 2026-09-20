/** Pull positive integers from typed or pasted lottery number text. */
export function parsePastedNumbers(raw: string): number[] {
    return (raw.match(/\d+/g) ?? [])
        .map((p) => Number.parseInt(p, 10))
        .filter((n) => Number.isInteger(n) && n > 0);
}

export function applyPastedNumbers(current: number[], startIndex: number, pasted: number[]): number[] {
    if (pasted.length === 0) return current;
    const next = [...current];
    const from = pasted.length >= current.length ? 0 : Math.max(0, startIndex);
    pasted.slice(0, current.length - from).forEach((n, i) => {
        next[from + i] = n;
    });
    return next;
}

export function parseNumberList(raw: string, count: number): number[] {
    const parts = parsePastedNumbers(raw).slice(0, count);
    while (parts.length < count) parts.push(0);
    return parts;
}
