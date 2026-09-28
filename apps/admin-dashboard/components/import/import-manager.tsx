'use client';

import Link from 'next/link';
import { useEffect, useMemo, useRef, useState, type DragEvent } from 'react';
import { CalendarRange, Check, Download, FileSpreadsheet, Upload, X } from 'lucide-react';
import type { LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { StatusPill, QuietText } from '@/components/bento/primitives';
import { PageHeader } from '@/components/layout/page-header';
import { TablePagination } from '@/components/layout/table-pagination';
import { AppIcon } from '@/components/ui/icon';
import { createClient } from '@/lib/supabase/client';
import { listExistingDrawSummaries, upsertDraws } from '@/lib/draws/draws-service';
import {
    downloadImportTemplate,
    IMPORT_TEMPLATE_LOTO6_HEADER,
    IMPORT_TEMPLATE_LOTO7_HEADER,
    importStatusLabelKey,
    mergeConflicts,
    parseLotteryWorkbookCollections,
    previewsToUpsertPayload,
    sumPreviewCounts,
    type ImportPreview,
    type ImportRowStatus,
    type ParsedImportRow,
} from '@/services/excel-import-service';

const ACCEPTED_EXT = /\.(xlsx|xls|csv)$/i;
const PREVIEW_PAGE_SIZE = 10;

type RowFilter = 'all' | ImportRowStatus;
type OverlapChoice = 'keep' | 'replace';
/** Collection scope after detect: combined All, or one lottery type. */
type PreviewScope = 'all' | LotteryType;

type ScopedPreviewRow = ParsedImportRow & { lotteryType: LotteryType };

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

function fileDateSpan(previews: ImportPreview[]) {
    const dates = previews
        .flatMap((p) => [p.fileDateFrom, p.fileDateTo])
        .filter((d): d is string => Boolean(d))
        .sort();
    if (dates.length === 0) return { from: null as string | null, to: null as string | null };
    return { from: dates[0]!, to: dates[dates.length - 1]! };
}

/**
 * Integer percents that sum to 100. Any non-zero count gets at least 1%
 * (so 1/2140 never displays as 0% while 2139/2140 shows 100%).
 */
function sharePercents(counts: number[]): number[] {
    const total = counts.reduce((a, b) => a + b, 0);
    if (total <= 0) return counts.map(() => 0);

    const exact = counts.map((c) => (c / total) * 100);
    const result = exact.map((p, i) => {
        if (counts[i] === 0) return 0;
        const floored = Math.floor(p);
        return floored === 0 ? 1 : floored;
    });

    let sum = result.reduce((a, b) => a + b, 0);
    while (sum > 100) {
        const idx = result
            .map((p, i) => ({ p, i, c: counts[i]! }))
            .filter((x) => x.p > 1)
            .sort((a, b) => b.p - a.p || b.c - a.c)[0]?.i;
        if (idx == null) break;
        result[idx]! -= 1;
        sum -= 1;
    }
    while (sum < 100) {
        const idx = exact
            .map((p, i) => ({
                i,
                frac: p - Math.floor(p),
                c: counts[i]!,
            }))
            .filter((x) => x.c > 0)
            .sort((a, b) => b.frac - a.frac || b.c - a.c)[0]?.i;
        if (idx == null) break;
        result[idx]! += 1;
        sum += 1;
    }
    return result;
}

export function ImportManager() {
    const { t } = useI18n();
    const [previews, setPreviews] = useState<ImportPreview[]>([]);
    const [previewScope, setPreviewScope] = useState<PreviewScope>('all');
    const [error, setError] = useState<string | null>(null);
    const [busy, setBusy] = useState(false);
    const [fileName, setFileName] = useState<string | null>(null);
    const [dragOver, setDragOver] = useState(false);
    const [rowFilter, setRowFilter] = useState<RowFilter>('all');
    const [overlapChoice, setOverlapChoice] = useState<OverlapChoice>('keep');
    const [previewPage, setPreviewPage] = useState(1);
    const [confirmOpen, setConfirmOpen] = useState(false);
    const [success, setSuccess] = useState<{
        types: LotteryType[];
        count: number;
        published: boolean;
        message: string;
    } | null>(null);
    const dragDepth = useRef(0);

    const totals = useMemo(() => sumPreviewCounts(previews), [previews]);
    const conflict = useMemo(() => mergeConflicts(previews), [previews]);
    const fileSpan = useMemo(() => fileDateSpan(previews), [previews]);
    const multiCollection = previews.length > 1;

    const scopedPreviews = useMemo(() => {
        if (previewScope === 'all') return previews;
        return previews.filter((p) => p.lotteryType === previewScope);
    }, [previews, previewScope]);

    const scopedCounts = useMemo(() => sumPreviewCounts(scopedPreviews), [scopedPreviews]);

    const scopedRows = useMemo<ScopedPreviewRow[]>(
        () =>
            scopedPreviews.flatMap((p) =>
                p.rows.map((r) => ({ ...r, lotteryType: p.lotteryType })),
            ),
        [scopedPreviews],
    );

    const hasPreview = previews.length > 0;

    function resetWizard() {
        setPreviews([]);
        setPreviewScope('all');
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

    async function onFile(file: File | null) {
        setSuccess(null);
        setError(null);
        setPreviews([]);
        setPreviewScope('all');
        setRowFilter('all');
        setOverlapChoice('keep');
        setPreviewPage(1);
        setConfirmOpen(false);
        if (!file) {
            setFileName(null);
            return;
        }
        setBusy(true);
        try {
            const buffer = await file.arrayBuffer();
            const client = createClient();
            const [existing6, existing7] = await Promise.all([
                listExistingDrawSummaries(client, 'lotto6'),
                listExistingDrawSummaries(client, 'lotto7'),
            ]);
            const { previews: next } = parseLotteryWorkbookCollections(buffer, {
                lotto6: existing6,
                lotto7: existing7,
            });
            if (next.length === 0) {
                setError(t('import.noCollectionsFound'));
                setFileName(null);
                return;
            }
            setPreviews(next);
            // Detect → land on All when both collections exist; otherwise the single type
            setPreviewScope(next.length > 1 ? 'all' : next[0]!.lotteryType);
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
            setPreviews([]);
            setPreviewScope('all');
            return;
        }
        setFileName(file.name);
        void onFile(file);
    }

    function handleDragEnter(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        if (busy) return;
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
        if (!busy) e.dataTransfer.dropEffect = 'copy';
    }

    function handleDrop(e: DragEvent) {
        e.preventDefault();
        e.stopPropagation();
        dragDepth.current = 0;
        setDragOver(false);
        if (busy) return;
        acceptFile(e.dataTransfer.files?.[0] ?? null);
    }

    const replaceExisting = overlapChoice === 'replace';
    const importNewCount = totals.validCount;
    const importUpdateCount = replaceExisting ? totals.updateCount : 0;
    const willWriteCount = importNewCount + importUpdateCount;

    const confirmLabel = useMemo(() => {
        if (previews.length === 0) return t('nav.import');
        if (willWriteCount === 0) return t('import.nothingToImport');
        if (willWriteCount === 1) return t('import.importOne');
        return t('import.importMany', { count: willWriteCount });
    }, [previews.length, willWriteCount, t]);

    const typeLabels = useMemo(
        () => previews.map((p) => t(`common.${p.lotteryType}`)).join(' + '),
        [previews, t],
    );

    async function onConfirm(publish: boolean) {
        if (previews.length === 0) return;
        const snapshot = previews;
        const replace = replaceExisting;
        setConfirmOpen(false);
        setBusy(true);
        setError(null);
        try {
            const payload = previewsToUpsertPayload(snapshot, {
                replaceExisting: replace,
                publish,
            });
            if (payload.length === 0) {
                setError(t('import.noRowsChoice'));
                return;
            }
            const client = createClient();
            const { upserted } = await upsertDraws(client, payload);
            const counts = sumPreviewCounts(snapshot);
            const replaced = replace ? counts.updateCount : 0;
            const types = snapshot.map((p) => p.lotteryType);
            const message =
                replaced > 0
                    ? t('import.savedWithReplace', {
                          count: upserted,
                          type: typeLabels,
                          newCount: counts.validCount,
                          replaced,
                      })
                    : t('import.savedNewOnly', {
                          count: upserted,
                          type: typeLabels,
                      });

            setSuccess({
                types,
                count: upserted,
                published: publish,
                message,
            });
            setPreviews([]);
            setPreviewScope('all');
            setFileName(null);
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

    const dropEnabled = !busy;
    const step = hasPreview ? 2 : 1;
    const showSuccess = success != null;

    const filteredRows = useMemo(() => {
        if (rowFilter === 'all') return scopedRows;
        return scopedRows.filter((r) => r.status === rowFilter);
    }, [scopedRows, rowFilter]);

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

    useEffect(() => {
        setPreviewPage(1);
        setRowFilter('all');
    }, [previewScope]);

    const scopeLabel =
        previewScope === 'all' ? t('common.all') : t(`common.${previewScope}`);

    const collectionTabs = useMemo(() => {
        const tabs: { id: PreviewScope; label: string; count: number }[] = [];
        if (multiCollection) {
            tabs.push({ id: 'all', label: t('common.all'), count: totals.rowCount });
        }
        for (const p of previews) {
            tabs.push({
                id: p.lotteryType,
                label: t(`common.${p.lotteryType}`),
                count: p.rows.length,
            });
        }
        return tabs;
    }, [multiCollection, previews, t, totals.rowCount]);

    const steps = [
        { n: 1, label: t('import.stepUpload'), hint: t('import.stepHintUpload') },
        { n: 2, label: t('import.stepImport'), hint: t('import.stepHintImport') },
    ];

    const drawsHref =
        success && success.types.length === 1
            ? `/draws?type=${success.types[0]}&status=${success.published ? 'published' : 'draft'}`
            : `/draws?status=${success?.published ? 'published' : 'draft'}`;

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
                            href={drawsHref}
                            className="rounded-full bg-emerald-700 px-5 py-2.5 text-sm font-semibold text-white"
                        >
                            {t('import.viewDraws')}
                        </Link>
                    </div>
                </section>
            ) : (
                <>
                    <ol className="grid gap-2 sm:grid-cols-2">
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

                    <section className="space-y-4 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-4 sm:p-5">
                        <div className="flex flex-wrap items-start justify-between gap-3">
                            <div className="min-w-0 space-y-1">
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.16em] text-[var(--lotto-muted-soft)]">
                                    {t('import.formatHintTitle')}
                                </p>
                                <p className="text-sm font-semibold tracking-[-0.01em]">
                                    {t('import.templateTitle')}
                                </p>
                                <QuietText className="!text-sm">{t('import.formatHintBody')}</QuietText>
                            </div>
                            <button
                                type="button"
                                onClick={() => downloadImportTemplate()}
                                className="inline-flex shrink-0 items-center gap-2 rounded-full border border-[var(--lotto-border-strong)] bg-white px-4 py-2 text-sm font-semibold text-[var(--lotto-fg)] hover:bg-[var(--lotto-surface-muted)]"
                            >
                                <AppIcon icon={Download} size={16} />
                                {t('import.downloadTemplate')}
                            </button>
                        </div>

                        <div className="grid gap-4 lg:grid-cols-2">
                            <FormatPreviewCard
                                title={t('common.lotto6')}
                                sheetLabel={t('import.templateSheet', { name: 'new loto6' })}
                                hint={t('import.hint6')}
                                headers={[...IMPORT_TEMPLATE_LOTO6_HEADER]}
                                sampleRow={[1, '10/5/2000', 2, 8, 10, 13, 27, 30, 39]}
                                upcomingLabel={t('import.templateUpcomingNote')}
                            />
                            <FormatPreviewCard
                                title={t('common.lotto7')}
                                sheetLabel={t('import.templateSheet', { name: 'new loto7' })}
                                hint={t('import.hint7')}
                                headers={[...IMPORT_TEMPLATE_LOTO7_HEADER]}
                                sampleRow={[1, '4/5/2013', 7, 10, 12, 17, 23, 28, 34, 3, 15]}
                                upcomingLabel={t('import.templateUpcomingNote')}
                            />
                        </div>
                    </section>

                    <div
                        aria-disabled={!dropEnabled}
                        aria-label={t('import.dropAria')}
                        onDragEnter={handleDragEnter}
                        onDragLeave={handleDragLeave}
                        onDragOver={handleDragOver}
                        onDrop={handleDrop}
                        className={`rounded-[var(--lotto-radius)] border-2 border-dashed px-4 py-8 transition-colors ${
                            dragOver
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
                                    {dragOver ? t('import.dropToUpload') : t('import.dragDropHere')}
                                </p>
                                <p className="text-sm text-[var(--lotto-muted)]">
                                    {t('import.acceptsFormats')}
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

                    {hasPreview ? (
                        <div className="space-y-5">
                            {(fileSpan.from || fileSpan.to) && (
                                <div className="flex flex-wrap items-center gap-3 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] px-4 py-3">
                                    <div className="flex h-10 w-10 items-center justify-center rounded-[var(--lotto-radius-xs)] bg-[var(--lotto-surface-muted)]">
                                        <AppIcon icon={CalendarRange} size={18} />
                                    </div>
                                    <div>
                                        <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('import.fileCovers')}
                                        </p>
                                        <p className="text-base font-semibold tracking-[-0.02em]">
                                            {formatPeriod(fileSpan.from, fileSpan.to)}
                                        </p>
                                        <p className="text-sm text-[var(--lotto-muted)]">
                                            {t('import.detectedCollections', {
                                                types: typeLabels,
                                                count: totals.rowCount,
                                            })}
                                        </p>
                                    </div>
                                </div>
                            )}

                            <div className="space-y-2">
                                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('import.collectionsTitle')}
                                </p>
                                <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-1">
                                    {collectionTabs.map((tab) => {
                                        const active = previewScope === tab.id;
                                        return (
                                            <button
                                                key={tab.id}
                                                type="button"
                                                onClick={() => setPreviewScope(tab.id)}
                                                className={`rounded-full px-4 py-1.5 text-sm transition-colors ${
                                                    active
                                                        ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                                        : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                                                }`}
                                            >
                                                {tab.label}
                                                <span className="ml-1.5 tabular-nums opacity-80">
                                                    {tab.count}
                                                </span>
                                            </button>
                                        );
                                    })}
                                </div>
                            </div>

                            <section className="rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-4 sm:p-5">
                                <div className="mb-4 flex flex-wrap items-end justify-between gap-2">
                                    <div>
                                        <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('import.rowBreakdown')}
                                        </p>
                                        <p className="mt-1 text-sm text-[var(--lotto-muted)]">
                                            {t('import.rowBreakdownHintActive', {
                                                type: scopeLabel,
                                            })}
                                        </p>
                                    </div>
                                    <p className="text-sm font-semibold tabular-nums">
                                        {t('import.totalRows', { count: scopedCounts.rowCount })}
                                    </p>
                                </div>
                                <ul className="space-y-3">
                                    {(() => {
                                        const breakdown = [
                                            {
                                                id: 'new' as const,
                                                label: t('import.statusNew'),
                                                hint: t('import.hintNew'),
                                                count: scopedCounts.validCount,
                                                bar: 'bg-sky-500',
                                                track: 'bg-sky-500/15',
                                            },
                                            {
                                                id: 'will_update' as const,
                                                label: t('import.statusSaved'),
                                                hint: t('import.hintSaved'),
                                                count: scopedCounts.updateCount,
                                                bar: 'bg-amber-500',
                                                track: 'bg-amber-500/15',
                                            },
                                            {
                                                id: 'in_file_dupe' as const,
                                                label: t('import.statusRepeated'),
                                                hint: t('import.hintRepeated'),
                                                count: scopedCounts.inFileDupeCount,
                                                bar: 'bg-violet-500',
                                                track: 'bg-violet-500/15',
                                            },
                                            {
                                                id: 'invalid' as const,
                                                label: t('import.statusNeedsFix'),
                                                hint: t('import.hintNeedsFix'),
                                                count: scopedCounts.invalidCount,
                                                bar: 'bg-rose-500',
                                                track: 'bg-rose-500/15',
                                            },
                                        ] as const;
                                        const percents = sharePercents(breakdown.map((r) => r.count));
                                        return breakdown.map((row, index) => {
                                            const pct = percents[index] ?? 0;
                                            const barWidth =
                                                scopedCounts.rowCount === 0
                                                    ? 0
                                                    : (row.count / scopedCounts.rowCount) * 100;
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
                                                                    width: `${barWidth}%`,
                                                                    minWidth:
                                                                        row.count > 0
                                                                            ? '2px'
                                                                            : undefined,
                                                                }}
                                                            />
                                                        </div>
                                                    </button>
                                                </li>
                                            );
                                        });
                                    })()}
                                </ul>
                            </section>

                            {conflict && conflict.count > 0 ? (
                                <section className="space-y-4 rounded-[var(--lotto-radius)] border-2 border-[var(--lotto-excellent)] bg-[var(--lotto-excellent-soft)]/50 p-4 sm:p-5">
                                    <div>
                                        <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                            {t('import.alreadyInSystem')}
                                        </p>
                                        <h3 className="mt-1 text-lg font-semibold tracking-[-0.02em]">
                                            {t('import.overlapCount', { count: conflict.count })}
                                        </h3>
                                        <QuietText className="!mt-2 !text-sm">
                                            {t('import.overlapPeriodDetail', {
                                                range:
                                                    conflict.drawNumberFrom && conflict.drawNumberTo
                                                        ? t('import.overlapDrawRange', {
                                                              from: conflict.drawNumberFrom,
                                                              to: conflict.drawNumberTo,
                                                          })
                                                        : t('import.overlapMatching', {
                                                              count: conflict.count,
                                                          }),
                                                saved: formatPeriod(
                                                    conflict.existingDateFrom,
                                                    conflict.existingDateTo,
                                                ),
                                                file: formatPeriod(
                                                    conflict.fileDateFrom,
                                                    conflict.fileDateTo,
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
                                                      overlapCount: conflict.count,
                                                  })
                                                : t('import.replaceChoiceHint', {
                                                      newCount: importNewCount,
                                                      overlapCount: conflict.count,
                                                  })}
                                        </p>
                                    </div>
                                </section>
                            ) : null}

                            {totals.inFileDupeCount > 0 ? (
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
                                            count: scopedCounts.rowCount,
                                        },
                                        {
                                            id: 'new' as const,
                                            label: t('import.statusNew'),
                                            count: scopedCounts.validCount,
                                        },
                                        {
                                            id: 'will_update' as const,
                                            label: t('import.statusSaved'),
                                            count: scopedCounts.updateCount,
                                        },
                                        {
                                            id: 'in_file_dupe' as const,
                                            label: t('import.statusRepeatedShort'),
                                            count: scopedCounts.inFileDupeCount,
                                        },
                                        {
                                            id: 'invalid' as const,
                                            label: t('import.statusNeedsFix'),
                                            count: scopedCounts.invalidCount,
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
                                                {previewScope === 'all' && multiCollection ? (
                                                    <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                                        {t('import.lotteryType')}
                                                    </th>
                                                ) : null}
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
                                                        colSpan={
                                                            previewScope === 'all' && multiCollection
                                                                ? 7
                                                                : 6
                                                        }
                                                        className="px-4 py-10 text-center text-[var(--lotto-muted)]"
                                                    >
                                                        {t('import.noRowsFilter')}
                                                    </td>
                                                </tr>
                                            ) : (
                                                previewPageRows.map((r) => (
                                                    <tr
                                                        key={`${r.lotteryType}-${r.rowIndex}`}
                                                        className="border-b border-[var(--lotto-border)] last:border-b-0 hover:bg-[var(--lotto-surface-muted)]/50"
                                                    >
                                                        <td className="px-4 py-3.5 align-middle text-[var(--lotto-muted)]">
                                                            {r.rowIndex}
                                                        </td>
                                                        {previewScope === 'all' && multiCollection ? (
                                                            <td className="px-4 py-3.5 align-middle whitespace-nowrap">
                                                                {t(`common.${r.lotteryType}`)}
                                                            </td>
                                                        ) : null}
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
                                                                            key={`${r.lotteryType}-${r.rowIndex}-m-${i}`}
                                                                            value={n}
                                                                        />
                                                                    ))}
                                                                {r.bonusNumbers
                                                                    .filter((n) => n > 0)
                                                                    .map((n, i) => (
                                                                        <CompactNumberChip
                                                                            key={`${r.lotteryType}-${r.rowIndex}-b-${i}`}
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

            {confirmOpen && previews.length > 0 ? (
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
                                        type: typeLabels,
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

function FormatPreviewCard({
    title,
    sheetLabel,
    hint,
    headers,
    sampleRow,
    upcomingLabel,
}: {
    title: string;
    sheetLabel: string;
    hint: string;
    headers: (string | number)[];
    sampleRow: (string | number)[];
    upcomingLabel: string;
}) {
    return (
        <div className="overflow-hidden rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/40">
            <div className="space-y-1 border-b border-[var(--lotto-border)] px-3 py-2.5">
                <p className="text-sm font-semibold">{title}</p>
                <p className="text-xs font-medium text-[var(--lotto-fg)]">{sheetLabel}</p>
                <p className="text-xs text-[var(--lotto-muted)]">{hint}</p>
            </div>
            <div className="overflow-x-auto">
                <table className="w-full min-w-[420px] border-collapse text-left text-xs">
                    <thead>
                        <tr className="bg-[var(--lotto-surface-muted)]/80">
                            {headers.map((h) => (
                                <th
                                    key={String(h)}
                                    className="whitespace-nowrap px-2.5 py-2 font-semibold text-[var(--lotto-fg)]"
                                >
                                    {String(h)}
                                </th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        <tr className="border-t border-[var(--lotto-border)] bg-white/70">
                            {sampleRow.map((cell, i) => (
                                <td
                                    key={`${title}-s-${i}`}
                                    className="whitespace-nowrap px-2.5 py-2 tabular-nums text-[var(--lotto-muted)]"
                                >
                                    {String(cell)}
                                </td>
                            ))}
                        </tr>
                    </tbody>
                </table>
            </div>
            <p className="border-t border-[var(--lotto-border)] px-3 py-2 text-[11px] leading-snug text-[var(--lotto-muted)]">
                {upcomingLabel}
            </p>
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
