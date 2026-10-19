'use client';

import { useEffect, useState } from 'react';
import { ChevronDown } from 'lucide-react';
import { AppIcon } from '@/components/ui/icon';
import { useI18n } from '@/components/i18n/locale-provider';
import { BentoCard, CardLabel, StatusPill } from '@/components/bento/primitives';
import {
    changeLevel,
    countDiff,
    publishedKey,
    type ChangeLevel,
    type FavoriteSlot,
    type PublishedFavorite,
} from '@/lib/algorithms/recommendations-service';
import { formatExactTime } from '@/lib/algorithms/format-time';

type Row = {
    key: string;
    slot: FavoriteSlot;
    live: PublishedFavorite | undefined;
    level: ChangeLevel | 'off';
    diff: number;
    total: number;
    current: number[];
    previous: number[] | null;
};

const SEEN_KEY = 'lotto-favorites-summary-seen-at';

const PILL_TONE = {
    unchanged: 'strong',
    slight: 'caution',
    changed: 'excellent',
    off: 'neutral',
} as const;

/**
 * At-a-glance answer to "did the favourites change after the last draw?".
 * A slot counts as changed only when its last recalculation produced new
 * numbers (numbers_changed_at === generated_at); otherwise it was simply
 * re-confirmed. Changed balls are highlighted against the previous set.
 */
export function FavoritesChangeSummary({
    lotto6,
    lotto7,
    published,
}: {
    lotto6: FavoriteSlot[];
    lotto7: FavoriteSlot[];
    published: Map<string, PublishedFavorite>;
}) {
    const { t, locale } = useI18n();
    const [open, setOpen] = useState(false);
    const [seenAt, setSeenAt] = useState<string | null>(null);

    useEffect(() => {
        try {
            setSeenAt(window.localStorage.getItem(SEEN_KEY));
        } catch {
            /* private mode */
        }
    }, []);

    const rows: Row[] = [...lotto6, ...lotto7].map((slot) => {
        const live = slot.algorithmName
            ? published.get(publishedKey(slot.lotteryType, slot.algorithmName))
            : undefined;
        const current = live ? [...live.winningNumbers, ...live.bonusNumbers] : [];
        const previous =
            live?.previousNumbers != null
                ? [...live.previousNumbers, ...(live.previousBonusNumbers ?? [])]
                : null;
        if (!live) {
            return { key: `${slot.lotteryType}-${slot.slot}`, slot, live, level: 'off', diff: 0, total: 0, current, previous };
        }
        const changedOnLastRun =
            previous != null && live.numbersChangedAt != null && live.numbersChangedAt === live.generatedAt;
        const diff = changedOnLastRun ? countDiff(previous, current) : 0;
        return {
            key: `${slot.lotteryType}-${slot.slot}`,
            slot,
            live,
            level: changedOnLastRun ? changeLevel(diff, current.length) : 'unchanged',
            diff,
            total: current.length,
            current,
            previous,
        };
    });

    const counts = { unchanged: 0, slight: 0, changed: 0, off: 0 };
    for (const r of rows) counts[r.level] += 1;
    const lastRun = rows
        .map((r) => r.live?.generatedAt)
        .filter((v): v is string => Boolean(v))
        .sort()
        .at(-1);

    const headline =
        counts.slight + counts.changed === 0
            ? t('favoritesSummary.headlineStable', { count: counts.unchanged })
            : t('favoritesSummary.headlineMixed', {
                  unchanged: counts.unchanged,
                  slight: counts.slight,
                  changed: counts.changed,
              });

    // "Since you last looked" — survives a second Generate that re-confirms the
    // same numbers (which resets the *last run* to Unchanged but not the change).
    const changeTimes = rows
        .filter((r) => r.previous != null && r.live?.numbersChangedAt)
        .map((r) => r.live!.numbersChangedAt as string);
    const lastChangeAt =
        changeTimes.sort((a, b) => Date.parse(a) - Date.parse(b)).at(-1) ?? null;
    const unseenCount = changeTimes.filter(
        (at) => seenAt == null || Date.parse(at) > Date.parse(seenAt),
    ).length;
    const unseen = unseenCount > 0;

    function toggle() {
        const next = !open;
        setOpen(next);
        if (next && lastChangeAt) {
            setSeenAt(lastChangeAt);
            try {
                window.localStorage.setItem(SEEN_KEY, lastChangeAt);
            } catch {
                /* private mode */
            }
        }
    }

    return (
        <BentoCard className="!p-0 overflow-hidden">
            <button
                type="button"
                onClick={toggle}
                aria-expanded={open}
                className="flex w-full items-center gap-3 px-4 py-3.5 text-left transition-colors hover:bg-[var(--lotto-surface-muted)]/60 sm:px-5"
            >
                <span className="relative inline-flex shrink-0">
                    {unseen ? (
                        <span className="absolute inset-0 animate-ping rounded-full bg-[var(--lotto-excellent)] opacity-60" />
                    ) : null}
                    <span
                        key={`${lastChangeAt}-${unseenCount}`}
                        className={`fav-badge-pop relative inline-flex h-8 min-w-8 items-center justify-center rounded-full px-2 text-sm font-bold ${
                            unseen
                                ? 'bg-[var(--lotto-excellent)] text-[var(--lotto-fg)]'
                                : 'bg-[var(--lotto-strong-soft)] text-[#2f5f3d]'
                        }`}
                        aria-label={t('favoritesSummary.badge', { count: unseenCount })}
                    >
                        <CountUp value={unseenCount} />
                    </span>
                </span>
                <span className="min-w-0 flex-1">
                    <span className="flex flex-wrap items-baseline gap-x-3">
                        <CardLabel>{t('favoritesSummary.title')}</CardLabel>
                        <span className="text-[0.7rem] text-[var(--lotto-muted)]">
                            {lastRun
                                ? t('favoritesSummary.lastRun', { when: formatExactTime(lastRun, locale) ?? '' })
                                : t('algorithms.neverUpdated')}
                        </span>
                    </span>
                    <span className="mt-0.5 block truncate text-sm font-semibold tracking-tight">{headline}</span>
                </span>
                <AppIcon
                    icon={ChevronDown}
                    size={18}
                    className={`shrink-0 text-[var(--lotto-muted)] transition-transform duration-300 ${open ? 'rotate-180' : ''}`}
                />
            </button>

            <div
                className={`grid transition-[grid-template-rows] duration-300 ease-out ${
                    open ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'
                }`}
            >
                <div className="overflow-hidden">
                    <div className="border-t border-[var(--lotto-border)] px-4 pb-4 sm:px-5">
            <ul className="mt-1 divide-y divide-[var(--lotto-border)]">
                {rows.map((r) => (
                    <li key={r.key} className="flex flex-wrap items-center gap-x-4 gap-y-2 py-2.5">
                        <span className="w-36 shrink-0 text-sm font-medium">
                            {t(`common.${r.slot.lotteryType}`)} · {t('algorithms.favoriteN', { n: r.slot.slot })}
                        </span>
                        <span className="w-40 shrink-0">
                            <StatusPill tone={PILL_TONE[r.level]}>
                                {r.level === 'unchanged'
                                    ? t('favoritesSummary.unchanged')
                                    : r.level === 'off'
                                      ? t('algorithms.notPublishedYet')
                                      : t(
                                            r.level === 'slight'
                                                ? 'favoritesSummary.slight'
                                                : 'favoritesSummary.changed',
                                            { diff: r.diff, total: r.total },
                                        )}
                            </StatusPill>
                        </span>
                        {r.live ? (
                            <span className="flex flex-wrap items-center gap-1">
                                {r.current.map((n, i) => {
                                    // Highlight the last *real* change, even if a later run
                                    // re-confirmed the same numbers.
                                    const moved = r.previous != null && r.previous[i] !== n;
                                    return (
                                        <span
                                            key={i}
                                            title={moved ? `${r.previous?.[i] ?? '–'} → ${n}` : undefined}
                                            className={`inline-flex h-7 min-w-7 items-center justify-center rounded-full px-1 text-xs font-semibold ${
                                                moved
                                                    ? 'bg-[var(--lotto-excellent)] text-[var(--lotto-fg)] ring-2 ring-[var(--lotto-fg)]/30'
                                                    : 'bg-zinc-200 text-zinc-700'
                                            }`}
                                        >
                                            {n}
                                        </span>
                                    );
                                })}
                            </span>
                        ) : null}
                        {r.live?.numbersChangedAt ? (
                            <span className="ml-auto text-[0.7rem] text-[var(--lotto-muted-soft)]">
                                {t('favoritesSummary.numbersChanged', {
                                    when: formatExactTime(r.live.numbersChangedAt, locale) ?? '',
                                })}
                            </span>
                        ) : null}
                    </li>
                ))}
            </ul>
            <p className="mt-3 text-[0.7rem] text-[var(--lotto-muted-soft)]">{t('favoritesSummary.legend')}</p>
                    </div>
                </div>
            </div>
        </BentoCard>
    );
}

/** Counts 0 → value quickly so a fresh change catches the eye. */
function CountUp({ value }: { value: number }) {
    const [shown, setShown] = useState(0);
    useEffect(() => {
        if (value === 0) {
            setShown(0);
            return;
        }
        let n = 0;
        setShown(0);
        const id = window.setInterval(() => {
            n += 1;
            setShown(n);
            if (n >= value) window.clearInterval(id);
        }, Math.max(60, 400 / value));
        return () => window.clearInterval(id);
    }, [value]);
    return <>{shown}</>;
}
