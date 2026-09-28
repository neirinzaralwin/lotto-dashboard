import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { describe, expect, it } from 'vitest';
import {
    buildConflictSummary,
    buildImportTemplateBuffer,
    parseLotteryWorkbook,
    parseLotteryWorkbookCollections,
    previewToUpsertPayload,
    workbookBufferFromMatrix,
    workbookBufferFromSheets,
    type ParsedImportRow,
} from '@/services/excel-import-service';

/** Canonical admin headers from sample.xlsx / Sakura format. */
const LOTO6_HEADER = ['回/Time', '抽せん日/Date', 1, 2, 3, 4, 5, 6, 'Bonus'];
const LOTO7_HEADER = ['回/Time', '抽せん日/Date', 1, 2, 3, 4, 5, 6, 7, 'Bonus1', 'Bonus2'];

describe('parseLotteryWorkbook — Lotto 6', () => {
    it('parses admin sample-shaped rows as new', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            [2, '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.lotteryType).toBe('lotto6');
        expect(preview.validCount).toBe(2);
        expect(preview.invalidCount).toBe(0);
        expect(preview.fileDateFrom).toBe('2024-01-01');
        expect(preview.fileDateTo).toBe('2024-01-08');
        expect(preview.rows[0]?.winningNumbers).toEqual([2, 8, 10, 13, 27, 30]);
        expect(preview.rows[0]?.bonusNumbers).toEqual([39]);
        expect(preview.rows[0]?.drawNumber).toBe('1');
    });

    it('marks existing draw numbers as will_update and builds conflict', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
        ]);
        const existing = new Map([['1', { drawDate: '2023-12-01' }]]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', existing);
        expect(preview.updateCount).toBe(1);
        expect(preview.validCount).toBe(0);
        expect(preview.rows[0]?.status).toBe('will_update');
        expect(preview.conflict?.count).toBe(1);
        expect(preview.conflict?.existingDateFrom).toBe('2023-12-01');
        expect(preview.conflict?.fileDateFrom).toBe('2024-01-01');
    });

    it('marks invalid when wrong number count / range', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 99, 39],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.invalidCount).toBe(1);
        expect(preview.rows[0]?.status).toBe('invalid');
    });

    it('marks in-file duplicates and keeps last row', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            [1, '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.inFileDupeCount).toBe(1);
        expect(preview.validCount).toBe(1);
        const last = preview.rows.find((r) => r.status === 'new');
        expect(last?.winningNumbers).toEqual([1, 9, 16, 20, 21, 43]);
        expect(last?.drawDate).toBe('2024-01-08');
    });

    it('still accepts legacy Appli Loto1–6 headers', () => {
        const buffer = workbookBufferFromMatrix([
            ['Time', 'Date', 'Loto1', 'Loto2', 'Loto3', 'Loto4', 'Loto5', 'Loto6', 'bonus'],
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.validCount).toBe(1);
        expect(preview.rows[0]?.drawNumber).toBe('1');
        expect(preview.rows[0]?.winningNumbers).toEqual([2, 8, 10, 13, 27, 30]);
    });
});

describe('parseLotteryWorkbook — Lotto 7', () => {
    it('parses 7 mains + 2 bonus', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO7_HEADER,
            [1, '2024-02-01', 1, 2, 3, 4, 5, 6, 7, 8, 9],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto7', new Set());
        expect(preview.lotteryType).toBe('lotto7');
        expect(preview.validCount).toBe(1);
        expect(preview.rows[0]?.winningNumbers).toEqual([1, 2, 3, 4, 5, 6, 7]);
        expect(preview.rows[0]?.bonusNumbers).toEqual([8, 9]);
    });

    it('invalid when missing column 7 values (zeros fail range)', () => {
        const buffer = workbookBufferFromMatrix([
            ['回/Time', '抽せん日/Date', 1, 2, 3, 4, 5, 6, 'Bonus1', 'Bonus2'],
            [1, '2024-02-01', 1, 2, 3, 4, 5, 6, 8, 9],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto7', new Set());
        expect(preview.invalidCount).toBe(1);
    });

    it('previewToUpsertPayload uses lotteryType and draft status', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO7_HEADER,
            [3, '2024-02-15', 1, 2, 3, 4, 5, 6, 7, 10, 11],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto7', new Set());
        const payload = previewToUpsertPayload(preview);
        expect(payload).toHaveLength(1);
        expect(payload[0]?.lotteryType).toBe('lotto7');
        expect(payload[0]?.isPublished).toBe(false);
        const published = previewToUpsertPayload(preview, { publish: true });
        expect(published[0]?.isPublished).toBe(true);
    });
});

describe('parseLotteryWorkbookCollections — auto-detect sheets', () => {
    it('maps both new loto6 and new loto7 from sample.xlsx', () => {
        const filePath = resolve(__dirname, '../../../../docs/sample.xlsx');
        const file = readFileSync(filePath);
        const ab = file.buffer.slice(file.byteOffset, file.byteOffset + file.byteLength);
        const { previews } = parseLotteryWorkbookCollections(ab);
        expect(previews.map((p) => p.lotteryType)).toEqual(['lotto6', 'lotto7']);
        expect(previews[0]?.sheetName).toMatch(/loto\s*6/i);
        expect(previews[1]?.sheetName).toMatch(/loto\s*7/i);
        expect(previews[0]?.validCount).toBeGreaterThan(100);
        expect(previews[1]?.validCount).toBeGreaterThan(100);
        expect(previews[0]?.rows[0]?.drawDate).toBe('2000-10-05');
        expect(previews[1]?.rows[0]?.drawDate).toBe('2013-04-05');
    });

    it('maps only lotto6 when the workbook has a single collection', () => {
        const buffer = workbookBufferFromSheets([
            {
                name: 'new loto6',
                rows: [
                    LOTO6_HEADER,
                    [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
                ],
            },
        ]);
        const { previews } = parseLotteryWorkbookCollections(buffer);
        expect(previews).toHaveLength(1);
        expect(previews[0]?.lotteryType).toBe('lotto6');
        expect(previews[0]?.validCount).toBe(1);
    });

    it('maps only lotto7 when the workbook has a single collection', () => {
        const buffer = workbookBufferFromSheets([
            {
                name: 'results',
                rows: [
                    LOTO7_HEADER,
                    [1, '2024-02-01', 1, 2, 3, 4, 5, 6, 7, 8, 9],
                ],
            },
        ]);
        const { previews } = parseLotteryWorkbookCollections(buffer);
        expect(previews).toHaveLength(1);
        expect(previews[0]?.lotteryType).toBe('lotto7');
    });

    it('infers type from headers when sheet name is Sample data', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
        ]);
        const { previews } = parseLotteryWorkbookCollections(buffer);
        expect(previews).toHaveLength(1);
        expect(previews[0]?.lotteryType).toBe('lotto6');
    });

    it('skips upcoming rows that only have a draw number', () => {
        const buffer = workbookBufferFromSheets([
            {
                name: 'new loto6',
                rows: [
                    LOTO6_HEADER,
                    [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
                    [2, null, null, null, null, null, null, null, null],
                    [3, null, null, null, null, null, null, null, null],
                ],
            },
            {
                name: 'new loto7',
                rows: [
                    LOTO7_HEADER,
                    [1, '2024-02-01', 1, 2, 3, 4, 5, 6, 7, 8, 9],
                    [2, null, null, null, null, null, null, null, null, null, null],
                ],
            },
        ]);
        const { previews } = parseLotteryWorkbookCollections(buffer);
        expect(previews.map((p) => p.lotteryType)).toEqual(['lotto6', 'lotto7']);
        expect(previews[0]?.validCount).toBe(1);
        expect(previews[0]?.invalidCount).toBe(0);
        expect(previews[0]?.rows).toHaveLength(1);
        expect(previews[1]?.validCount).toBe(1);
        expect(previews[1]?.invalidCount).toBe(0);
        expect(previews[1]?.rows).toHaveLength(1);
    });

    it('sample.xlsx has no Needs-fix upcoming placeholders', () => {
        const filePath = resolve(__dirname, '../../../../docs/sample.xlsx');
        const file = readFileSync(filePath);
        const ab = file.buffer.slice(file.byteOffset, file.byteOffset + file.byteLength);
        const { previews } = parseLotteryWorkbookCollections(ab);
        const totals = previews.reduce(
            (acc, p) => ({
                rows: acc.rows + p.rows.length,
                invalid: acc.invalid + p.invalidCount,
                valid: acc.valid + p.validCount,
            }),
            { rows: 0, invalid: 0, valid: 0 },
        );
        expect(totals.invalid).toBe(0);
        expect(totals.valid).toBe(totals.rows);
        // Full history minus reserved upcoming slots (2140 + 695 complete draws)
        expect(totals.rows).toBe(2139 + 695);
    });
});

describe('parseLotteryWorkbook — multi-sheet sample.xlsx', () => {
    it('picks new loto6 / new loto7 by lottery type and keeps Excel calendar dates', () => {
        const filePath = resolve(__dirname, '../../../../docs/sample.xlsx');
        const file = readFileSync(filePath);
        const ab = file.buffer.slice(file.byteOffset, file.byteOffset + file.byteLength);

        const l6 = parseLotteryWorkbook(ab, 'lotto6', new Set());
        expect(l6.validCount).toBeGreaterThan(100);
        expect(l6.rows[0]?.drawNumber).toBe('1');
        expect(l6.rows[0]?.drawDate).toBe('2000-10-05');
        expect(l6.rows[0]?.winningNumbers).toEqual([2, 8, 10, 13, 27, 30]);
        expect(l6.rows[0]?.bonusNumbers).toEqual([39]);

        const l7 = parseLotteryWorkbook(ab, 'lotto7', new Set());
        expect(l7.validCount).toBeGreaterThan(100);
        expect(l7.rows[0]?.drawNumber).toBe('1');
        expect(l7.rows[0]?.drawDate).toBe('2013-04-05');
        expect(l7.rows[0]?.winningNumbers).toEqual([7, 10, 12, 17, 23, 28, 34]);
        expect(l7.rows[0]?.bonusNumbers).toEqual([3, 15]);
    });
});

describe('previewToUpsertPayload — replace / keep', () => {
    it('keeps only new rows when replaceExisting is false', () => {
        const buffer = workbookBufferFromMatrix([
            LOTO6_HEADER,
            [1, '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            [2, '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set(['1']));
        const keep = previewToUpsertPayload(preview, { replaceExisting: false });
        const replace = previewToUpsertPayload(preview, { replaceExisting: true });
        expect(keep).toHaveLength(1);
        expect(keep[0]?.drawNumber).toBe('2');
        expect(replace).toHaveLength(2);
    });
});

describe('buildImportTemplateBuffer', () => {
    it('produces a parseable workbook with both sheets and skips upcoming rows', () => {
        const { previews } = parseLotteryWorkbookCollections(buildImportTemplateBuffer());
        expect(previews.map((p) => p.lotteryType)).toEqual(['lotto6', 'lotto7']);
        expect(previews[0]?.sheetName).toBe('new loto6');
        expect(previews[1]?.sheetName).toBe('new loto7');
        expect(previews[0]?.validCount).toBe(2);
        expect(previews[1]?.validCount).toBe(2);
        expect(previews[0]?.invalidCount).toBe(0);
        expect(previews[1]?.invalidCount).toBe(0);
        expect(previews[0]?.rows[0]?.drawDate).toBe('2000-10-05');
        expect(previews[1]?.rows[0]?.drawDate).toBe('2013-04-05');
    });

    it('stores dates as Excel serials like docs/sample.xlsx', () => {
        const XLSX = require('xlsx') as typeof import('xlsx');
        const buffer = buildImportTemplateBuffer();
        const workbook = XLSX.read(buffer, { type: 'array', cellDates: false, cellNF: true });
        const l7 = workbook.Sheets['new loto7'];
        expect(l7).toBeTruthy();
        const b2 = l7!['B2'] as { t: string; v: number; z?: string; w?: string };
        expect(b2.t).toBe('n');
        expect(b2.v).toBe(41369);
        expect(b2.z).toBe('yyyy/mm/dd');
        expect(b2.w).toBe('2013/04/05');
        const l6 = workbook.Sheets['new loto6'];
        const b2l6 = l6!['B2'] as { t: string; v: number; z?: string };
        expect(b2l6.v).toBe(36804);
        expect(b2l6.z).toBe('yyyy/mm/dd');
    });
});

describe('buildConflictSummary', () => {
    it('computes draw and date ranges for overlapping rows', () => {
        const updateRows: ParsedImportRow[] = [
            {
                rowIndex: 2,
                drawNumber: '37',
                drawDate: '2024-01-08',
                winningNumbers: [1, 2, 3, 4, 5, 6],
                bonusNumbers: [7],
                status: 'will_update',
                errors: [],
                raw: {},
            },
            {
                rowIndex: 3,
                drawNumber: '48',
                drawDate: '2024-03-12',
                winningNumbers: [1, 2, 3, 4, 5, 6],
                bonusNumbers: [8],
                status: 'will_update',
                errors: [],
                raw: {},
            },
        ];
        const existing = new Map([
            ['37', { drawDate: '2023-11-01' }],
            ['48', { drawDate: '2023-12-15' }],
        ]);
        const conflict = buildConflictSummary(updateRows, existing);
        expect(conflict?.count).toBe(2);
        expect(conflict?.drawNumberFrom).toBe('37');
        expect(conflict?.drawNumberTo).toBe('48');
        expect(conflict?.fileDateFrom).toBe('2024-01-08');
        expect(conflict?.fileDateTo).toBe('2024-03-12');
        expect(conflict?.existingDateFrom).toBe('2023-11-01');
        expect(conflict?.existingDateTo).toBe('2023-12-15');
    });

    it('returns null when there are no update rows', () => {
        expect(buildConflictSummary([], new Map())).toBeNull();
    });
});
