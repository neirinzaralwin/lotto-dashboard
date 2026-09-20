import type { DrawCreateInput, LotteryType } from '@repo/types';
import * as XLSX from 'xlsx';
import { normalizeDrawNumber } from '@/lib/draws/map';
import { validateDrawNumbers } from '@/lib/draws/validate';

export type ImportRowStatus = 'new' | 'will_update' | 'invalid' | 'in_file_dupe';

export type ParsedImportRow = {
    rowIndex: number;
    drawNumber: string;
    drawDate: string;
    winningNumbers: number[];
    bonusNumbers: number[];
    status: ImportRowStatus;
    errors: string[];
    raw: Record<string, unknown>;
};

export type ExistingDrawSummary = {
    drawDate: string;
};

export type ImportConflictSummary = {
    count: number;
    drawNumberFrom: string | null;
    drawNumberTo: string | null;
    fileDateFrom: string | null;
    fileDateTo: string | null;
    existingDateFrom: string | null;
    existingDateTo: string | null;
};

export type ImportPreview = {
    lotteryType: LotteryType;
    rows: ParsedImportRow[];
    validCount: number;
    updateCount: number;
    invalidCount: number;
    inFileDupeCount: number;
    fileDateFrom: string | null;
    fileDateTo: string | null;
    conflict: ImportConflictSummary | null;
};

export type PreviewUpsertOptions = {
    /** When false, skip rows that already exist (Keep existing). Default true for backward compat. */
    replaceExisting?: boolean;
    /** When true, upserted rows are published immediately. Default false (drafts). */
    publish?: boolean;
};

const HEADER_ALIASES: Record<string, string> = {
    time: 'drawNumber',
    回別: 'drawNumber',
    draw: 'drawNumber',
    drawnumber: 'drawNumber',
    date: 'drawDate',
    抽せん日: 'drawDate',
    drawdate: 'drawDate',
    loto1: 'n1',
    loto2: 'n2',
    loto3: 'n3',
    loto4: 'n4',
    loto5: 'n5',
    loto6: 'n6',
    loto7: 'n7',
    本数字1: 'n1',
    本数字2: 'n2',
    本数字3: 'n3',
    本数字4: 'n4',
    本数字5: 'n5',
    本数字6: 'n6',
    本数字7: 'n7',
    bonus: 'bonus',
    bonus1: 'bonus',
    bonus2: 'bonus2',
    ボーナス数字: 'bonus',
    ボーナス数字1: 'bonus',
    ボーナス数字2: 'bonus2',
};

function emptyPreview(lotteryType: LotteryType): ImportPreview {
    return {
        lotteryType,
        rows: [],
        validCount: 0,
        updateCount: 0,
        invalidCount: 0,
        inFileDupeCount: 0,
        fileDateFrom: null,
        fileDateTo: null,
        conflict: null,
    };
}

function mainKeys(lotteryType: LotteryType): string[] {
    return lotteryType === 'lotto6'
        ? ['n1', 'n2', 'n3', 'n4', 'n5', 'n6']
        : ['n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'n7'];
}

function bonusKeys(lotteryType: LotteryType): string[] {
    return lotteryType === 'lotto6' ? ['bonus'] : ['bonus', 'bonus2'];
}

function normHeader(h: unknown): string {
    return String(h ?? '')
        .trim()
        .toLowerCase()
        .replace(/\s+/g, '');
}

function excelSerialToIso(serial: number): string {
    // Excel Windows epoch 1899-12-30
    const utc = Date.UTC(1899, 11, 30) + serial * 86400000;
    return new Date(utc).toISOString().slice(0, 10);
}

function parseDate(value: unknown): string | null {
    if (value == null || value === '') return null;
    if (typeof value === 'number' && Number.isFinite(value)) {
        return excelSerialToIso(value);
    }
    if (value instanceof Date && !Number.isNaN(value.getTime())) {
        return value.toISOString().slice(0, 10);
    }
    const s = String(value).trim();
    if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
    const d = new Date(s);
    if (!Number.isNaN(d.getTime())) return d.toISOString().slice(0, 10);
    return null;
}

function toInt(value: unknown): number | null {
    if (typeof value === 'number' && Number.isFinite(value)) return Math.trunc(value);
    if (typeof value === 'string' && value.trim()) {
        const n = Number.parseInt(value.trim(), 10);
        return Number.isFinite(n) ? n : null;
    }
    return null;
}

function dateRange(dates: string[]): { from: string | null; to: string | null } {
    const sorted = dates.filter(Boolean).slice().sort();
    if (sorted.length === 0) return { from: null, to: null };
    return { from: sorted[0] ?? null, to: sorted[sorted.length - 1] ?? null };
}

function drawNumberRange(numbers: string[]): { from: string | null; to: string | null } {
    if (numbers.length === 0) return { from: null, to: null };
    const sorted = numbers.slice().sort((a, b) => {
        const na = Number.parseInt(a, 10);
        const nb = Number.parseInt(b, 10);
        if (Number.isFinite(na) && Number.isFinite(nb) && na !== nb) return na - nb;
        return a.localeCompare(b);
    });
    return { from: sorted[0] ?? null, to: sorted[sorted.length - 1] ?? null };
}

/** Build conflict summary for rows already saved in the system. */
export function buildConflictSummary(
    updateRows: ParsedImportRow[],
    existingByDraw: Map<string, ExistingDrawSummary>,
): ImportConflictSummary | null {
    if (updateRows.length === 0) return null;

    const drawNumbers = updateRows.map((r) => r.drawNumber).filter(Boolean);
    const fileDates = updateRows.map((r) => r.drawDate).filter(Boolean);
    const existingDates = updateRows
        .map((r) => existingByDraw.get(r.drawNumber)?.drawDate)
        .filter((d): d is string => Boolean(d));

    const draws = drawNumberRange(drawNumbers);
    const file = dateRange(fileDates);
    const existing = dateRange(existingDates);

    return {
        count: updateRows.length,
        drawNumberFrom: draws.from,
        drawNumberTo: draws.to,
        fileDateFrom: file.from,
        fileDateTo: file.to,
        existingDateFrom: existing.from,
        existingDateTo: existing.to,
    };
}

function summarize(
    lotteryType: LotteryType,
    rows: ParsedImportRow[],
    existingByDraw: Map<string, ExistingDrawSummary>,
): ImportPreview {
    const validRows = rows.filter((r) => r.status === 'new' || r.status === 'will_update');
    const file = dateRange(validRows.map((r) => r.drawDate).filter(Boolean));
    const updateRows = rows.filter((r) => r.status === 'will_update');

    return {
        lotteryType,
        rows,
        validCount: rows.filter((r) => r.status === 'new').length,
        updateCount: updateRows.length,
        invalidCount: rows.filter((r) => r.status === 'invalid').length,
        inFileDupeCount: rows.filter((r) => r.status === 'in_file_dupe').length,
        fileDateFrom: file.from,
        fileDateTo: file.to,
        conflict: buildConflictSummary(updateRows, existingByDraw),
    };
}

/**
 * Parse Appli LOTO6.xlsx-style (and mirrored Lotto 7) workbooks.
 * Lotto 6: Time, Date, Loto1–6, bonus
 * Lotto 7: Time, Date, Loto1–7, bonus / bonus1, bonus2
 *
 * `existingByDraw` may be a Set of draw numbers (legacy) or a Map with dates for conflict ranges.
 */
export function parseLotteryWorkbook(
    buffer: ArrayBuffer,
    lotteryType: LotteryType,
    existing:
        | Set<string>
        | Map<string, ExistingDrawSummary> = new Map(),
): ImportPreview {
    const existingByDraw =
        existing instanceof Map
            ? existing
            : new Map(
                  [...existing].map((drawNumber) => [drawNumber, { drawDate: '' }] as const),
              );
    const existingDrawNumbers = new Set(existingByDraw.keys());

    const workbook = XLSX.read(buffer, { type: 'array', cellDates: true });
    const preferred =
        workbook.SheetNames.find((n) => /sample\s*data/i.test(n)) ?? workbook.SheetNames[0];
    if (!preferred) return emptyPreview(lotteryType);

    const sheet = workbook.Sheets[preferred];
    if (!sheet) return emptyPreview(lotteryType);

    const matrix = XLSX.utils.sheet_to_json<(string | number | Date | null)[]>(sheet, {
        header: 1,
        defval: null,
        raw: true,
    });

    if (!matrix.length) return emptyPreview(lotteryType);

    const headerRow = matrix[0] ?? [];
    const colMap: Record<string, number> = {};
    headerRow.forEach((cell, idx) => {
        const key = HEADER_ALIASES[normHeader(cell)] ?? HEADER_ALIASES[String(cell ?? '').trim()];
        if (key) colMap[key] = idx;
    });

    // Japanese Sheet1 header row may be later — also accept if first row lacks Time
    let start = 1;
    if (colMap.drawNumber == null) {
        for (let r = 0; r < Math.min(matrix.length, 15); r++) {
            const row = matrix[r] ?? [];
            const mapped: Record<string, number> = {};
            row.forEach((cell, idx) => {
                const key =
                    HEADER_ALIASES[normHeader(cell)] ?? HEADER_ALIASES[String(cell ?? '').trim()];
                if (key) mapped[key] = idx;
            });
            if (mapped.drawNumber != null && mapped.n1 != null) {
                Object.assign(colMap, mapped);
                start = r + 1;
                break;
            }
        }
    }

    const mains = mainKeys(lotteryType);
    const bonuses = bonusKeys(lotteryType);
    const seenInFile = new Map<string, number>();
    const rows: ParsedImportRow[] = [];

    for (let i = start; i < matrix.length; i++) {
        const rawRow = matrix[i] ?? [];
        if (rawRow.every((c) => c == null || c === '')) continue;

        const errors: string[] = [];
        const drawRaw = colMap.drawNumber != null ? rawRow[colMap.drawNumber] : null;
        const drawNumber = drawRaw != null ? normalizeDrawNumber(String(drawRaw)) : '';
        if (!drawNumber) errors.push('import.errMissingDrawNumber');

        const drawDate = parseDate(colMap.drawDate != null ? rawRow[colMap.drawDate] : null);
        if (!drawDate) errors.push('import.errMissingDate');

        const winningNumbers = mains.map((k) => {
            const n = toInt(colMap[k] != null ? rawRow[colMap[k]] : null);
            return n ?? 0;
        });
        const bonusNumbers = bonuses.map((k) => {
            const n = toInt(colMap[k] != null ? rawRow[colMap[k]] : null);
            return n ?? 0;
        });

        const rangeError = validateDrawNumbers(lotteryType, winningNumbers, bonusNumbers);
        if (rangeError) errors.push(rangeError);

        let status: ImportRowStatus = errors.length ? 'invalid' : 'new';
        if (!errors.length && drawNumber) {
            if (seenInFile.has(drawNumber)) {
                status = 'in_file_dupe';
                errors.push(`import.errDuplicateInFile:${seenInFile.get(drawNumber)}`);
            } else {
                seenInFile.set(drawNumber, i + 1);
                status = existingDrawNumbers.has(drawNumber) ? 'will_update' : 'new';
            }
        }

        rows.push({
            rowIndex: i + 1,
            drawNumber,
            drawDate: drawDate ?? '',
            winningNumbers,
            bonusNumbers,
            status: errors.length && status !== 'in_file_dupe' ? 'invalid' : status,
            errors,
            raw: Object.fromEntries(
                Object.entries(colMap).map(([k, idx]) => [k, rawRow[idx] ?? null]),
            ),
        });
    }

    // Prefer last in-file row for each draw number
    const lastIndexByDraw = new Map<string, number>();
    rows.forEach((r, idx) => {
        if (r.drawNumber) lastIndexByDraw.set(r.drawNumber, idx);
    });
    rows.forEach((r, idx) => {
        if (!r.drawNumber || r.status === 'invalid') return;
        const last = lastIndexByDraw.get(r.drawNumber);
        if (last != null && last !== idx) {
            r.status = 'in_file_dupe';
            if (!r.errors.includes('import.errSuperseded')) {
                r.errors.push('import.errSuperseded');
            }
        } else if (existingDrawNumbers.has(r.drawNumber)) {
            r.status = 'will_update';
            r.errors = r.errors.filter((e) => !e.startsWith('import.errDuplicateInFile'));
        } else {
            r.status = 'new';
            r.errors = r.errors.filter((e) => !e.startsWith('import.errDuplicateInFile'));
        }
    });

    return summarize(lotteryType, rows, existingByDraw);
}

export function previewToUpsertPayload(
    preview: ImportPreview,
    options: PreviewUpsertOptions = {},
): DrawCreateInput[] {
    const replaceExisting = options.replaceExisting ?? true;
    const publish = options.publish ?? false;
    return preview.rows
        .filter((r) => {
            if (r.status === 'new') return true;
            if (r.status === 'will_update') return replaceExisting;
            return false;
        })
        .map((r) => ({
            lotteryType: preview.lotteryType,
            drawNumber: r.drawNumber,
            drawDate: r.drawDate,
            winningNumbers: r.winningNumbers,
            bonusNumbers: r.bonusNumbers,
            isPublished: publish,
        }));
}

/** Plain-language label for import row status. */
/** Returns an i18n key for the import row status pill. */
export function importStatusLabelKey(status: ImportRowStatus): string {
    switch (status) {
        case 'new':
            return 'import.statusNew';
        case 'will_update':
            return 'import.statusSaved';
        case 'in_file_dupe':
            return 'import.statusRepeated';
        case 'invalid':
            return 'import.statusNeedsFix';
    }
}

/** @deprecated Prefer importStatusLabelKey + t() */
export function importStatusLabel(status: ImportRowStatus): string {
    switch (status) {
        case 'new':
            return 'New';
        case 'will_update':
            return 'Already saved';
        case 'in_file_dupe':
            return 'Repeated in file';
        case 'invalid':
            return 'Needs fix';
    }
}

/** Build an in-memory xlsx buffer for tests or fixtures. */
export function workbookBufferFromMatrix(
    rows: (string | number | null)[][],
    sheetName = 'Sample data',
): ArrayBuffer {
    const sheet = XLSX.utils.aoa_to_sheet(rows);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, sheet, sheetName);
    const out = XLSX.write(workbook, { type: 'array', bookType: 'xlsx' }) as
        | ArrayBuffer
        | Uint8Array
        | number[];
    if (out instanceof ArrayBuffer) return out;
    if (out instanceof Uint8Array) {
        return out.buffer.slice(out.byteOffset, out.byteOffset + out.byteLength) as ArrayBuffer;
    }
    return Uint8Array.from(out).buffer as ArrayBuffer;
}
