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
    /** Source sheet name when auto-detected from a workbook. */
    sheetName?: string;
    rows: ParsedImportRow[];
    validCount: number;
    updateCount: number;
    invalidCount: number;
    inFileDupeCount: number;
    fileDateFrom: string | null;
    fileDateTo: string | null;
    conflict: ImportConflictSummary | null;
};

/** One or more lottery collections found in a single workbook. */
export type WorkbookImportResult = {
    previews: ImportPreview[];
};

export type ExistingByLotteryType = Partial<
    Record<LotteryType, Set<string> | Map<string, ExistingDrawSummary>>
>;

export type PreviewUpsertOptions = {
    /** When false, skip rows that already exist (Keep existing). Default true for backward compat. */
    replaceExisting?: boolean;
    /** When true, upserted rows are published immediately. Default false (drafts). */
    publish?: boolean;
};

/**
 * Admin sample.xlsx headers (canonical):
 *   Lotto 6: 回/Time, 抽せん日/Date, 1–6, Bonus
 *   Lotto 7: 回/Time, 抽せん日/Date, 1–7, Bonus1, Bonus2
 * Older Appli / demo aliases (Time, Date, Loto1–7, bonus…) are kept for fixtures.
 */
const HEADER_ALIASES: Record<string, string> = {
    // draw number
    time: 'drawNumber',
    '回/time': 'drawNumber',
    回: 'drawNumber',
    回別: 'drawNumber',
    draw: 'drawNumber',
    drawnumber: 'drawNumber',
    // draw date
    date: 'drawDate',
    '抽せん日/date': 'drawDate',
    抽せん日: 'drawDate',
    drawdate: 'drawDate',
    // main numbers — admin uses bare 1–7; legacy used Loto1–7 / 本数字N
    '1': 'n1',
    '2': 'n2',
    '3': 'n3',
    '4': 'n4',
    '5': 'n5',
    '6': 'n6',
    '7': 'n7',
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
    // bonus
    bonus: 'bonus',
    bonus1: 'bonus',
    bonus2: 'bonus2',
    ボーナス数字: 'bonus',
    ボーナス数字1: 'bonus',
    ボーナス数字2: 'bonus2',
};

function emptyPreview(lotteryType: LotteryType, sheetName?: string): ImportPreview {
    return {
        lotteryType,
        sheetName,
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

function resolveHeaderKey(cell: unknown): string | undefined {
    return HEADER_ALIASES[normHeader(cell)] ?? HEADER_ALIASES[String(cell ?? '').trim()];
}

function lotteryTypeFromSheetName(name: string): LotteryType | null {
    if (/loto\s*7/i.test(name)) return 'lotto7';
    if (/loto\s*6/i.test(name)) return 'lotto6';
    return null;
}

/** Infer lottery type from mapped header columns when the sheet name is ambiguous. */
function lotteryTypeFromColMap(colMap: Record<string, number>): LotteryType | null {
    if (colMap.drawNumber == null || colMap.n1 == null) return null;
    if (colMap.n7 != null || colMap.bonus2 != null) return 'lotto7';
    if (colMap.n6 != null || colMap.bonus != null) return 'lotto6';
    return null;
}

function toExistingMap(
    existing: Set<string> | Map<string, ExistingDrawSummary> | undefined,
): Map<string, ExistingDrawSummary> {
    if (!existing) return new Map();
    if (existing instanceof Map) return existing;
    return new Map([...existing].map((drawNumber) => [drawNumber, { drawDate: '' }] as const));
}

function findHeader(
    matrix: (string | number | Date | null)[][],
): { colMap: Record<string, number>; start: number } {
    const colMap: Record<string, number> = {};
    const headerRow = matrix[0] ?? [];
    headerRow.forEach((cell, idx) => {
        const key = resolveHeaderKey(cell);
        if (key) colMap[key] = idx;
    });

    let start = 1;
    if (colMap.drawNumber == null) {
        for (let r = 0; r < Math.min(matrix.length, 15); r++) {
            const row = matrix[r] ?? [];
            const mapped: Record<string, number> = {};
            row.forEach((cell, idx) => {
                const key = resolveHeaderKey(cell);
                if (key) mapped[key] = idx;
            });
            if (mapped.drawNumber != null && mapped.n1 != null) {
                Object.assign(colMap, mapped);
                start = r + 1;
                break;
            }
        }
    }
    return { colMap, start };
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
    sheetName?: string,
): ImportPreview {
    const validRows = rows.filter((r) => r.status === 'new' || r.status === 'will_update');
    const file = dateRange(validRows.map((r) => r.drawDate).filter(Boolean));
    const updateRows = rows.filter((r) => r.status === 'will_update');

    return {
        lotteryType,
        sheetName,
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

function cellEmpty(value: unknown): boolean {
    return value == null || value === '';
}

/**
 * Upcoming / reserved draws: only 回/Time is filled; date + numbers are blank.
 * Skip silently — not an error.
 */
function isUpcomingPlaceholder(
    rawRow: (string | number | Date | null)[],
    colMap: Record<string, number>,
    mains: string[],
    bonuses: string[],
): boolean {
    const drawRaw = colMap.drawNumber != null ? rawRow[colMap.drawNumber] : null;
    if (cellEmpty(drawRaw)) return false;

    const dateRaw = colMap.drawDate != null ? rawRow[colMap.drawDate] : null;
    if (!cellEmpty(dateRaw)) return false;

    for (const k of [...mains, ...bonuses]) {
        if (colMap[k] == null) continue;
        if (!cellEmpty(rawRow[colMap[k]])) return false;
    }
    return true;
}

function parseSheetRows(
    matrix: (string | number | Date | null)[][],
    lotteryType: LotteryType,
    existingByDraw: Map<string, ExistingDrawSummary>,
    sheetName?: string,
): ImportPreview {
    if (!matrix.length) return emptyPreview(lotteryType, sheetName);

    const { colMap, start } = findHeader(matrix);
    if (colMap.drawNumber == null || colMap.n1 == null) {
        return emptyPreview(lotteryType, sheetName);
    }

    const existingDrawNumbers = new Set(existingByDraw.keys());
    const mains = mainKeys(lotteryType);
    const bonuses = bonusKeys(lotteryType);
    const seenInFile = new Map<string, number>();
    const rows: ParsedImportRow[] = [];

    for (let i = start; i < matrix.length; i++) {
        const rawRow = matrix[i] ?? [];
        if (rawRow.every((c) => cellEmpty(c))) continue;
        // Draw number only — reserved upcoming slot, not a failed row
        if (isUpcomingPlaceholder(rawRow, colMap, mains, bonuses)) continue;

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

    return summarize(lotteryType, rows, existingByDraw, sheetName);
}

/**
 * Auto-detect Lotto 6 / Lotto 7 collections in a workbook.
 * - Sheet names like `new loto6` / `new loto7` win when present.
 * - Otherwise headers decide (column `7` / Bonus2 → lotto7; else lotto6).
 * - Files may contain one collection or both; each type is mapped at most once.
 */
export function parseLotteryWorkbookCollections(
    buffer: ArrayBuffer,
    existingByType: ExistingByLotteryType = {},
): WorkbookImportResult {
    const workbook = XLSX.read(buffer, { type: 'array', cellDates: false });
    const found = new Map<LotteryType, ImportPreview>();

    for (const sheetName of workbook.SheetNames) {
        const sheet = workbook.Sheets[sheetName];
        if (!sheet) continue;

        const matrix = XLSX.utils.sheet_to_json<(string | number | Date | null)[]>(sheet, {
            header: 1,
            defval: null,
            raw: true,
        });
        if (!matrix.length) continue;

        const { colMap } = findHeader(matrix);
        const fromName = lotteryTypeFromSheetName(sheetName);
        const fromHeaders = lotteryTypeFromColMap(colMap);
        const lotteryType = fromName ?? fromHeaders;
        if (!lotteryType) continue;
        // Named sheet must still look like results data
        if (fromHeaders == null && fromName == null) continue;
        if (colMap.drawNumber == null || colMap.n1 == null) continue;
        if (found.has(lotteryType)) continue;

        const preview = parseSheetRows(
            matrix,
            lotteryType,
            toExistingMap(existingByType[lotteryType]),
            sheetName,
        );
        found.set(lotteryType, preview);
    }

    // Stable order: lotto6 then lotto7
    const previews: ImportPreview[] = [];
    if (found.has('lotto6')) previews.push(found.get('lotto6')!);
    if (found.has('lotto7')) previews.push(found.get('lotto7')!);
    return { previews };
}

/**
 * Parse a single lottery type from a workbook (legacy / targeted).
 * Prefers a matching named sheet; otherwise uses auto-detect and filters.
 */
export function parseLotteryWorkbook(
    buffer: ArrayBuffer,
    lotteryType: LotteryType,
    existing:
        | Set<string>
        | Map<string, ExistingDrawSummary> = new Map(),
): ImportPreview {
    const { previews } = parseLotteryWorkbookCollections(buffer, {
        [lotteryType]: existing,
    });
    const match = previews.find((p) => p.lotteryType === lotteryType);
    return match ?? emptyPreview(lotteryType);
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

export function previewsToUpsertPayload(
    previews: ImportPreview[],
    options: PreviewUpsertOptions = {},
): DrawCreateInput[] {
    return previews.flatMap((p) => previewToUpsertPayload(p, options));
}

export function sumPreviewCounts(previews: ImportPreview[]) {
    return previews.reduce(
        (acc, p) => ({
            validCount: acc.validCount + p.validCount,
            updateCount: acc.updateCount + p.updateCount,
            invalidCount: acc.invalidCount + p.invalidCount,
            inFileDupeCount: acc.inFileDupeCount + p.inFileDupeCount,
            rowCount: acc.rowCount + p.rows.length,
        }),
        { validCount: 0, updateCount: 0, invalidCount: 0, inFileDupeCount: 0, rowCount: 0 },
    );
}

export function mergeConflicts(previews: ImportPreview[]): ImportConflictSummary | null {
    const conflicts = previews
        .map((p) => p.conflict)
        .filter((c): c is ImportConflictSummary => c != null && c.count > 0);
    if (conflicts.length === 0) return null;
    if (conflicts.length === 1) return conflicts[0]!;

    const allUpdateRows = previews.flatMap((p) => p.rows.filter((r) => r.status === 'will_update'));
    const drawFrom = conflicts.map((c) => c.drawNumberFrom).filter(Boolean) as string[];
    const drawTo = conflicts.map((c) => c.drawNumberTo).filter(Boolean) as string[];
    const fileFrom = conflicts.map((c) => c.fileDateFrom).filter(Boolean) as string[];
    const fileTo = conflicts.map((c) => c.fileDateTo).filter(Boolean) as string[];
    const existingFrom = conflicts.map((c) => c.existingDateFrom).filter(Boolean) as string[];
    const existingTo = conflicts.map((c) => c.existingDateTo).filter(Boolean) as string[];
    const draws = drawNumberRange([...drawFrom, ...drawTo]);
    const file = dateRange([...fileFrom, ...fileTo]);
    const existing = dateRange([...existingFrom, ...existingTo]);
    return {
        count: allUpdateRows.length,
        drawNumberFrom: draws.from,
        drawNumberTo: draws.to,
        fileDateFrom: file.from,
        fileDateTo: file.to,
        existingDateFrom: existing.from,
        existingDateTo: existing.to,
    };
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
    return workbookBufferFromSheets([{ name: sheetName, rows }]);
}

export function workbookBufferFromSheets(
    sheets: { name: string; rows: (string | number | null)[][] }[],
): ArrayBuffer {
    const workbook = XLSX.utils.book_new();
    for (const { name, rows } of sheets) {
        XLSX.utils.book_append_sheet(workbook, XLSX.utils.aoa_to_sheet(rows), name);
    }
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

/** Canonical headers from admin sample.xlsx (docs/sample.xlsx). */
export const IMPORT_TEMPLATE_LOTO6_HEADER = [
    '回/Time',
    '抽せん日/Date',
    1,
    2,
    3,
    4,
    5,
    6,
    'Bonus',
] as const;

export const IMPORT_TEMPLATE_LOTO7_HEADER = [
    '回/Time',
    '抽せん日/Date',
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    'Bonus1',
    'Bonus2',
] as const;

export const IMPORT_TEMPLATE_FILENAME = 'lotto-import-template.xlsx';

/** Excel serial (Windows epoch) for a calendar YYYY-MM-DD — matches sample.xlsx. */
export function isoDateToExcelSerial(iso: string): number {
    const match = /^(\d{4})-(\d{2})-(\d{2})/.exec(iso.trim());
    if (!match) throw new Error(`Invalid ISO date: ${iso}`);
    const y = Number(match[1]);
    const m = Number(match[2]);
    const d = Number(match[3]);
    const utc = Date.UTC(y, m - 1, d);
    const epoch = Date.UTC(1899, 11, 30);
    return (utc - epoch) / 86400000;
}

function applyDrawDateColumnFormat(sheet: XLSX.WorkSheet): void {
    if (!sheet['!ref']) return;
    const range = XLSX.utils.decode_range(sheet['!ref']);
    // Column B (index 1) is 抽せん日/Date — same as docs/sample.xlsx
    for (let r = range.s.r + 1; r <= range.e.r; r++) {
        const addr = XLSX.utils.encode_cell({ r, c: 1 });
        const cell = sheet[addr] as XLSX.CellObject | undefined;
        if (!cell || cell.t !== 'n' || typeof cell.v !== 'number') continue;
        cell.z = 'yyyy/mm/dd';
    }
}

/** Small workbook admins can download, fill, and re-upload (mirrors docs/sample.xlsx). */
export function buildImportTemplateBuffer(): ArrayBuffer {
    const sheets = [
        {
            name: 'new loto6',
            rows: [
                [...IMPORT_TEMPLATE_LOTO6_HEADER],
                [1, isoDateToExcelSerial('2000-10-05'), 2, 8, 10, 13, 27, 30, 39],
                [2, isoDateToExcelSerial('2000-10-12'), 1, 9, 16, 20, 21, 43, 5],
                // Upcoming placeholder — draw number only; skipped on import
                [3, null, null, null, null, null, null, null, null],
            ] as (string | number | null)[][],
        },
        {
            name: 'new loto7',
            rows: [
                [...IMPORT_TEMPLATE_LOTO7_HEADER],
                [1, isoDateToExcelSerial('2013-04-05'), 7, 10, 12, 17, 23, 28, 34, 3, 15],
                [2, isoDateToExcelSerial('2013-04-12'), 20, 24, 29, 31, 33, 34, 35, 12, 32],
                [3, null, null, null, null, null, null, null, null, null, null],
            ] as (string | number | null)[][],
        },
    ];

    const workbook = XLSX.utils.book_new();
    for (const { name, rows } of sheets) {
        const sheet = XLSX.utils.aoa_to_sheet(rows);
        applyDrawDateColumnFormat(sheet);
        XLSX.utils.book_append_sheet(workbook, sheet, name);
    }
    // cellStyles keeps number formats (z) so Excel shows real dates, not plain numbers/text
    const out = XLSX.write(workbook, {
        type: 'array',
        bookType: 'xlsx',
        cellStyles: true,
    }) as ArrayBuffer | Uint8Array | number[];
    if (out instanceof ArrayBuffer) return out;
    if (out instanceof Uint8Array) {
        return out.buffer.slice(out.byteOffset, out.byteOffset + out.byteLength) as ArrayBuffer;
    }
    return Uint8Array.from(out).buffer as ArrayBuffer;
}

/** Trigger a browser download of the import template workbook. */
export function downloadImportTemplate(filename = IMPORT_TEMPLATE_FILENAME): void {
    const buffer = buildImportTemplateBuffer();
    const blob = new Blob([new Uint8Array(buffer)], {
        type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    a.rel = 'noopener';
    document.body.appendChild(a);
    a.click();
    a.remove();
    URL.revokeObjectURL(url);
}
