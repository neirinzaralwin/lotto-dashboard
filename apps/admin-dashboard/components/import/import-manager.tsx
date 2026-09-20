'use client';

import Link from 'next/link';
import { useEffect, useMemo, useRef, useState, type DragEvent } from 'react';
import { CalendarRange, Check, FileSpreadsheet, Upload, X } from 'lucide-react';
import type { LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { StatusPill, QuietText } from '@/components/bento/primitives';
import { PageHeader } from '@/components/layout/page-header';
import { TablePagination } from '@/components/layout/table-pagination';
import { AppIcon } from '@/components/ui/icon';
import { createClient } from '@/lib/supabase/client';
import { listExistingDrawSummaries, upsertDraws } from '@/lib/draws/draws-service';
import {
    importStatusLabelKey,
    parseLotteryWorkbook,
    previewToUpsertPayload,
    type ImportPreview,
    type ImportRowStatus,
} from '@/services/excel-import-service';

const ACCEPTED_EXT = /\.(xlsx|xls|csv)$/i;
const PREVIEW_PAGE_SIZE = 10;

type RowFilter = 'all' | ImportRowStatus;
type OverlapChoice = 'keep' | 'replace';

function isAcceptedFile(file: File) {
    return ACCEPTED_EXT.test(file.name);
}

function formatPeriod(from: string | null, to: string | null): string {
    if (!from && !to) return '—';
    if (from && to && from !== to) return `${from} → ${to}`;
    return from ?? to ?? '—';
}

function statusTone(status: ImportRowStatus): 'strong' | 'caution' | 'excellent' | 'neutral' {
    switch (status) {
        case 'new':
            return 'strong';
        case 'will_update':
            return 'excellent';
        case 'in_file_dupe':
            return 'caution';
        case 'invalid':
            return 'neutral';
    }
}

function translateImportError(
    error: string,
    translate: (key: string, params?: Record<string, string | number>) => string,
): string {
    if (error.startsWith('import.errDuplicateInFile:')) {
        const row = error.slice('import.errDuplicateInFile:'.length);
        return translate('import.errDuplicateInFile', { row });
    }
    if (error.startsWith('import.') || error.startsWith('draws.')) {
        return translate(error);
    }
    return error;
}

function plainRowNote(
    status: ImportRowStatus,
    errors: string[],
    translate: (key: string, params?: Record<string, string | number>) => string,
): string {
    if (status === 'new') return translate('import.noteNew');
    if (status === 'will_update') return translate('import.noteUpdate');
    if (status === 'in_file_dupe') return translate('import.noteDupe');
    if (errors[0]) return translateImportError(errors[0], translate);
    return translate('import.noteInvalid');
}

export function ImportManager() {
    const { t } = useI18n();
    const [lotteryType, setLotteryType] = useState<LotteryType | null>(null);
    const [preview, setPreview] = useState<ImportPreview | null>(null);
    const [error, setError] = useState<string | null>(null);
    const [busy, setBusy] = useState(false);
    const [fileName, setFileName] = useState<string | null>(null);
    const [dragOver, setDragOver] = useState(false);
    const [rowFilter, setRowFilter] = useState<RowFilter>('all');
    const [overlapChoice, setOverlapChoice] = useState<OverlapChoice>('keep');
    const [previewPage, setPreviewPage] = useState(1);
    const [confirmOpen, setConfirmOpen] = useState(false);
    const [success, setSuccess] = useState<{
        lotteryType: LotteryType;
        count: number;
        published: boolean;
        message: string;
    } | null>(null);
    const dragDepth = useRef(0);

    function resetWizard() {
        setLotteryType(null);
        setPreview(null);
        setError(null);
        setFileName(null);
        setRowFilter('all');
        setOverlapChoice('keep');
        setPreviewPage(1);
        setConfirmOpen(false);
        setDragOver(false);
        dragDepth.current = 0;
        setBusy(false);
        setSuccess(null);
    }

    function onTypeChange(next: LotteryType) {
        setLotteryType(next);
        setPreview(null);
        setError(null);
        setSuccess(null);
        setFileName(null);
        setRowFilter('all');
        setOverlapChoice('keep');
        setPreviewPage(1);
        setConfirmOpen(false);
        setDragOver(false);
        dragDepth.current = 0;
    }

    async function onFile(file: File | null) {
        setSuccess(null);
        setError(null);
        setPreview(null);
        setRowFilter('all');
        setOverlapChoice('keep');
        setPreviewPage(1);
        setConfirmOpen(false);
        if (!file || !lotteryType) {
            setFileName(null);
            return;
        }
        setBusy(true);
        try {
            const buffer = await file.arrayBuffer();
            const client = createClient();
            const existing = await listExistingDrawSummaries(client, lotteryType);
            const next = parseLotteryWorkbook(buffer, lotteryType, existing);
            setPreview(next);
        } catch (err) {
            setError(err instanceof Error ? err.message : t('import.parseFailed'));
            setFileName(null);
        } finally {
            setBusy(false);
        }
    }

    function acceptFile(file: File | null) {
        if (!file) return;
        if (!isAcceptedFile(file)) {
            setError(t('import.badFileTypeShort'));
            setFileName(null);
            setPreview(null);
            return;
        }
        setFileName(file.name);
        void onFile(file);
    }

    function handleDragEnter(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        if (!typeSelected || busy) return;
        dragDepth.current += 1;
        setDragOver(true);
    }

    function handleDragLeave(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        dragDepth.current = Math.max(0, dragDepth.current - 1);
        if (dragDepth.current === 0) setDragOver(false);
    }

    function handleDragOver(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        if (typeSelected && !busy) {
            e.dataTransfer.dropEffect = 'copy';
        }
    }

    function handleDrop(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        dragDepth.current = 0;
        setDragOver(false);
        if (!typeSelected || busy) return;
        acceptFile(e.dataTransfer.files?.[0] ?? null);
    }

    const replaceExisting = overlapChoice === 'replace';
    const importNewCount = preview?.validCount ?? 0;
    const importUpdateCount =
        preview && replaceExisting ? preview.updateCount : 0;
    const willWriteCount = importNewCount + importUpdateCount;

    const confirmLabel = useMemo(() => {
        if (!preview) return t('nav.import');
        if (willWriteCount === 0) return t('import.nothingToImport');
        if (willWriteCount === 1) return t('import.importOne');
        return t('import.importMany', { count: willWriteCount });
    }, [preview, willWriteCount, t]);

    async function onConfirm(publish: boolean) {
        if (!preview) return;
        const snapshot = preview;
        const replace = replaceExisting;
        setConfirmOpen(false);
        setBusy(true);
        setError(null);
        try {
            const payload = previewToUpsertPayload(snapshot, {
                replaceExisting: replace,
                publish,
            });
            if (payload.length === 0) {
                setError(t('import.noRowsChoice'));
                return;
            }
            const client = createClient();
            const { upserted } = await upsertDraws(client, payload);
            const typeLabel = t(`common.${snapshot.lotteryType}`);
            const replaced = replace ? snapshot.updateCount : 0;
            const message =
                replaced > 0
                    ? t('import.savedWithReplace', {
                          count: upserted,
                          type: typeLabel,
                          newCount: snapshot.validCount,
                          replaced,
                      })
                    : t('import.savedNewOnly', {
                          count: upserted,
                          type: typeLabel,
                      });

            setSuccess({
                lotteryType: snapshot.lotteryType,
                count: upserted,
                published: publish,
                message,
            });
            setPreview(null);
            setFileName(null);
            setLotteryType(null);
            setRowFilter('all');
            setOverlapChoice('keep');
            setPreviewPage(1);
            setDragOver(false);
            dragDepth.current = 0;
        } catch (err) {
            setError(err instanceof Error ? err.message : t('import.importFailed'));
        } finally {
            setBusy(false);
        }
    }

    useEffect(() => {
        if (!confirmOpen) return;
        const onKey = (e: KeyboardEvent) => {
            if (e.key === 'Escape' && !busy) setConfirmOpen(false);
        };
        document.addEventListener('keydown', onKey);
        const prev = document.body.style.overflow;
        document.body.style.overflow = 'hidden';
        return () => {
            document.removeEventListener('keydown', onKey);
            document.body.style.overflow = prev;
        };
    }, [confirmOpen, busy]);

    const typeSelected = lotteryType != null;
    const dropEnabled = typeSelected && !busy;
    const step = !typeSelected ? 1 : preview ? 3 : 2;
    const showSuccess = success != null;

    const filteredRows = useMemo(() => {
        if (!preview) return [];
        if (rowFilter === 'all') return preview.rows;
        return preview.rows.filter((r) => r.status === rowFilter);
    }, [preview, rowFilter]);

    const previewPageCount = Math.max(1, Math.ceil(filteredRows.length / PREVIEW_PAGE_SIZE));
    const previewPageRows = useMemo(() => {
        const start = (previewPage - 1) * PREVIEW_PAGE_SIZE;
        return filteredRows.slice(start, start + PREVIEW_PAGE_SIZE);
    }, [filteredRows, previewPage]);

    useEffect(() => {
        if (previewPage > previewPageCount) {
            setPreviewPage(previewPageCount);
        }
    }, [previewPage, previewPageCount]);

    const steps = [
        { n: 1, label: t('import.stepChoose'), hint: t('import.stepHintChoose') },
        { n: 2, label: t('import.stepUpload'), hint: t('import.stepHintUpload') },
        { n: 3, label: t('import.stepImport'), hint: t('import.stepHintImport') },
    ];

    return (
        <div className="space-y-6 sm:space-y-8">
            <PageHeader
                crumbs={[
                    { label: t('brand.lotto'), href: '/' },
                    { label: t('import.crumbs') },
                ]}
                title={t('import.title')}
                subtitle={t('import.subtitle')}
                mark={<AppIcon icon={FileSpreadsheet} size={22} />}
            />

            {showSuccess && success ? (
                <section className="flex flex-col items-center rounded-[var(--lotto-radius)] border border-emerald-500/40 bg-emerald-50 px-6 py-10 text-center">
                    <div className="flex size-14 items-center justify-center rounded-full bg-emerald-600 text-white">
                        <Check className="size-7 stroke-[3]" aria-hidden />
                    </div>
                    <h2 className="mt-4 text-xl font-semibold tracking-[-0.02em] text-emerald-950">
                        {success.published ? t('import.publishedOk') : t('import.savedDrafts')}
                    </h2>
                    <p className="mt-2 max-w-md text-sm text-emerald-900/80">{success.message}</p>
                    <p className="mt-1 max-w-md text-sm text-emerald-900/70">
                        {success.published ? t('import.liveForApp') : t('import.stayPrivate')}
                    </p>
                    <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
                        <button
                            type="button"
                            onClick={resetWizard}
                            className="rounded-full border border-emerald-700/30 bg-white px-5 py-2.5 text-sm font-semibold text-emerald-950"
                        >
                            {t('import.importAnother')}
                        </button>
                        <Link
                            href={`/draws?type=${success.lotteryType}&status=${success.published ? 'published' : 'draft'}`}
                            className="rounded-full bg-emerald-700 px-5 py-2.5 text-sm font-semibold text-white"
                        >
                            {t('import.viewDraws')}
                        </Link>
                    </div>
                </section>
            ) : (
                <>
            <ol className="grid gap-2 sm:grid-cols-3">
                {steps.map((s) => {
                    const active = step === s.n;
                    const done = step > s.n;
                    return (
                        <li
                            key={s.n}
                            aria-current={active ? 'step' : undefined}
                            className={`flex items-start gap-3 rounded-[var(--lotto-radius-sm)] border px-4 py-3 text-sm ${
                                done
                                    ? 'border-emerald-500/50 bg-emerald-50 text-emerald-900'
                                    : active
                                      ? 'border-[var(--lotto-fg)] bg-[var(--lotto-surface)] font-semibold shadow-sm'
                                      : 'border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] text-[var(--lotto-muted-soft)]'
                            }`}
                        >
                            <span
                                className={`mt-0.5 flex size-7 shrink-0 items-center justify-center rounded-full text-xs font-bold ${
                                    done
                                        ? 'bg-emerald-600 text-white'
                                        : active
                                          ? 'bg-[var(--lotto-fg)] text-white'
                                          : 'bg-[var(--lotto-border)] text-[var(--lotto-muted)]'
                                }`}
                                aria-hidden
                            >
                                {done ? <Check className="size-4 stroke-[3]" /> : s.n}
                            </span>
                            <span className="min-w-0">
                                <span
                                    className={`block text-[0.65rem] uppercase tracking-[0.14em] ${
                                        done
                                            ? 'text-emerald-700'
                                            : active
                                              ? 'text-[var(--lotto-muted)]'
                                              : 'text-[var(--lotto-muted-soft)]'
                                    }`}
                                >
                                    {done ? t('import.stepDone') : t('import.stepN', { n: s.n })}
                                </span>
                                <span className="mt-0.5 block leading-snug">{s.label}</span>
                                <span
                                    className={`mt-0.5 block text-xs font-normal ${
                                        done ? 'text-emerald-700/80' : 'text-[var(--lotto-muted)]'
                                    }`}
                                >
                                    {done ? t('import.completed') : s.hint}
                                </span>
                            </span>
                        </li>
                    );
                })}
            </ol>

            <section className="space-y-3 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-4">
                <p className="text-[0.7rem] font-medium uppercase tracking-[0.16em] text-[var(--lotto-muted-soft)]">
                    {t('import.lotteryType')}
                </p>
                <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-1">
                    {(['lotto6', 'lotto7'] as const).map((game) => {
                        const active = lotteryType === game;
                        return (
                            <button
                                key={game}
                                type="button"
                                disabled={busy}
                                onClick={() => onTypeChange(game)}
                                className={`rounded-full px-4 py-1.5 text-sm transition-colors ${
                                    active
                                        ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                        : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                                }`}
                            >
                                {t(`common.${game}`)}
                            </button>
                        );
                    })}
                </div>
                <QuietText className="!text-sm">
                    {lotteryType
                        ? lotteryType === 'lotto6'
                            ? t('import.hint6')
                            : t('import.hint7')
                        : t('import.selectBeforeFile')}
                </QuietText>
            </section>

            <div
                aria-disabled={!dropEnabled}
                aria-label={t('import.dropAria')}
                onDragEnter={handleDragEnter}
                onDragLeave={handleDragLeave}
                onDragOver={handleDragOver}
                onDrop={handleDrop}
                className={`rounded-[var(--lotto-radius)] border-2 border-dashed px-4 py-8 transition-colors ${
                    !typeSelected
                        ? 'cursor-not-allowed border-[var(--lotto-border)] bg-[var(--lotto-surface)] opacity-60'
                        : dragOver
                          ? 'border-[var(--lotto-fg)] bg-[var(--lotto-strong-soft)]'
                          : 'border-[var(--lotto-border-strong)] bg-[var(--lotto-surface)]'
                }`}
            >
                <div className="flex flex-col items-center gap-4 text-center">
                    <div
                        className={`flex size-14 items-center justify-center rounded-2xl ${
                            dragOver
                                ? 'bg-[var(--lotto-fg)] text-white'
                                : 'bg-[var(--lotto-strong-soft)] text-[var(--lotto-fg)]'
                        }`}
                    >
                        <AppIcon icon={FileSpreadsheet} size={28} />
                    </div>
                    <div className="space-y-1">
                        <p className="text-sm font-semibold">
                            {dragOver
                                ? t('import.dropToUpload')
                                : typeSelected
                                  ? t('import.dragDropHere')
                                  : t('import.selectTypeFirst')}
                        </p>
                        <p className="text-sm text-[var(--lotto-muted)]">
                            {typeSelected
                                ? t('import.acceptsFormats')
                                : t('import.chooseTypeThenDrop')}
                        </p>
                        {fileName ? (
                            <p className="pt-1 text-sm font-medium text-[var(--lotto-strong)]">
                                {t('import.selected', { name: fileName })}
                            </p>
                        ) : null}
                    </div>
                    <label
                        className={`inline-flex items-center justify-center gap-2 rounded-full px-5 py-2.5 text-sm font-semibold ${
                            dropEnabled
                                ? 'cursor-pointer bg-[var(--lotto-fg)] text-white'
                                : 'cursor-not-allowed bg-[var(--lotto-border)] text-[var(--lotto-muted)]'
                        }`}
                    >
                        <AppIcon icon={Upload} size={16} />
                        {busy ? t('import.readingFile') : t('import.chooseFile')}
                        <input
                            type="file"
                            accept=".xlsx,.xls,.csv"
                            disabled={!dropEnabled}
                            className="sr-only"
                            onChange={(e) => {
                                acceptFile(e.target.files?.[0] ?? null);
                                e.target.value = '';
                            }}
                        />
                    </label>
                </div>
            </div>

            {error ? <p className="text-sm text-[#b42318]">{error}</p> : null}

            {preview ? (
                <div className="space-y-5">
                    {(preview.fileDateFrom || preview.fileDateTo) && (
                        <div className="flex flex-wrap items-center gap-3 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] px-4 py-3">
                            <div className="flex h-10 w-10 items-center justify-center rounded-[var(--lotto-radius-xs)] bg-[var(--lotto-surface-muted)]">
                                <AppIcon icon={CalendarRange} size={18} />
                            </div>
                            <div>
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('import.fileCovers')}
                                </p>
                                <p className="text-base font-semibold tracking-[-0.02em]">
                                    {formatPeriod(preview.fileDateFrom, preview.fileDateTo)}
                                </p>
                                <p className="text-sm text-[var(--lotto-muted)]">
                                    {t('import.rowsInPreview', {
                                        type: t(`common.${preview.lotteryType}`),
                                        count: preview.rows.length,
                                    })}
                                </p>
                            </div>
                        </div>
                    )}

                    <section className="rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-4 sm:p-5">
                        <div className="mb-4 flex flex-wrap items-end justify-between gap-2">
                            <div>
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('import.rowBreakdown')}
                                </p>
                                <p className="mt-1 text-sm text-[var(--lotto-muted)]">
                                    {t('import.rowBreakdownHint')}
                                </p>
                            </div>
                            <p className="text-sm font-semibold tabular-nums">
                                {t('import.totalRows', { count: preview.rows.length })}
                            </p>
                        </div>
                        <ul className="space-y-3">
                            {(
                                [
                                    {
                                        id: 'new' as const,
                                        label: t('import.statusNew'),
                                        hint: t('import.hintNew'),
                                        count: preview.validCount,
                                        bar: 'bg-sky-500',
                                        track: 'bg-sky-500/15',
                                    },
                                    {
                                        id: 'will_update' as const,
                                        label: t('import.statusSaved'),
                                        hint: t('import.hintSaved'),
                                        count: preview.updateCount,
                                        bar: 'bg-amber-500',
                                        track: 'bg-amber-500/15',
                                    },
                                    {
                                        id: 'in_file_dupe' as const,
                                        label: t('import.statusRepeated'),
                                        hint: t('import.hintRepeated'),
                                        count: preview.inFileDupeCount,
                                        bar: 'bg-violet-500',
                                        track: 'bg-violet-500/15',
                                    },
                                    {
                                        id: 'invalid' as const,
                                        label: t('import.statusNeedsFix'),
                                        hint: t('import.hintNeedsFix'),
                                        count: preview.invalidCount,
                                        bar: 'bg-rose-500',
                                        track: 'bg-rose-500/15',
                                    },
                                ] as const
                            ).map((row) => {
                                const total = Math.max(preview.rows.length, 1);
                                const pct = Math.round((row.count / total) * 100);
                                const selected = rowFilter === row.id;
                                return (
                                    <li key={row.id}>
                                        <button
                                            type="button"
                                            onClick={() =>
                                                setRowFilter(selected ? 'all' : row.id)
                                            }
                                            className={`w-full rounded-[var(--lotto-radius-sm)] px-1 py-1 text-left transition-colors ${
                                                selected
                                                    ? 'bg-[var(--lotto-surface-muted)]'
                                                    : 'hover:bg-[var(--lotto-surface-muted)]/60'
                                            }`}
                                        >
                                            <div className="mb-1.5 flex items-baseline justify-between gap-3">
                                                <div className="min-w-0">
                                                    <span className="text-sm font-semibold">
                                                        {row.label}
                                                    </span>
                                                    <span className="ml-2 text-xs text-[var(--lotto-muted)]">
                                                        {row.hint}
                                                    </span>
                                                </div>
                                                <span className="shrink-0 text-sm font-semibold tabular-nums">
                                                    {row.count}
                                                    <span className="ml-1.5 text-xs font-medium text-[var(--lotto-muted)]">
                                                        {pct}%
                                                    </span>
                                                </span>
                                            </div>
                                            <div
                                                className={`h-2.5 w-full overflow-hidden rounded-full ${row.track}`}
                                                aria-hidden
                                            >
                                                <div
                                                    className={`h-full rounded-full transition-[width] duration-300 ${row.bar}`}
                                                    style={{
                                                        width: `${row.count === 0 ? 0 : Math.max(pct, 4)}%`,
                                                    }}
                                                />
                                            </div>
                                        </button>
                                    </li>
                                );
                            })}
                        </ul>
                    </section>

                    {preview.conflict && preview.conflict.count > 0 ? (
                        <section className="space-y-4 rounded-[var(--lotto-radius)] border-2 border-[var(--lotto-excellent)] bg-[var(--lotto-excellent-soft)]/50 p-4 sm:p-5">
                            <div>
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('import.alreadyInSystem')}
                                </p>
                                <h3 className="mt-1 text-lg font-semibold tracking-[-0.02em]">
                                    {t('import.overlapCount', { count: preview.conflict.count })}
                                </h3>
                                <QuietText className="!mt-2 !text-sm">
                                    {t('import.overlapPeriodDetail', {
                                        range:
                                            preview.conflict.drawNumberFrom &&
                                            preview.conflict.drawNumberTo
                                                ? t('import.overlapDrawRange', {
                                                      from: preview.conflict.drawNumberFrom,
                                                      to: preview.conflict.drawNumberTo,
                                                  })
                                                : t('import.overlapMatching', {
                                                      count: preview.conflict.count,
                                                  }),
                                        saved: formatPeriod(
                                            preview.conflict.existingDateFrom,
                                            preview.conflict.existingDateTo,
                                        ),
                                        file: formatPeriod(
                                            preview.conflict.fileDateFrom,
                                            preview.conflict.fileDateTo,
                                        ),
                                    })}
                                </QuietText>
                            </div>

                            <div className="space-y-2">
                                <p className="text-sm font-medium">{t('import.whatToDo')}</p>
                                <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-white p-1">
                                    <button
                                        type="button"
                                        onClick={() => setOverlapChoice('keep')}
                                        className={`rounded-full px-4 py-2 text-sm transition-colors ${
                                            overlapChoice === 'keep'
                                                ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                                : 'font-medium text-[var(--lotto-muted)]'
                                        }`}
                                    >
                                        {t('import.keepExisting')}
                                    </button>
                                    <button
                                        type="button"
                                        onClick={() => setOverlapChoice('replace')}
                                        className={`rounded-full px-4 py-2 text-sm transition-colors ${
                                            overlapChoice === 'replace'
                                                ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                                : 'font-medium text-[var(--lotto-muted)]'
                                        }`}
                                    >
                                        {t('import.replaceWithFile')}
                                    </button>
                                </div>
                                <p className="text-sm text-[var(--lotto-muted)]">
                                    {overlapChoice === 'keep'
                                        ? t('import.keepChoiceHint', {
                                              newCount: importNewCount,
                                              overlapCount: preview.conflict.count,
                                          })
                                        : t('import.replaceChoiceHint', {
                                              newCount: importNewCount,
                                              overlapCount: preview.conflict.count,
                                          })}
                                </p>
                            </div>
                        </section>
                    ) : null}

                    {preview.inFileDupeCount > 0 ? (
                        <div className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-caution-soft)] bg-[var(--lotto-caution-soft)]/60 px-4 py-3 text-sm text-[var(--lotto-fg)]">
                            {t('import.inFileDupeBanner')}
                        </div>
                    ) : null}

                    <div className="flex flex-wrap gap-2">
                        {(
                            [
                                {
                                    id: 'all' as const,
                                    label: t('common.all'),
                                    count: preview.rows.length,
                                },
                                {
                                    id: 'new' as const,
                                    label: t('import.statusNew'),
                                    count: preview.validCount,
                                },
                                {
                                    id: 'will_update' as const,
                                    label: t('import.statusSaved'),
                                    count: preview.updateCount,
                                },
                                {
                                    id: 'in_file_dupe' as const,
                                    label: t('import.statusRepeatedShort'),
                                    count: preview.inFileDupeCount,
                                },
                                {
                                    id: 'invalid' as const,
                                    label: t('import.statusNeedsFix'),
                                    count: preview.invalidCount,
                                },
                            ] as const
                        ).map((chip) => (
                            <button
                                key={chip.id}
                                type="button"
                                onClick={() => setRowFilter(chip.id)}
                                className={`rounded-full px-3 py-1.5 text-sm ${
                                    rowFilter === chip.id
                                        ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                        : 'bg-[var(--lotto-surface-muted)] text-[var(--lotto-muted)]'
                                }`}
                            >
                                {chip.label} {chip.count}
                            </button>
                        ))}
                    </div>

                    <div className="overflow-hidden rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)]">
                        <div className="flex flex-wrap items-center justify-between gap-3 border-b border-[var(--lotto-border)] px-4 py-3">
                            <div>
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('import.preview')}
                                </p>
                                <p className="text-sm text-[var(--lotto-muted)]">
                                    {t('import.previewHintStrong')}
                                </p>
                            </div>
                            <StatusPill tone="neutral">
                                {t('import.rowCount', { count: filteredRows.length })}
                            </StatusPill>
                        </div>
                        <div className="overflow-x-auto">
                            <table className="w-full min-w-[720px] border-collapse text-left text-sm">
                                <thead>
                                    <tr className="border-b border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/70">
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('import.colRow')}
                                        </th>
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('draws.drawCol')}
                                        </th>
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('draws.date')}
                                        </th>
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('draws.numbers')}
                                        </th>
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('common.status')}
                                        </th>
                                        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('import.colNotes')}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {previewPageRows.length === 0 ? (
                                        <tr>
                                            <td
                                                colSpan={6}
                                                className="px-4 py-10 text-center text-[var(--lotto-muted)]"
                                            >
                                                {t('import.noRowsFilter')}
                                            </td>
                                        </tr>
                                    ) : (
                                        previewPageRows.map((r) => (
                                            <tr
                                                key={r.rowIndex}
                                                className="border-b border-[var(--lotto-border)] last:border-b-0 hover:bg-[var(--lotto-surface-muted)]/50"
                                            >
                                                <td className="px-4 py-3.5 align-middle text-[var(--lotto-muted)]">
                                                    {r.rowIndex}
                                                </td>
                                                <td className="px-4 py-3.5 align-middle font-medium">
                                                    {r.drawNumber || '—'}
                                                </td>
                                                <td className="whitespace-nowrap px-4 py-3.5 align-middle text-[var(--lotto-muted)]">
                                                    {r.drawDate || '—'}
                                                </td>
                                                <td className="px-4 py-3.5 align-middle">
                                                    <div className="flex flex-wrap gap-1">
                                                        {r.winningNumbers
                                                            .filter((n) => n > 0)
                                                            .map((n, i) => (
                                                                <CompactNumberChip
                                                                    key={`${r.rowIndex}-m-${i}`}
                                                                    value={n}
                                                                />
                                                            ))}
                                                        {r.bonusNumbers
                                                            .filter((n) => n > 0)
                                                            .map((n, i) => (
                                                                <CompactNumberChip
                                                                    key={`${r.rowIndex}-b-${i}`}
                                                                    value={n}
                                                                    tone="excellent"
                                                                />
                                                            ))}
                                                    </div>
                                                </td>
                                                <td className="px-4 py-3.5 align-middle">
                                                    <StatusPill tone={statusTone(r.status)}>
                                                        {t(importStatusLabelKey(r.status))}
                                                    </StatusPill>
                                                </td>
                                                <td className="max-w-[220px] px-4 py-3.5 align-middle text-[var(--lotto-muted)]">
                                                    {plainRowNote(r.status, r.errors, t)}
                                                </td>
                                            </tr>
                                        ))
                                    )}
                                </tbody>
                            </table>
                        </div>
                        <TablePagination
                            page={previewPage}
                            pageSize={PREVIEW_PAGE_SIZE}
                            total={filteredRows.length}
                            onPageChange={setPreviewPage}
                        />
                    </div>

                    <button
                        type="button"
                        disabled={busy || willWriteCount === 0}
                        onClick={() => setConfirmOpen(true)}
                        className="rounded-full bg-[var(--lotto-fg)] px-5 py-2.5 text-sm font-semibold text-white disabled:opacity-60"
                    >
                        {confirmLabel}
                    </button>
                </div>
            ) : null}
                </>
            )}

            {confirmOpen && preview ? (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
                    <button
                        type="button"
                        aria-label={t('common.closeDialog')}
                        disabled={busy}
                        onClick={() => setConfirmOpen(false)}
                        className="absolute inset-0 bg-[var(--lotto-fg)]/35"
                    />
                    <div
                        role="alertdialog"
                        aria-modal="true"
                        aria-labelledby="import-confirm-title"
                        aria-describedby="import-confirm-desc"
                        className="relative z-10 w-full max-w-md rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-5 shadow-xl"
                    >
                        <div className="flex items-start justify-between gap-3">
                            <div>
                                <h2
                                    id="import-confirm-title"
                                    className="text-lg font-semibold tracking-[-0.02em]"
                                >
                                    {t('import.confirmHowSave')}
                                </h2>
                                <p
                                    id="import-confirm-desc"
                                    className="mt-2 text-sm text-[var(--lotto-muted)]"
                                >
                                    {t('import.confirmSummary', {
                                        type: t(`common.${preview.lotteryType}`),
                                        count: willWriteCount,
                                        detail:
                                            importUpdateCount > 0
                                                ? t('import.confirmDetail', {
                                                      newCount: importNewCount,
                                                      updateCount: importUpdateCount,
                                                  })
                                                : '',
                                    })}
                                </p>
                            </div>
                            <button
                                type="button"
                                disabled={busy}
                                onClick={() => setConfirmOpen(false)}
                                className="inline-flex size-8 shrink-0 items-center justify-center rounded-[var(--lotto-radius-xs)] text-[var(--lotto-muted)] hover:bg-[var(--lotto-surface-muted)]"
                                aria-label={t('common.cancel')}
                            >
                                <X className="size-4" />
                            </button>
                        </div>

                        <div className="mt-5 flex flex-col gap-2 sm:flex-row sm:justify-end">
                            <button
                                type="button"
                                disabled={busy}
                                onClick={() => void onConfirm(false)}
                                className="rounded-full border border-[var(--lotto-border-strong)] bg-white px-4 py-2.5 text-sm font-semibold disabled:opacity-60"
                            >
                                {busy ? t('common.saving') : t('import.saveAsDraft')}
                            </button>
                            <button
                                type="button"
                                disabled={busy}
                                onClick={() => void onConfirm(true)}
                                className="rounded-full bg-[var(--lotto-fg)] px-4 py-2.5 text-sm font-semibold text-white disabled:opacity-60"
                            >
                                {busy ? t('draws.publishing') : t('import.publishNow')}
                            </button>
                        </div>
                    </div>
                </div>
            ) : null}
        </div>
    );
}

function CompactNumberChip({
    value,
    tone = 'ink',
}: {
    value: number;
    tone?: 'ink' | 'excellent';
}) {
    return (
        <span
            className={`inline-flex h-6 min-w-6 items-center justify-center rounded-full px-1.5 text-[11px] font-semibold tabular-nums ${
                tone === 'excellent'
                    ? 'bg-[var(--lotto-excellent-soft)] text-[#8a4f28]'
                    : 'bg-zinc-200 text-zinc-800 ring-1 ring-inset ring-zinc-300/80'
            }`}
        >
            {value}
        </span>
    );
}
