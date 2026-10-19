'use client';

import { useEffect, useMemo, useState } from 'react';
import type { LotteryType } from '@repo/types';
import { useI18n } from '@/components/i18n/locale-provider';
import {
    RANGE_LIMIT_MAX,
    type FavoriteRange,
    type FavoriteSlotNo,
} from '@/lib/algorithms/algorithm-settings';
import type { DrawWindowRow } from '@/lib/algorithms/favorite-one';
import { previewSlot, type PreviewReason, type RangePreview } from '@/lib/algorithms/range-preview';
import { countDiff, fetchLatestPublished } from '@/lib/algorithms/recommendations-service';
import { createClient } from '@/lib/supabase/client';

const TYPES: LotteryType[] = ['lotto6', 'lotto7'];

function bonusCount(type: LotteryType) {
    return type === 'lotto6' ? 1 : 2;
}

function Balls({
    numbers,
    type,
    compareTo,
}: {
    numbers: number[];
    type: LotteryType;
    /** Highlight balls that differ from this set (same column). */
    compareTo?: number[];
}) {
    const mains = numbers.length - bonusCount(type);
    return (
        <span className="inline-flex flex-wrap items-center gap-1">
            {numbers.map((n, i) => {
                const moved = compareTo != null && compareTo[i] !== n;
                return (
                    <span key={i} className="inline-flex items-center gap-1">
                        {i === mains ? <span className="mx-0.5 h-4 w-px bg-[var(--lotto-border-strong)]" /> : null}
                        <span
                            title={moved ? `${compareTo?.[i] ?? '–'} → ${n}` : undefined}
                            className={`inline-flex h-6 min-w-6 items-center justify-center rounded-full px-1 text-[0.7rem] font-semibold tabular-nums ${
                                moved
                                    ? 'bg-[var(--lotto-excellent)] text-[var(--lotto-fg)] ring-2 ring-[var(--lotto-fg)]/30'
                                    : i >= mains
                                      ? 'bg-[var(--lotto-excellent-soft)]/60 text-zinc-700'
                                      : 'bg-zinc-200 text-zinc-700'
                            }`}
                        >
                            {n}
                        </span>
                    </span>
                );
            })}
        </span>
    );
}

function span(p: RangePreview, t: (k: string, v?: Record<string, string | number>) => string) {
    if (p.rows.length === 0) return t('rangePreview.noRows');
    return t('rangePreview.span', {
        size: p.size,
        newest: p.rows[0]!.drawNumber,
        oldest: p.rows[p.rows.length - 1]!.drawNumber,
    });
}

function reasonText(
    slot: FavoriteSlotNo,
    p: RangePreview,
    range: FavoriteRange,
    t: (k: string, v?: Record<string, string | number>) => string,
) {
    const key: Record<PreviewReason, string> = {
        fixed: 'rangePreview.reasonFixed',
        random: 'rangePreview.reasonRandom',
        atMin: slot <= 2 ? 'rangePreview.reasonAtMinWindow' : 'rangePreview.reasonAtMinKey',
        atMax: 'rangePreview.reasonAtMax',
        data: slot <= 2 ? 'rangePreview.reasonDataWindow' : 'rangePreview.reasonDataKey',
        noKey: 'rangePreview.reasonNoKey',
        short: 'rangePreview.reasonShort',
    };
    return t(key[p.reason], { size: p.size, row: p.keyRow ?? 0, max: range.max, min: range.min });
}

/**
 * Shows which draws a favorite really uses and — before saving — what a new
 * Min/Max would change. Runs the live algorithm on the newest published draws,
 * so it cannot disagree with Save + Generate.
 */
export function RangePreviewPanel({
    slot,
    saved,
    draft,
}: {
    slot: FavoriteSlotNo;
    saved: FavoriteRange;
    /** Valid, unsaved Min/Max typed by the admin (null when clean/invalid). */
    draft: FavoriteRange | null;
}) {
    const { t } = useI18n();
    const [history, setHistory] = useState<Record<LotteryType, DrawWindowRow[]> | null>(null);
    const [failed, setFailed] = useState(false);

    useEffect(() => {
        let cancelled = false;
        void (async () => {
            try {
                const client = createClient();
                const [a, b] = await Promise.all(
                    TYPES.map((type) => fetchLatestPublished(client, type, RANGE_LIMIT_MAX)),
                );
                if (!cancelled) setHistory({ lotto6: a ?? [], lotto7: b ?? [] });
            } catch {
                if (!cancelled) setFailed(true);
            }
        })();
        return () => {
            cancelled = true;
        };
    }, []);

    const [roll, setRoll] = useState(0);
    const dMin = draft?.min;
    const dMax = draft?.max;
    const previews = useMemo(() => {
        if (!history) return null;
        void roll; // re-roll button re-samples the random sizes
        return TYPES.map((type) => ({
            type,
            current: previewSlot(slot, type, history[type], saved),
            next:
                dMin != null && dMax != null
                    ? previewSlot(slot, type, history[type], { min: dMin, max: dMax })
                    : null,
        }));
    }, [history, slot, saved, dMin, dMax, roll]);

    if (failed) return <p className="w-full text-xs text-[#b42318]">{t('rangePreview.failed')}</p>;
    if (!previews) return <p className="w-full text-xs text-[var(--lotto-muted)]">{t('rangePreview.loading')}</p>;

    return (
        <div className="w-full space-y-3 border-t border-[var(--lotto-border)] pt-3">
            <div className="flex items-center justify-between gap-2">
                <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                    {t('rangePreview.title')}
                </p>
                <button
                    type="button"
                    onClick={() => setRoll((n) => n + 1)}
                    className="rounded-md px-2 py-0.5 text-xs text-[var(--lotto-muted)] ring-1 ring-[var(--lotto-border)] hover:text-[var(--lotto-fg)]"
                >
                    {t('rangePreview.reroll')}
                </button>
            </div>
            {previews.map(({ type, current, next }) => {
                const diff = next ? countDiff(current.numbers, next.numbers) : 0;
                return (
                    <div key={type} className="space-y-1.5 text-xs">
                        <p className="font-semibold">{t(`common.${type}`)}</p>
                        <div className="flex flex-wrap items-center gap-x-3 gap-y-1">
                            <span className="text-[var(--lotto-muted)]">
                                {t('rangePreview.current', { min: saved.min, max: saved.max })} · {span(current, t)}
                            </span>
                            {current.hasPick ? <Balls numbers={current.numbers} type={type} /> : null}
                        </div>
                        <p className="text-[var(--lotto-muted-soft)]">{reasonText(slot, current, saved, t)}</p>

                        {next && draft ? (
                            <div className="rounded-lg bg-[var(--lotto-surface)] px-2.5 py-2 ring-1 ring-[var(--lotto-border)]">
                                <div className="flex flex-wrap items-center gap-x-3 gap-y-1">
                                    <span className="font-medium">
                                        {t('rangePreview.ifSaved', { min: draft.min, max: draft.max })} · {span(next, t)}
                                    </span>
                                    {next.hasPick ? (
                                        <Balls
                                            numbers={next.numbers}
                                            type={type}
                                            compareTo={current.hasPick ? current.numbers : undefined}
                                        />
                                    ) : null}
                                </div>
                                <p className="mt-1 text-[var(--lotto-muted-soft)]">{reasonText(slot, next, draft, t)}</p>
                                <p
                                    className={`mt-1 font-semibold ${
                                        diff > 0 || !next.hasPick ? 'text-[var(--lotto-fg)]' : 'text-[var(--lotto-muted)]'
                                    }`}
                                >
                                    {!next.hasPick
                                        ? t('rangePreview.verdictNoPick')
                                        : diff === 0
                                            ? t('rangePreview.verdictSameNumbers')
                                            : t('rangePreview.verdictChange', { count: diff })}
                                </p>
                            </div>
                        ) : null}

                        {current.rows.length > 0 ? (
                            <details>
                                <summary className="cursor-pointer text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]">
                                    {t('rangePreview.showRows', { count: current.rows.length })}
                                </summary>
                                <ul className="mt-1.5 flex flex-wrap gap-1">
                                    {current.rows.map((r) => (
                                        <li
                                            key={r.drawNumber}
                                            className="rounded-md bg-white px-1.5 py-0.5 tabular-nums ring-1 ring-[var(--lotto-border)]"
                                        >
                                            #{r.drawNumber} · {r.drawDate}
                                        </li>
                                    ))}
                                </ul>
                            </details>
                        ) : null}
                    </div>
                );
            })}
        </div>
    );
}
