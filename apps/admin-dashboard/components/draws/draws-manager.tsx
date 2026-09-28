'use client';

import { FormEvent, useCallback, useEffect, useMemo, useRef, useState } from 'react';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import {
    ArrowDown,
    ArrowUp,
    ArrowUpDown,
    BookUp,
    CalendarRange,
    ChevronDown,
    EyeOff,
    Globe,
    ListFilter,
    Pencil,
    Plus,
    Trash2,
} from 'lucide-react';
import type { Draw, DrawCreateInput, LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { NumberBall, StatusPill } from '@/components/bento/primitives';
import { NumberOtpInput } from '@/components/draws/number-otp-input';
import { SlideOver } from '@/components/layout/slide-over';
import { TablePagination } from '@/components/layout/table-pagination';
import { drawContainsAllBalls, useShellSearch } from '@/components/layout/shell-search';
import { AppIcon } from '@/components/ui/icon';
import { IconAction } from '@/components/ui/icon-action';
import { createClient } from '@/lib/supabase/client';
import {
    createDraw,
    deleteDraw,
    listDraws,
    setDrawPublished,
    setDrawsPublished,
    updateDraw,
} from '@/lib/draws/draws-service';
import { validateDrawNumbers } from '@/lib/draws/validate';

const DRAWS_PAGE_SIZE = 20;

type SortKey = 'lotteryType' | 'drawNumber' | 'drawDate' | 'status';
type SortDir = 'asc' | 'desc';

function emptyForm(type: LotteryType): DrawCreateInput {
    return {
        lotteryType: type,
        drawNumber: '',
        drawDate: new Date().toISOString().slice(0, 10),
        winningNumbers: type === 'lotto6' ? [0, 0, 0, 0, 0, 0] : [0, 0, 0, 0, 0, 0, 0],
        bonusNumbers: type === 'lotto6' ? [0] : [0, 0],
        isPublished: false,
    };
}

function typeFromSearch(raw: string | null): LotteryType | 'all' {
    if (raw === 'lotto6' || raw === 'lotto7') return raw;
    return 'all';
}

function statusFromSearch(raw: string | null): 'all' | 'published' | 'draft' {
    if (raw === 'published' || raw === 'draft') return raw;
    return 'all';
}

function parseDrawNumber(raw: string): number {
    const match = raw.match(/(\d+)/);
    return match ? Number.parseInt(match[1]!, 10) : Number.NaN;
}

function openDatePicker(input: HTMLInputElement) {
    try {
        input.showPicker?.();
    } catch {
        /* ignore — unsupported or already open */
    }
}

function compareDraws(a: Draw, b: Draw, key: SortKey, dir: SortDir): number {
    let cmp = 0;
    switch (key) {
        case 'lotteryType':
            cmp = a.lotteryType.localeCompare(b.lotteryType);
            break;
        case 'drawNumber': {
            const na = parseDrawNumber(a.drawNumber);
            const nb = parseDrawNumber(b.drawNumber);
            if (Number.isFinite(na) && Number.isFinite(nb) && na !== nb) cmp = na - nb;
            else cmp = a.drawNumber.localeCompare(b.drawNumber, undefined, { numeric: true });
            break;
        }
        case 'drawDate':
            cmp = a.drawDate.localeCompare(b.drawDate);
            break;
        case 'status':
            cmp = Number(a.isPublished) - Number(b.isPublished);
            break;
    }
    return dir === 'asc' ? cmp : -cmp;
}

const STATUS_FILTER_IDS = ['all', 'published', 'draft'] as const;

export function DrawsManager() {
    const { t } = useI18n();
    const {
        query,
        mode,
        selectedDrawId,
        clearSelection,
        hasNumberFilter,
        filledBalls,
        numberType,
    } = useShellSearch();
    const searchParams = useSearchParams();
    const [draws, setDraws] = useState<Draw[]>([]);
    const [loading, setLoading] = useState(true);
    const [listError, setListError] = useState<string | null>(null);
    const [formError, setFormError] = useState<string | null>(null);
    const [typeFilter, setTypeFilter] = useState<LotteryType | 'all'>(() =>
        typeFromSearch(searchParams.get('type')),
    );
    const [publishedFilter, setPublishedFilter] = useState<'all' | 'published' | 'draft'>(() =>
        statusFromSearch(searchParams.get('status')),
    );
    const [form, setForm] = useState(emptyForm('lotto6'));
    const [editingId, setEditingId] = useState<string | null>(null);
    const [sheetOpen, setSheetOpen] = useState(false);
    const [saving, setSaving] = useState(false);
    const [bulkBusy, setBulkBusy] = useState(false);
    const [page, setPage] = useState(1);
    const [sortKey, setSortKey] = useState<SortKey>('drawDate');
    const [sortDir, setSortDir] = useState<SortDir>('desc');
    const [dateRange, setDateRange] = useState<{ from: string; to: string } | null>(null);
    const [dateRangeOpen, setDateRangeOpen] = useState(false);
    const openedFromSearchRef = useRef<string | null>(null);

    useEffect(() => {
        setTypeFilter(typeFromSearch(searchParams.get('type')));
        setPublishedFilter(statusFromSearch(searchParams.get('status')));
    }, [searchParams]);

    const numberMax = form.lotteryType === 'lotto6' ? 43 : 37;
    const mainCount = form.lotteryType === 'lotto6' ? 6 : 7;
    const bonusCount = form.lotteryType === 'lotto6' ? 1 : 2;

    const reload = useCallback(async () => {
        setLoading(true);
        setListError(null);
        try {
            const client = createClient();
            const rows = await listDraws(client, {
                lotteryType: hasNumberFilter ? numberType : typeFilter,
                published: 'all',
                search: mode === 'text' ? query : undefined,
            });
            setDraws(rows);
        } catch (err) {
            setListError(err instanceof Error ? err.message : t('draws.loadFailed'));
        } finally {
            setLoading(false);
        }
    }, [typeFilter, query, mode, hasNumberFilter, numberType, t]);

    useEffect(() => {
        void reload();
    }, [reload]);

    useEffect(() => {
        setPage(1);
    }, [
        typeFilter,
        publishedFilter,
        query,
        mode,
        hasNumberFilter,
        filledBalls,
        numberType,
        sortKey,
        sortDir,
        dateRange,
    ]);

    const statusCounts = useMemo(() => {
        let published = 0;
        let draft = 0;
        for (const d of draws) {
            if (d.isPublished) published += 1;
            else draft += 1;
        }
        return {
            all: draws.length,
            published,
            draft,
        };
    }, [draws]);

    const statusOptions = useMemo(
        () =>
            STATUS_FILTER_IDS.map((id) => ({
                id,
                count: statusCounts[id],
            })),
        [statusCounts],
    );

    const dateBounds = useMemo(() => {
        if (draws.length === 0) return null;
        let min = draws[0]!.drawDate;
        let max = draws[0]!.drawDate;
        for (const d of draws) {
            if (d.drawDate < min) min = d.drawDate;
            if (d.drawDate > max) max = d.drawDate;
        }
        return { min, max };
    }, [draws]);

    useEffect(() => {
        if (!dateBounds) {
            setDateRange(null);
            setDateRangeOpen(false);
            return;
        }
        setDateRange({ from: dateBounds.min, to: dateBounds.max });
        if (dateBounds.min === dateBounds.max) setDateRangeOpen(false);
    }, [dateBounds?.min, dateBounds?.max]);

    const selectedDateFrom =
        dateBounds && dateRange && dateRangeOpen ? dateRange.from : null;
    const selectedDateTo =
        dateBounds && dateRange && dateRangeOpen ? dateRange.to : null;
    const dateFilterActive =
        Boolean(dateBounds && dateRange && dateRangeOpen) &&
        (dateRange!.from > dateBounds!.min || dateRange!.to < dateBounds!.max);

    const filtered = useMemo(() => {
        let rows = draws;
        if (publishedFilter === 'published') rows = rows.filter((d) => d.isPublished);
        else if (publishedFilter === 'draft') rows = rows.filter((d) => !d.isPublished);

        if (selectedDateFrom && selectedDateTo) {
            rows = rows.filter(
                (d) => d.drawDate >= selectedDateFrom && d.drawDate <= selectedDateTo,
            );
        }

        if (hasNumberFilter) {
            rows = rows.filter(
                (d) =>
                    d.lotteryType === numberType && drawContainsAllBalls(d, filledBalls),
            );
        }

        const sorted = [...rows];
        sorted.sort((a, b) => compareDraws(a, b, sortKey, sortDir));
        return sorted;
    }, [
        draws,
        publishedFilter,
        selectedDateFrom,
        selectedDateTo,
        hasNumberFilter,
        numberType,
        filledBalls,
        sortKey,
        sortDir,
    ]);

    function toggleSort(key: SortKey) {
        if (sortKey === key) {
            setSortDir((d) => (d === 'asc' ? 'desc' : 'asc'));
            return;
        }
        setSortKey(key);
        setSortDir(key === 'drawDate' || key === 'drawNumber' ? 'desc' : 'asc');
    }

    function onDateFromChange(value: string) {
        setDateRange((prev) => {
            if (!prev) return prev;
            return { from: value, to: value > prev.to ? value : prev.to };
        });
    }

    function onDateToChange(value: string) {
        setDateRange((prev) => {
            if (!prev) return prev;
            return { from: value < prev.from ? value : prev.from, to: value };
        });
    }

    function resetDateRange() {
        if (!dateBounds) return;
        setDateRange({ from: dateBounds.min, to: dateBounds.max });
    }

    function toggleDateRangeOpen() {
        setDateRangeOpen((open) => {
            if (open) resetDateRange();
            return !open;
        });
    }
    const pageCount = Math.max(1, Math.ceil(filtered.length / DRAWS_PAGE_SIZE));

    useEffect(() => {
        if (page > pageCount) setPage(pageCount);
    }, [page, pageCount]);

    const pageRows = useMemo(() => {
        const start = (page - 1) * DRAWS_PAGE_SIZE;
        return filtered.slice(start, start + DRAWS_PAGE_SIZE);
    }, [filtered, page]);

    function closeSheet() {
        setSheetOpen(false);
        setEditingId(null);
        setForm(emptyForm(typeFilter === 'all' ? 'lotto6' : typeFilter));
        setFormError(null);
        openedFromSearchRef.current = null;
        if (selectedDrawId) clearSelection();
    }

    function startCreate() {
        setEditingId(null);
        setForm(emptyForm(typeFilter === 'all' ? 'lotto6' : typeFilter));
        setFormError(null);
        setSheetOpen(true);
    }

    function startEdit(draw: Draw) {
        setEditingId(draw.id);
        setForm({
            lotteryType: draw.lotteryType,
            drawNumber: draw.drawNumber,
            drawDate: draw.drawDate,
            winningNumbers: [...draw.winningNumbers],
            bonusNumbers: [...draw.bonusNumbers],
            isPublished: draw.isPublished,
        });
        setFormError(null);
        setSheetOpen(true);
    }

    useEffect(() => {
        if (!selectedDrawId || loading) return;
        if (openedFromSearchRef.current === selectedDrawId) return;
        const draw = draws.find((d) => d.id === selectedDrawId);
        if (!draw) return;
        openedFromSearchRef.current = selectedDrawId;
        startEdit(draw);
    }, [selectedDrawId, draws, loading]);

    async function onSubmit(e: FormEvent) {
        e.preventDefault();
        const validation = validateDrawNumbers(
            form.lotteryType,
            form.winningNumbers,
            form.bonusNumbers ?? [],
        );
        if (validation) {
            setFormError(t(validation));
            return;
        }
        setSaving(true);
        setFormError(null);
        try {
            const client = createClient();
            if (editingId) {
                await updateDraw(client, editingId, form);
            } else {
                await createDraw(client, form);
            }
            closeSheet();
            await reload();
        } catch (err) {
            setFormError(err instanceof Error ? err.message : t('draws.saveFailed'));
        } finally {
            setSaving(false);
        }
    }

    async function onTogglePublish(draw: Draw) {
        try {
            const client = createClient();
            await setDrawPublished(client, draw.id, !draw.isPublished);
            await reload();
        } catch (err) {
            setListError(err instanceof Error ? err.message : t('draws.publishFailed'));
        }
    }

    async function onDelete(draw: Draw) {
        if (!window.confirm(t('draws.confirmDeleteNamed', { number: draw.drawNumber }))) return;
        try {
            const client = createClient();
            await deleteDraw(client, draw.id);
            if (editingId === draw.id) closeSheet();
            await reload();
        } catch (err) {
            setListError(err instanceof Error ? err.message : t('draws.deleteFailed'));
        }
    }

    const draftIds = useMemo(
        () => filtered.filter((d) => !d.isPublished).map((d) => d.id),
        [filtered],
    );
    const showBulkPublish = publishedFilter === 'draft' && draftIds.length > 0;

    async function onBulkPublish() {
        const n = draftIds.length;
        const ok = window.confirm(t('draws.confirmBulkPublishLong', { count: n }));
        if (!ok) return;
        setBulkBusy(true);
        setListError(null);
        try {
            const client = createClient();
            await setDrawsPublished(client, draftIds, true);
            await reload();
        } catch (err) {
            setListError(err instanceof Error ? err.message : t('draws.bulkPublishFailed'));
        } finally {
            setBulkBusy(false);
        }
    }

    return (
        <div className="space-y-6">
            <div className="flex flex-wrap items-end justify-between gap-3">
                <div>
                    <h1 className="text-2xl font-semibold tracking-tight">{t('draws.title')}</h1>
                    <p className="mt-1 text-sm text-[var(--lotto-muted)]">{t('draws.subtitle')}</p>
                </div>
                <div className="flex flex-wrap items-center gap-2">
                    {showBulkPublish ? (
                        <button
                            type="button"
                            disabled={bulkBusy}
                            onClick={() => void onBulkPublish()}
                            className="inline-flex items-center gap-2 rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-strong-soft)] px-4 py-2 text-sm font-semibold text-[var(--lotto-fg)] disabled:opacity-60"
                        >
                            <AppIcon icon={Globe} size={16} />
                            {bulkBusy
                                ? t('draws.publishing')
                                : draftIds.length === 1
                                  ? t('draws.publishAllOne')
                                  : t('draws.publishAll', { count: draftIds.length })}
                        </button>
                    ) : null}
                    <Link
                        href="/import"
                        className="inline-flex items-center gap-2 rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface)] px-4 py-2 text-sm font-semibold text-[var(--lotto-fg)]"
                    >
                        <AppIcon icon={BookUp} size={16} />
                        {t('draws.importCsv')}
                    </Link>
                    <button
                        type="button"
                        onClick={startCreate}
                        className="inline-flex items-center gap-2 rounded-full bg-[var(--lotto-fg)] px-4 py-2 text-sm font-semibold text-white"
                    >
                        <AppIcon icon={Plus} size={16} />
                        {t('draws.newDraw')}
                    </button>
                </div>
            </div>

            <section className="space-y-2.5 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] px-3 py-2.5 sm:px-4">
                <div className="flex items-center gap-1.5 text-[0.65rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                    <AppIcon icon={ListFilter} size={12} strokeWidth={1.75} />
                    {t('draws.filter')}
                </div>
                <div className="flex flex-wrap items-end gap-x-3 gap-y-2">
                    <SegmentedFilter
                        label={t('draws.game')}
                        options={[
                            { id: 'all', label: t('common.all') },
                            { id: 'lotto6', label: t('common.lotto6') },
                            { id: 'lotto7', label: t('common.lotto7') },
                        ]}
                        value={typeFilter}
                        onChange={setTypeFilter}
                    />
                    <SegmentedFilter
                        label={t('draws.status')}
                        options={statusOptions.map((opt) => ({
                            ...opt,
                            label:
                                opt.id === 'all'
                                    ? t('common.all')
                                    : opt.id === 'published'
                                      ? t('common.published')
                                      : t('common.draft'),
                        }))}
                        value={publishedFilter}
                        onChange={setPublishedFilter}
                    />
                </div>

                {dateBounds && dateRange && dateBounds.min !== dateBounds.max ? (
                    <div className="border-t border-[var(--lotto-border)] pt-2">
                        <button
                            type="button"
                            onClick={toggleDateRangeOpen}
                            aria-expanded={dateRangeOpen}
                            className="flex w-full items-center justify-between gap-2 rounded-[var(--lotto-radius-sm)] px-0.5 py-1 text-left text-sm font-medium transition-colors hover:bg-[var(--lotto-surface-muted)]"
                        >
                            <span className="inline-flex items-center gap-1.5 text-[var(--lotto-fg)]">
                                <AppIcon icon={CalendarRange} size={14} strokeWidth={1.75} />
                                {t('draws.dateRange')}
                                {dateFilterActive ? (
                                    <span className="rounded-full bg-[var(--lotto-fg)] px-1.5 py-0.5 text-[0.6rem] font-semibold text-white">
                                        {t('common.on')}
                                    </span>
                                ) : null}
                            </span>
                            <ChevronDown
                                className={`size-3.5 shrink-0 text-[var(--lotto-muted)] transition-transform duration-300 ${
                                    dateRangeOpen ? 'rotate-180' : ''
                                }`}
                                aria-hidden
                            />
                        </button>

                        <div
                            className={`grid transition-[grid-template-rows] duration-300 ease-out ${
                                dateRangeOpen ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'
                            }`}
                        >
                            <div className="overflow-hidden">
                                <div className="space-y-2 pt-2">
                                    <div className="grid gap-2 sm:grid-cols-2">
                                        <label className="block space-y-1">
                                            <span className="text-[0.65rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                                {t('common.from')}
                                            </span>
                                            <input
                                                type="date"
                                                value={dateRange.from}
                                                min={dateBounds.min}
                                                max={dateBounds.max}
                                                onChange={(e) => onDateFromChange(e.target.value)}
                                                onClick={(e) => openDatePicker(e.currentTarget)}
                                                onFocus={(e) => openDatePicker(e.currentTarget)}
                                                className="w-full cursor-pointer rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-bg)] px-3 py-2 text-sm outline-none focus:border-[var(--lotto-border-strong)]"
                                            />
                                        </label>
                                        <label className="block space-y-1">
                                            <span className="text-[0.65rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                                {t('common.to')}
                                            </span>
                                            <input
                                                type="date"
                                                value={dateRange.to}
                                                min={dateBounds.min}
                                                max={dateBounds.max}
                                                onChange={(e) => onDateToChange(e.target.value)}
                                                onClick={(e) => openDatePicker(e.currentTarget)}
                                                onFocus={(e) => openDatePicker(e.currentTarget)}
                                                className="w-full cursor-pointer rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-bg)] px-3 py-2 text-sm outline-none focus:border-[var(--lotto-border-strong)]"
                                            />
                                        </label>
                                    </div>
                                    <div className="flex flex-wrap items-center justify-between gap-2">
                                        <p className="text-[0.7rem] text-[var(--lotto-muted)]">
                                            {t('draws.available', {
                                                from: dateBounds.min,
                                                to: dateBounds.max,
                                            })}
                                        </p>
                                        {dateFilterActive ? (
                                            <button
                                                type="button"
                                                onClick={resetDateRange}
                                                className="text-xs font-semibold text-[var(--lotto-muted)] underline underline-offset-2 hover:text-[var(--lotto-fg)]"
                                            >
                                                {t('common.reset')}
                                            </button>
                                        ) : null}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                ) : null}
            </section>

            {listError ? <p className="text-sm text-red-600">{listError}</p> : null}

            <div className="overflow-hidden rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)]">
                <div className="overflow-x-auto">
                    <table className="w-full min-w-[720px] border-collapse text-left text-sm">
                        <thead>
                            <tr className="border-b border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/70">
                                <SortableTh
                                    label={t('draws.type')}
                                    column="lotteryType"
                                    sortKey={sortKey}
                                    sortDir={sortDir}
                                    onSort={toggleSort}
                                />
                                <SortableTh
                                    label={t('draws.drawCol')}
                                    column="drawNumber"
                                    sortKey={sortKey}
                                    sortDir={sortDir}
                                    onSort={toggleSort}
                                />
                                <SortableTh
                                    label={t('draws.date')}
                                    column="drawDate"
                                    sortKey={sortKey}
                                    sortDir={sortDir}
                                    onSort={toggleSort}
                                />
                                <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('draws.numbers')}
                                </th>
                                <SortableTh
                                    label={t('draws.status')}
                                    column="status"
                                    sortKey={sortKey}
                                    sortDir={sortDir}
                                    onSort={toggleSort}
                                />
                                <th className="px-4 py-3 text-right text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                                    {t('draws.actions')}
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr>
                                    <td
                                        colSpan={6}
                                        className="px-4 py-12 text-center text-[var(--lotto-muted)]"
                                    >
                                        {t('common.loading')}
                                    </td>
                                </tr>
                            ) : pageRows.length === 0 ? (
                                <tr>
                                    <td
                                        colSpan={6}
                                        className="px-4 py-12 text-center text-[var(--lotto-muted)]"
                                    >
                                        {t('draws.noRows')}
                                    </td>
                                </tr>
                            ) : (
                                pageRows.map((draw) => (
                                    <tr
                                        key={draw.id}
                                        className="border-b border-[var(--lotto-border)] last:border-b-0 hover:bg-[var(--lotto-surface-muted)]/50"
                                    >
                                        <td className="whitespace-nowrap px-4 py-3.5 align-middle">
                                            {draw.lotteryType === 'lotto6'
                                                ? t('common.lotto6')
                                                : t('common.lotto7')}
                                        </td>
                                        <td className="px-4 py-3.5 align-middle font-medium">
                                            {draw.drawNumber}
                                        </td>
                                        <td className="whitespace-nowrap px-4 py-3.5 align-middle text-[var(--lotto-muted)]">
                                            {draw.drawDate}
                                        </td>
                                        <td className="px-4 py-3.5 align-middle">
                                            <div className="flex flex-wrap gap-2">
                                                {draw.winningNumbers.map((n, i) => (
                                                    <NumberBall
                                                        key={`${draw.id}-m-${i}`}
                                                        value={n}
                                                        size="sm"
                                                    />
                                                ))}
                                                {draw.bonusNumbers.map((n, i) => (
                                                    <NumberBall
                                                        key={`${draw.id}-b-${i}`}
                                                        value={n}
                                                        tone="excellent"
                                                        size="sm"
                                                    />
                                                ))}
                                            </div>
                                        </td>
                                        <td className="px-4 py-3.5 align-middle">
                                            <StatusPill
                                                tone={draw.isPublished ? 'strong' : 'caution'}
                                            >
                                                {draw.isPublished
                                                    ? t('common.published')
                                                    : t('common.draft')}
                                            </StatusPill>
                                        </td>
                                        <td className="px-4 py-3.5 align-middle">
                                            <div className="flex items-center justify-end gap-0.5">
                                                <IconAction
                                                    label={t('common.edit')}
                                                    icon={Pencil}
                                                    onClick={() => startEdit(draw)}
                                                />
                                                <IconAction
                                                    label={
                                                        draw.isPublished
                                                            ? t('common.unpublish')
                                                            : t('common.publish')
                                                    }
                                                    icon={draw.isPublished ? EyeOff : Globe}
                                                    onClick={() => void onTogglePublish(draw)}
                                                />
                                                <IconAction
                                                    label={t('common.delete')}
                                                    icon={Trash2}
                                                    danger
                                                    onClick={() => void onDelete(draw)}
                                                />
                                            </div>
                                        </td>
                                    </tr>
                                ))
                            )}
                        </tbody>
                    </table>
                </div>
                <TablePagination
                    page={page}
                    pageSize={DRAWS_PAGE_SIZE}
                    total={filtered.length}
                    onPageChange={setPage}
                />
            </div>

            <SlideOver
                open={sheetOpen}
                title={editingId ? t('draws.editDraw') : t('draws.newDraw')}
                onClose={closeSheet}
                wide
            >
                <form onSubmit={onSubmit} className="space-y-5">
                    <div className="space-y-1.5 text-sm">
                        <p className="text-[var(--lotto-muted)]">{t('draws.type')}</p>
                        <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-1">
                            {(
                                [
                                    { id: 'lotto6' as const, labelKey: 'common.lotto6' as const },
                                    { id: 'lotto7' as const, labelKey: 'common.lotto7' as const },
                                ]
                            ).map((opt) => {
                                const active = form.lotteryType === opt.id;
                                return (
                                    <button
                                        key={opt.id}
                                        type="button"
                                        onClick={() => {
                                            if (form.lotteryType === opt.id) return;
                                            setForm(emptyForm(opt.id));
                                            setEditingId(null);
                                            setFormError(null);
                                        }}
                                        className={`rounded-full px-3 py-1.5 text-sm transition-colors ${
                                            active
                                                ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                                : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                                        }`}
                                    >
                                        {t(opt.labelKey)}
                                    </button>
                                );
                            })}
                        </div>
                    </div>

                    <label className="block space-y-1 text-sm">
                        <span className="text-[var(--lotto-muted)]">{t('draws.drawNumberLabel')}</span>
                        <input
                            required
                            value={form.drawNumber}
                            onChange={(e) => setForm((f) => ({ ...f, drawNumber: e.target.value }))}
                            placeholder={t('draws.placeholderDrawNumber')}
                            className="w-full rounded-xl border border-[var(--lotto-border)] bg-white px-3 py-2"
                        />
                    </label>

                    <label className="block space-y-1 text-sm">
                        <span className="text-[var(--lotto-muted)]">{t('draws.drawDateLabel')}</span>
                        <input
                            type="date"
                            required
                            value={form.drawDate}
                            onChange={(e) => setForm((f) => ({ ...f, drawDate: e.target.value }))}
                            className="w-full rounded-xl border border-[var(--lotto-border)] bg-white px-3 py-2"
                        />
                    </label>

                    <label className="flex items-center gap-2 text-sm">
                        <input
                            type="checkbox"
                            checked={!!form.isPublished}
                            onChange={(e) =>
                                setForm((f) => ({ ...f, isPublished: e.target.checked }))
                            }
                        />
                        <span>{t('draws.publishedCheckbox')}</span>
                    </label>

                    <div className="space-y-1.5 text-sm">
                        <p id="main-numbers-label" className="text-[var(--lotto-muted)]">
                            {t('draws.mainNumbersCount', { count: mainCount, max: numberMax })}
                        </p>
                        <NumberOtpInput
                            values={form.winningNumbers}
                            max={numberMax}
                            labelledBy="main-numbers-label"
                            onChange={(winningNumbers) =>
                                setForm((f) => ({ ...f, winningNumbers }))
                            }
                        />
                        <p className="text-xs text-[var(--lotto-muted-soft)]">
                            {t('draws.otpHintLong')}
                        </p>
                    </div>

                    <div className="space-y-1.5 text-sm">
                        <p id="bonus-numbers-label" className="text-[var(--lotto-muted)]">
                            {t('draws.bonusNumbersCount', { count: bonusCount, max: numberMax })}
                        </p>
                        <NumberOtpInput
                            values={form.bonusNumbers ?? []}
                            max={numberMax}
                            tone="bonus"
                            labelledBy="bonus-numbers-label"
                            onChange={(bonusNumbers) => setForm((f) => ({ ...f, bonusNumbers }))}
                        />
                    </div>

                    {formError ? <p className="text-sm text-[#b42318]">{formError}</p> : null}

                    <div className="flex flex-wrap gap-2 border-t border-[var(--lotto-border)] pt-5">
                        <button
                            type="submit"
                            disabled={saving}
                            className="rounded-full bg-[var(--lotto-fg)] px-4 py-2.5 text-sm font-semibold text-white disabled:opacity-60"
                        >
                            {saving
                                ? t('common.saving')
                                : editingId
                                  ? t('draws.updateDraw')
                                  : t('draws.createDraw')}
                        </button>
                        <button
                            type="button"
                            onClick={closeSheet}
                            className="rounded-full px-4 py-2.5 text-sm font-medium text-[var(--lotto-muted)] hover:bg-[var(--lotto-accent-soft)]"
                        >
                            {t('common.cancel')}
                        </button>
                    </div>
                </form>
            </SlideOver>
        </div>
    );
}

function SortableTh({
    label,
    column,
    sortKey,
    sortDir,
    onSort,
}: {
    label: string;
    column: SortKey;
    sortKey: SortKey;
    sortDir: SortDir;
    onSort: (key: SortKey) => void;
}) {
    const { t } = useI18n();
    const active = sortKey === column;
    const Icon = active ? (sortDir === 'asc' ? ArrowUp : ArrowDown) : ArrowUpDown;
    return (
        <th className="px-4 py-3 text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
            <button
                type="button"
                onClick={() => onSort(column)}
                className={`inline-flex items-center gap-1.5 transition-colors hover:text-[var(--lotto-fg)] ${
                    active ? 'text-[var(--lotto-fg)]' : ''
                }`}
            >
                {label}
                <Icon className={`size-3.5 ${active ? 'opacity-100' : 'opacity-40'}`} aria-hidden />
                <span className="sr-only">
                    {active
                        ? sortDir === 'asc'
                            ? t('common.sortedAsc')
                            : t('common.sortedDesc')
                        : t('common.sort')}
                </span>
            </button>
        </th>
    );
}

function SegmentedFilter<T extends string>({
    label,
    options,
    value,
    onChange,
}: {
    label: string;
    options: { id: T; label: string; count?: number }[];
    value: T;
    onChange: (id: T) => void;
}) {
    return (
        <div className="min-w-0 space-y-1">
            <p className="text-[0.65rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                {label}
            </p>
            <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-0.5">
                {options.map((opt) => {
                    const active = opt.id === value;
                    return (
                        <button
                            key={opt.id}
                            type="button"
                            onClick={() => onChange(opt.id)}
                            className={`rounded-full px-2.5 py-1 text-[0.8rem] transition-colors ${
                                active
                                    ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                    : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                            }`}
                        >
                            {opt.label}
                            {typeof opt.count === 'number' ? (
                                <span
                                    className={`ml-1 tabular-nums ${
                                        active ? 'text-white/80' : 'text-[var(--lotto-muted-soft)]'
                                    }`}
                                >
                                    {opt.count}
                                </span>
                            ) : null}
                        </button>
                    );
                })}
            </div>
        </div>
    );
}
