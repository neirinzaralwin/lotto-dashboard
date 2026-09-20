import { describe, expect, it } from 'vitest';
import {
    buildConflictSummary,
    parseLotteryWorkbook,
    previewToUpsertPayload,
    workbookBufferFromMatrix,
    type ParsedImportRow,
} from '@/services/excel-import-service';

describe('parseLotteryWorkbook — Lotto 6', () => {
    const header = ['Time', 'Date', 'Loto1', 'Loto2', 'Loto3', 'Loto4', 'Loto5', 'Loto6', 'bonus'];

    it('parses Appli LOTO6-shaped rows as new', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            ['第2回', '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.lotteryType).toBe('lotto6');
        expect(preview.validCount).toBe(2);
        expect(preview.invalidCount).toBe(0);
        expect(preview.fileDateFrom).toBe('2024-01-01');
        expect(preview.fileDateTo).toBe('2024-01-08');
        expect(preview.rows[0]?.winningNumbers).toEqual([2, 8, 10, 13, 27, 30]);
        expect(preview.rows[0]?.bonusNumbers).toEqual([39]);
        expect(preview.rows[0]?.drawNumber).toContain('1');
    });

    it('marks existing draw numbers as will_update and builds conflict', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
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
            header,
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 99, 39],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.invalidCount).toBe(1);
        expect(preview.rows[0]?.status).toBe('invalid');
    });

    it('marks in-file duplicates and keeps last row', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            ['第1回', '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set());
        expect(preview.inFileDupeCount).toBe(1);
        expect(preview.validCount).toBe(1);
        const last = preview.rows.find((r) => r.status === 'new');
        expect(last?.winningNumbers).toEqual([1, 9, 16, 20, 21, 43]);
    });
});

describe('parseLotteryWorkbook — Lotto 7', () => {
    const header = [
        'Time',
        'Date',
        'Loto1',
        'Loto2',
        'Loto3',
        'Loto4',
        'Loto5',
        'Loto6',
        'Loto7',
        'bonus1',
        'bonus2',
    ];

    it('parses 7 mains + 2 bonus', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第1回', '2024-02-01', 1, 2, 3, 4, 5, 6, 7, 8, 9],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto7', new Set());
        expect(preview.lotteryType).toBe('lotto7');
        expect(preview.validCount).toBe(1);
        expect(preview.rows[0]?.winningNumbers).toEqual([1, 2, 3, 4, 5, 6, 7]);
        expect(preview.rows[0]?.bonusNumbers).toEqual([8, 9]);
    });

    it('invalid when missing Loto7 column values (zeros fail range)', () => {
        const buffer = workbookBufferFromMatrix([
            ['Time', 'Date', 'Loto1', 'Loto2', 'Loto3', 'Loto4', 'Loto5', 'Loto6', 'bonus', 'bonus2'],
            ['第1回', '2024-02-01', 1, 2, 3, 4, 5, 6, 8, 9],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto7', new Set());
        expect(preview.invalidCount).toBe(1);
    });

    it('previewToUpsertPayload uses lotteryType and draft status', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第3回', '2024-02-15', 1, 2, 3, 4, 5, 6, 7, 10, 11],
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

describe('previewToUpsertPayload — replace / keep', () => {
    const header = ['Time', 'Date', 'Loto1', 'Loto2', 'Loto3', 'Loto4', 'Loto5', 'Loto6', 'bonus'];

    it('keeps only new rows when replaceExisting is false', () => {
        const buffer = workbookBufferFromMatrix([
            header,
            ['第1回', '2024-01-01', 2, 8, 10, 13, 27, 30, 39],
            ['第2回', '2024-01-08', 1, 9, 16, 20, 21, 43, 5],
        ]);
        const preview = parseLotteryWorkbook(buffer, 'lotto6', new Set(['1']));
        const keep = previewToUpsertPayload(preview, { replaceExisting: false });
        const replace = previewToUpsertPayload(preview, { replaceExisting: true });
        expect(keep).toHaveLength(1);
        expect(keep[0]?.drawNumber).toBe('2');
        expect(replace).toHaveLength(2);
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
