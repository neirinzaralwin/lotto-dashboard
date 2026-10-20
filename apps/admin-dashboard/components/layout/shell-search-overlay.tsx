'use client';

import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Check, RotateCcw, Search } from 'lucide-react';
import type { Draw, LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { NumberOtpInput } from '@/components/draws/number-otp-input';
import { drawContainsAllMains, useShellSearch, type SearchEntry } from '@/components/layout/shell-search';
import { UnderlineTabs } from '@/components/layout/underline-tabs';
import { AppIcon } from '@/components/ui/icon';
import { listDraws } from '@/lib/draws/draws-service';
import { createClient } from '@/lib/supabase/client';

const RESULT_LIMIT = 40;
/** Older searches stay visible but shorter, so the panel stays compact. */
const OLDER_RESULT_LIMIT = 10;

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
        searchHistory,
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
            // Every draw of the tab: past searches are filtered locally.
            const rows = await listDraws(client, {
                lotteryType: activeType,
                published: 'all',
            });
            setDraws(rows);
        } catch (err) {
            setLoadError(err instanceof Error ? err.message : t('search.failed'));
            setDraws([]);
        } finally {
            setLoading(false);
        }
        // appliedQuery: refetch on each submit so new/edited draws show up.
        // eslint-disable-next-line react-hooks/exhaustive-deps
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

    /** One result block per kept search, newest first. */
    const groups = useMemo(() => {
        const ofType = draws.filter((d) => d.lotteryType === activeType);
        return searchHistory.map((entry, index) => {
            const q = entry.query.toLowerCase();
            let rows = ofType;
            if (q) rows = rows.filter((d) => d.drawNumber.toLowerCase().includes(q));
            if (entry.balls.length > 0) rows = rows.filter((d) => drawContainsAllMains(d, entry.balls));
            const limit = index === 0 ? RESULT_LIMIT : OLDER_RESULT_LIMIT;
            return { entry, index, total: rows.length, rows: rows.slice(0, limit) };
        });
    }, [draws, activeType, searchHistory]);

    /** Ball values highlighted in a group's result chips. */
    function highlightFor(entry: SearchEntry) {
        if (entry.balls.length > 0) return new Set(entry.balls);
        if (/^\d{1,2}$/.test(entry.query)) return new Set([Number.parseInt(entry.query, 10)]);
        return new Set<number>();
    }

    function ballChipClass(n: number, tone: 'main' | 'bonus', highlight: Set<number>) {
        if (highlight.has(n)) {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[#e85d04] px-1 text-[0.65rem] font-semibold tabular-nums text-white ring-1 ring-[#d00000]/shadow-sm';
        }
        if (tone === 'bonus') {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[var(--lotto-excellent-soft)]/50 px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-excellent-soft)]';
        }
        return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-white px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-border)]';
    }

    function highlightText(value: string, className: string, q: string) {
        const lowerQ = q.toLowerCase();
        if (!lowerQ || !value.toLowerCase().includes(lowerQ)) {
            return <span className={className}>{value}</span>;
        }
        const idx = value.toLowerCase().indexOf(lowerQ);
        return (
            <span className={className}>
                {value.slice(0, idx)}
                <mark className="rounded-sm bg-[#ffba08] px-0.5 text-[#7a0404] not-italic">
                    {value.slice(idx, idx + lowerQ.length)}
                </mark>
                {value.slice(idx + lowerQ.length)}
            </span>
        );
    }

    function entryLabel(entry: SearchEntry) {
        const parts: string[] = [];
        if (entry.query) parts.push(`#${entry.query}`);
        if (entry.balls.length > 0) parts.push(t('nav.balls', { list: entry.balls.join(' · ') }));
        return parts.join(' · ');
    }

    const showIdle = !loading && !loadError && groups.length === 0;
    const hasActiveFilter = Boolean(needle) || hasNumberFilter || searchHistory.length > 0;

    const matchFooter = useMemo(() => {
        if (showIdle) return t('search.idlePrompt');
        if (searchHistory.length > 1) return t('search.historyHint', { count: searchHistory.length });
        const first = groups[0];
        if (!first) return t('search.idlePrompt');
        if (first.total === 1) return t('search.matchOne');
        if (first.total > first.rows.length) return t('search.matchManyPlus', { count: first.rows.length });
        return t('search.matchMany', { count: first.total });
    }, [showIdle, t, searchHistory.length, groups]);

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
                {!loading && !loadError
                    ? groups.map(({ entry, index, total, rows }) => {
                          const highlight = highlightFor(entry);
                          return (
                              <div
                                  key={`${index}-${entry.query}-${entry.balls.join(',')}`}
                                  className={`mb-2 ${index > 0 ? 'border-t border-dashed border-[var(--lotto-border)] pt-2 opacity-80' : ''}`}
                              >
                                  <p className="flex items-baseline gap-2 px-2.5 pb-1 pt-1 text-[0.65rem] font-medium uppercase tracking-[0.06em] text-[var(--lotto-muted-soft)]">
                                      <span>{index === 0 ? t('search.historyLatest') : t('search.historyEarlier')}</span>
                                      <span className="normal-case tracking-normal text-[var(--lotto-fg)]">
                                          {entryLabel(entry)}
                                      </span>
                                      <span className="ml-auto normal-case tracking-normal tabular-nums">
                                          {total === 1 ? t('search.matchOne') : t('search.matchMany', { count: total })}
                                      </span>
                                  </p>
                                  {rows.length === 0 ? (
                                      <p className="px-2.5 py-2 text-[0.8rem] text-[var(--lotto-muted)]">
                                          {t('search.noMatches')}
                                      </p>
                                  ) : (
                                      <ul className="space-y-0.5">
                                          {rows.map((draw) => {
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
                                                                      entry.query,
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
                                                                      {draw.isPublished ? t('common.published') : t('common.draft')}
                                                                  </span>
                                                              </div>
                                                              <div className="mt-1 flex flex-wrap gap-1">
                                                                  {draw.winningNumbers.map((n, i) => (
                                                                      <span
                                                                          key={`m-${i}`}
                                                                          title={highlight.has(n) ? t('search.matchedBall') : undefined}
                                                                          className={ballChipClass(n, 'main', highlight)}
                                                                      >
                                                                          {n}
                                                                      </span>
                                                                  ))}
                                                                  {draw.bonusNumbers.map((n, i) => (
                                                                      <span
                                                                          key={`b-${i}`}
                                                                          title={highlight.has(n) ? t('search.matchedBall') : undefined}
                                                                          className={ballChipClass(n, 'bonus', highlight)}
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
                                  )}
                              </div>
                          );
                      })
                    : null}
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
