'use client';

import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Check, Search } from 'lucide-react';
import type { Draw, LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { NumberOtpInput } from '@/components/draws/number-otp-input';
import {
    drawContainsAllBalls,
    useShellSearch,
    type ShellSearchMode,
} from '@/components/layout/shell-search';
import { AppIcon } from '@/components/ui/icon';
import { listDraws } from '@/lib/draws/draws-service';
import { createClient } from '@/lib/supabase/client';

const RESULT_LIMIT = 40;

function numberMax(type: LotteryType) {
    return type === 'lotto6' ? 43 : 37;
}

function matchesTextQuery(draw: Draw, q: string): boolean {
    if (!q) return true;
    const needle = q.toLowerCase();
    return (
        draw.drawNumber.toLowerCase().includes(needle) ||
        draw.drawDate.toLowerCase().includes(needle)
    );
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
        mode,
        setMode,
        numberType,
        setNumberType,
        searchNumbers,
        setSearchNumbers,
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
                lotteryType: mode === 'numbers' ? numberType : 'all',
                published: 'all',
                search: mode === 'text' ? query : undefined,
            });
            setDraws(rows);
        } catch (err) {
            setLoadError(err instanceof Error ? err.message : t('search.failed'));
            setDraws([]);
        } finally {
            setLoading(false);
        }
    }, [mode, query, numberType, t]);

    useEffect(() => {
        if (!open) return;
        const timer = window.setTimeout(() => {
            void loadDraws();
        }, 150);
        return () => window.clearTimeout(timer);
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

    const filtered = useMemo(() => {
        let rows = draws;
        if (mode === 'text') {
            const q = query.trim();
            if (q) rows = rows.filter((d) => matchesTextQuery(d, q));
            else rows = [];
        } else if (hasNumberFilter) {
            rows = rows
                .filter((d) => d.lotteryType === numberType)
                .filter((d) => drawContainsAllBalls(d, filledBalls));
        } else {
            rows = [];
        }
        return rows.slice(0, RESULT_LIMIT);
    }, [draws, mode, query, hasNumberFilter, numberType, filledBalls]);

    /** Ball values that should be visually highlighted in result chips. */
    const highlightBalls = useMemo(() => {
        if (mode === 'numbers' && filledBalls.length > 0) {
            return new Set(filledBalls);
        }
        if (mode === 'text') {
            const q = query.trim();
            if (/^\d{1,2}$/.test(q)) {
                return new Set([Number.parseInt(q, 10)]);
            }
        }
        return new Set<number>();
    }, [mode, filledBalls, query]);

    const textNeedle = mode === 'text' ? query.trim().toLowerCase() : '';

    const grouped = useMemo(() => {
        const lotto6 = filtered.filter((d) => d.lotteryType === 'lotto6');
        const lotto7 = filtered.filter((d) => d.lotteryType === 'lotto7');
        return { lotto6, lotto7 };
    }, [filtered]);

    function ballChipClass(n: number, tone: 'main' | 'bonus') {
        const matched = highlightBalls.has(n);
        if (matched) {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[#e85d04] px-1 text-[0.65rem] font-semibold tabular-nums text-white ring-1 ring-[#d00000]/shadow-sm';
        }
        if (tone === 'bonus') {
            return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-[var(--lotto-excellent-soft)]/50 px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-excellent-soft)]';
        }
        return 'inline-flex h-5 min-w-5 items-center justify-center rounded-md bg-white px-1 text-[0.65rem] font-semibold tabular-nums ring-1 ring-[var(--lotto-border)]';
    }

    function highlightText(value: string, className: string) {
        if (!textNeedle || !value.toLowerCase().includes(textNeedle)) {
            return <span className={className}>{value}</span>;
        }
        const lower = value.toLowerCase();
        const idx = lower.indexOf(textNeedle);
        const before = value.slice(0, idx);
        const match = value.slice(idx, idx + textNeedle.length);
        const after = value.slice(idx + textNeedle.length);
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

    const idlePrompt =
        mode === 'text' ? t('search.idleText') : t('search.idleNumbers');

    const showIdle =
        !loading &&
        !loadError &&
        ((mode === 'text' && !query.trim()) || (mode === 'numbers' && !hasNumberFilter));

    const matchFooter = useMemo(() => {
        if (showIdle) {
            return mode === 'numbers' ? t('search.fillOtp') : t('search.searchDraws');
        }
        const plus =
            draws.length > filtered.length && mode === 'text' && query.trim();
        if (filtered.length === 1 && !plus) return t('search.matchOne');
        if (plus) return t('search.matchManyPlus', { count: filtered.length });
        return t('search.matchMany', { count: filtered.length });
    }, [showIdle, mode, t, draws.length, filtered.length, query]);

    function onSelect(draw: Draw) {
        selectDraw(draw.id);
        setOpen(false);
        router.push(`/draws?type=${draw.lotteryType}`);
    }

    function ModeChip({ id, label }: { id: ShellSearchMode; label: string }) {
        const active = mode === id;
        return (
            <button
                type="button"
                onClick={() => setMode(id)}
                className={`rounded-full px-2.5 py-1 text-[0.7rem] font-medium transition-colors ${
                    active
                        ? 'bg-[var(--lotto-fg)] text-white'
                        : 'bg-[var(--lotto-surface-muted)] text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                }`}
            >
                {label}
            </button>
        );
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
                <div className="flex items-center gap-1.5">
                    <ModeChip id="text" label={t('search.text')} />
                    <ModeChip id="numbers" label={t('search.numbers')} />
                </div>

                {mode === 'text' ? (
                    <label className="relative block">
                        <span className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-[var(--lotto-muted-soft)]">
                            <AppIcon icon={Search} size={14} />
                        </span>
                        <input
                            autoFocus
                            value={query}
                            onChange={(e) => setQuery(e.target.value)}
                            placeholder={t('search.placeholder')}
                            className="w-full rounded-xl border border-[var(--lotto-border)] bg-white py-2 pl-8 pr-3 text-[0.8rem] outline-none transition-colors placeholder:text-[var(--lotto-muted-soft)] focus:border-[var(--lotto-border-strong)]"
                        />
                    </label>
                ) : (
                    <div className="space-y-2.5">
                        <div className="flex items-center gap-1.5">
                            {(['lotto6', 'lotto7'] as const).map((game) => {
                                const active = numberType === game;
                                return (
                                    <button
                                        key={game}
                                        type="button"
                                        onClick={() => setNumberType(game)}
                                        className={`rounded-full px-2.5 py-1 text-[0.7rem] font-medium transition-colors ${
                                            active
                                                ? 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]'
                                                : 'text-[var(--lotto-muted)] hover:bg-[var(--lotto-surface-muted)]'
                                        }`}
                                    >
                                        {t(`common.${game}`)}
                                    </button>
                                );
                            })}
                        </div>
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
                                onChange={(mains) =>
                                    setSearchNumbers({ ...searchNumbers, mains })
                                }
                                max={numberMax(numberType)}
                                labelledBy="shell-search-mains"
                                tone="main"
                            />
                            <p
                                id="shell-search-bonus"
                                className="text-[0.65rem] font-medium uppercase tracking-wide text-[var(--lotto-muted-soft)]"
                            >
                                {t('common.bonus')}
                            </p>
                            <NumberOtpInput
                                size="sm"
                                values={searchNumbers.bonus}
                                onChange={(bonus) =>
                                    setSearchNumbers({ ...searchNumbers, bonus })
                                }
                                max={numberMax(numberType)}
                                labelledBy="shell-search-bonus"
                                tone="bonus"
                            />
                        </div>
                    </div>
                )}
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
                        {idlePrompt}
                    </p>
                ) : null}
                {!loading && !loadError && !showIdle && filtered.length === 0 ? (
                    <p className="px-2.5 py-4 text-center text-[0.8rem] text-[var(--lotto-muted)]">
                        {t('search.noMatches')}
                    </p>
                ) : null}

                {!loading && !showIdle
                    ? (['lotto6', 'lotto7'] as const).map((type) => {
                          const rows = grouped[type];
                          if (rows.length === 0) return null;
                          return (
                              <div key={type} className="mb-2">
                                  <p className="px-2.5 pb-1 pt-1 text-[0.65rem] font-medium uppercase tracking-[0.06em] text-[var(--lotto-muted-soft)]">
                                      {t('search.drawsOfType', { type: t(`common.${type}`) })}
                                  </p>
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
                                                              )}
                                                              {highlightText(
                                                                  draw.drawDate,
                                                                  'text-[0.7rem] text-[var(--lotto-muted)]',
                                                              )}
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
                                                                      className={ballChipClass(
                                                                          n,
                                                                          'main',
                                                                      )}
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
                                                                      className={ballChipClass(
                                                                          n,
                                                                          'bonus',
                                                                      )}
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
