'use client';

import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Check, RotateCcw, Search } from 'lucide-react';
import type { Draw, LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { NumberOtpInput } from '@/components/draws/number-otp-input';
import { drawContainsAllMains, useShellSearch } from '@/components/layout/shell-search';
import { UnderlineTabs } from '@/components/layout/underline-tabs';
import { AppIcon } from '@/components/ui/icon';
import { listDraws } from '@/lib/draws/draws-service';
import { createClient } from '@/lib/supabase/client';

const RESULT_LIMIT = 40;

const SEARCH_TABS: { id: LotteryType; labelKey: string }[] = [
    { id: 'lotto6', labelKey: 'common.lotto6' },
    { id: 'lotto7', labelKey: 'common.lotto7' },
];

function numberMax(type: LotteryType) {
    return type === 'lotto6' ? 43 : 37;
}

/** Keep only digits so "第1234回" and "1 234" both search for 1234. */
function normalizeQuery(value: string) {
    return value.replace(/\D+/g, '');
}

export function ShellSearchOverlay({
    anchorRef,
}: {
    anchorRef: React.RefObject<HTMLElement | null>;
}) {
    const { t } = useI18n();
    const router = useRouter();
    const {
        open,
        setOpen,
        query,
        setQuery,
        appliedQuery,
        submitSearch,
        dirty,
        searchNumbers,
        setSearchNumbers,
        activeType,
        setActiveType,
        resetActive,
        filledBalls,
        hasNumberFilter,
        selectedDrawId,
        selectDraw,
    } = useShellSearch();

    const panelRef = useRef<HTMLDivElement>(null);
    const [draws, setDraws] = useState<Draw[]>([]);
    const [loading, setLoading] = useState(false);
    const [loadError, setLoadError] = useState<string | null>(null);

    const loadDraws = useCallback(async () => {
        setLoading(true);
        setLoadError(null);
        try {
            const client = createClient();
            const rows = await listDraws(client, {
                lotteryType: activeType,
                published: 'all',
                search: appliedQuery || undefined,
            });
            setDraws(rows);
        } catch (err) {
            setLoadError(err instanceof Error ? err.message : t('search.failed'));
            setDraws([]);
        } finally {
            setLoading(false);
        }
    }, [activeType, appliedQuery, t]);

    useEffect(() => {
        if (!open) return;
        // Only runs on open / tab switch / submit — typing never fetches.
        void loadDraws();
    }, [open, loadDraws]);

    useEffect(() => {
        if (!open) return;

        function onKey(e: KeyboardEvent) {
            if (e.key === 'Escape') setOpen(false);
        }

        function onPointer(e: MouseEvent) {
            const target = e.target as Node;
            if (panelRef.current?.contains(target)) return;
            if (anchorRef.current?.contains(target)) return;
            setOpen(false);
        }

        document.addEventListener('keydown', onKey);
        document.addEventListener('mousedown', onPointer);
        return () => {
            document.removeEventListener('keydown', onKey);
            document.removeEventListener('mousedown', onPointer);
        };
    }, [open, setOpen, anchorRef]);

    const needle = appliedQuery.toLowerCase();

    const filtered = useMemo(() => {
        if (!needle && !hasNumberFilter) return [];
        let rows = draws.filter((d) => d.lotteryType === activeType);
        if (needle) rows = rows.filter((d) => d.drawNumber.toLowerCase().includes(needle));
        if (hasNumberFilter) rows = rows.filter((d) => drawContainsAllMains(d, filledBalls));
        return rows.slice(0, RESULT_LIMIT);
    }, [draws, needle, hasNumberFilter, filledBalls, activeType]);

    /** Ball values that should be visually highlighted in result chips. */
    const highlightBalls = useMemo(() => {
        if (hasNumberFilter) return new Set(filledBalls);
        if (/^\d{1,2}$/.test(needle)) return new Set([Number.parseInt(needle, 10)]);
        return new Set<number>();
    }, [hasNumberFilter, filledBalls, needle]);

    function ballChipClass(n: number, tone: 'main' | 'bonus') {
        if (highlightBalls.has(n)) {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[#e85d04] px-1 text-[0.65rem] font-semibold tabular-nums text-white ring-1 ring-[#d00000]/shadow-sm';
        }
        if (tone === 'bonus') {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[var(--lotto-excellent-soft)]/50 px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-excellent-soft)]';
        }
        return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-white px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-border)]';
    }

    function highlightText(value: string, className: string) {
        if (!needle || !value.toLowerCase().includes(needle)) {
            return <span className={className}>{value}</span>;
        }
        const lower = value.toLowerCase();
        const idx = lower.indexOf(needle);
        const before = value.slice(0, idx);
        const match = value.slice(idx, idx + needle.length);
        const after = value.slice(idx + needle.length);
        return (
            <span className={className}>
                {before}
                <mark className="rounded-sm bg-[#ffba08] px-0.5 text-[#7a0404] not-italic">
                    {match}
                </mark>
                {after}
            </span>
        );
    }

    const showIdle = !loading && !loadError && !needle && !hasNumberFilter;
    const hasActiveFilter = Boolean(needle) || hasNumberFilter;

    const matchFooter = useMemo(() => {
        if (showIdle) return t('search.idlePrompt');
        const plus = draws.length > filtered.length && (needle || hasNumberFilter);
        if (filtered.length === 1 && !plus) return t('search.matchOne');
        if (plus) return t('search.matchManyPlus', { count: filtered.length });
        return t('search.matchMany', { count: filtered.length });
    }, [showIdle, t, draws.length, filtered.length, needle, hasNumberFilter]);

    function onSelect(draw: Draw) {
        selectDraw(draw.id);
        setOpen(false);
        router.push(`/draws?type=${draw.lotteryType}`);
    }

    if (!open) return null;

    return (
        <div
            ref={panelRef}
            role="dialog"
            aria-label={t('search.dialog')}
            className="absolute right-0 top-[calc(100%+0.5rem)] z-50 w-[min(100vw-1.5rem,22rem)] overflow-hidden rounded-2xl border border-[var(--lotto-border)] bg-[var(--lotto-surface)] shadow-[0_12px_40px_rgba(0,0,0,0.1)] sm:w-[26rem]"
        >
            <div className="space-y-3 border-b border-[var(--lotto-border)] px-3 py-3">
                <div className="flex items-start gap-2">
                    <div className="min-w-0 flex-1">
                        <UnderlineTabs
                            tabs={SEARCH_TABS.map((tab) => ({
                                id: tab.id,
                                label: t(tab.labelKey),
                            }))}
                            value={activeType}
                            onChange={setActiveType}
                        />
                    </div>
                    <button
                        type="button"
                        onClick={resetActive}
                        disabled={!hasActiveFilter}
                        title={t('search.reset')}
                        aria-label={t('search.reset')}
                        className="inline-flex h-6 w-6 shrink-0 items-center justify-center rounded-md text-[var(--lotto-muted)] transition-colors hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)] disabled:pointer-events-none disabled:opacity-40"
                    >
                        <AppIcon icon={RotateCcw} size={14} />
                    </button>
                </div>

                <form
                    className="space-y-3"
                    onSubmit={(e) => {
                        e.preventDefault();
                        submitSearch();
                    }}
                >
                <label className="relative block">
                    <span className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-[var(--lotto-muted-soft)]">
                        <AppIcon icon={Search} size={14} />
                    </span>
                    <input
                        autoFocus
                        inputMode="numeric"
                        value={query}
                        onChange={(e) => setQuery(normalizeQuery(e.target.value))}
                        placeholder={t('search.drawNumberPlaceholder', {
                            type: t(`common.${activeType}`),
                        })}
                        className="w-full rounded-xl border border-[var(--lotto-border)] bg-white py-2 pl-8 pr-3 text-[0.8rem] outline-none transition-colors placeholder:text-[var(--lotto-muted-soft)] focus:border-[var(--lotto-border-strong)]"
                    />
                </label>

                <div className="space-y-2">
                    <p
                        id="shell-search-mains"
                        className="text-[0.65rem] font-medium uppercase tracking-wide text-[var(--lotto-muted-soft)]"
                    >
                        {t('common.main')}
                    </p>
                    <NumberOtpInput
                        size="sm"
                        values={searchNumbers.mains}
                        onChange={(mains) => setSearchNumbers({ mains })}
                        max={numberMax(activeType)}
                        labelledBy="shell-search-mains"
                        tone="main"
                        enterSubmits
                    />
                </div>
                <div className="flex items-center justify-between gap-2">
                    <span className="text-[0.65rem] text-[var(--lotto-muted-soft)]">
                        {dirty ? t('search.pressEnter') : null}
                    </span>
                    <button
                        type="submit"
                        className={`inline-flex items-center gap-1.5 rounded-full px-3.5 py-1.5 text-xs font-semibold transition-colors ${
                            dirty
                                ? 'bg-[var(--lotto-fg)] text-white'
                                : 'border border-[var(--lotto-border)] text-[var(--lotto-fg)]'
                        }`}
                    >
                        <AppIcon icon={Search} size={13} />
                        {t('search.submit')}
                    </button>
                </div>
                </form>
            </div>

            <div className="max-h-[min(50vh,22rem)] overflow-y-auto px-1.5 py-2">
                {loading ? (
                    <p className="px-2.5 py-4 text-center text-[0.8rem] text-[var(--lotto-muted)]">
                        {t('search.searching')}
                    </p>
                ) : null}
                {loadError ? (
                    <p className="px-2.5 py-4 text-center text-[0.8rem] text-[#b42318]">{loadError}</p>
                ) : null}
                {showIdle ? (
                    <p className="px-2.5 py-4 text-center text-[0.8rem] text-[var(--lotto-muted)]">
                        {t('search.idlePrompt')}
                    </p>
                ) : null}
                {!loading && !loadError && !showIdle && filtered.length === 0 ? (
                    <p className="px-2.5 py-4 text-center text-[0.8rem] text-[var(--lotto-muted)]">
                        {t('search.noMatches')}
                    </p>
                ) : null}

                {!loading && !showIdle && filtered.length > 0 ? (
                    <div className="mb-2">
                        <p className="px-2.5 pb-1 pt-1 text-[0.65rem] font-medium uppercase tracking-[0.06em] text-[var(--lotto-muted-soft)]">
                            {t('search.drawsOfType', { type: t(`common.${activeType}`) })}
                        </p>
                        <ul className="space-y-0.5">
                            {filtered.map((draw) => {
                                const selected = selectedDrawId === draw.id;
                                return (
                                    <li key={draw.id}>
                                        <button
                                            type="button"
                                            onClick={() => onSelect(draw)}
                                            className={`flex w-full items-start gap-2 rounded-xl px-2.5 py-2 text-left transition-colors ${
                                                selected
                                                    ? 'bg-[var(--lotto-accent-soft)]'
                                                    : 'hover:bg-[var(--lotto-surface-muted)]'
                                            }`}
                                        >
                                            <div className="min-w-0 flex-1">
                                                <div className="flex items-baseline gap-2">
                                                    {highlightText(
                                                        `#${draw.drawNumber}`,
                                                        'text-[0.8rem] font-semibold tabular-nums',
                                                    )}
                                                    <span className="text-[0.7rem] text-[var(--lotto-muted)]">
                                                        {draw.drawDate}
                                                    </span>
                                                    <span
                                                        className={`ml-auto shrink-0 text-[0.65rem] font-medium ${
                                                            draw.isPublished
                                                                ? 'text-[var(--lotto-delta)]'
                                                                : 'text-[var(--lotto-muted-soft)]'
                                                        }`}
                                                    >
                                                        {draw.isPublished
                                                            ? t('common.published')
                                                            : t('common.draft')}
                                                    </span>
                                                </div>
                                                <div className="mt-1 flex flex-wrap gap-1">
                                                    {draw.winningNumbers.map((n, i) => (
                                                        <span
                                                            key={`m-${i}`}
                                                            title={
                                                                highlightBalls.has(n)
                                                                    ? t('search.matchedBall')
                                                                    : undefined
                                                            }
                                                            className={ballChipClass(n, 'main')}
                                                        >
                                                            {n}
                                                        </span>
                                                    ))}
                                                    {draw.bonusNumbers.map((n, i) => (
                                                        <span
                                                            key={`b-${i}`}
                                                            title={
                                                                highlightBalls.has(n)
                                                                    ? t('search.matchedBall')
                                                                    : undefined
                                                            }
                                                            className={ballChipClass(n, 'bonus')}
                                                        >
                                                            {n}
                                                        </span>
                                                    ))}
                                                </div>
                                            </div>
                                            {selected ? (
                                                <AppIcon
                                                    icon={Check}
                                                    size={16}
                                                    className="mt-0.5 shrink-0 text-[var(--lotto-fg)]"
                                                />
                                            ) : null}
                                        </button>
                                    </li>
                                );
                            })}
                        </ul>
                    </div>
                ) : null}
            </div>

            <div className="flex items-center justify-between border-t border-[var(--lotto-border)] px-3 py-2 text-[0.7rem] text-[var(--lotto-muted)]">
                <span>{matchFooter}</span>
                {hasNumberFilter ? (
                    <span className="tabular-nums">
                        {t('nav.balls', { list: filledBalls.join(' · ') })}
                    </span>
                ) : null}
            </div>
        </div>
    );
}
