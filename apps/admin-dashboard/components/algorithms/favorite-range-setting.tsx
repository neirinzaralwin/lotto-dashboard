'use client';

import { FormEvent, useEffect, useState } from 'react';
import { ChevronDown, SlidersHorizontal } from 'lucide-react';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';
import {
    RANGE_LIMIT_MAX,
    RANGE_LIMIT_MIN,
    RangesStorageMissingError,
    saveFavoriteRange,
    validateRange,
    type FavoriteRange,
    type FavoriteSlotNo,
} from '@/lib/algorithms/algorithm-settings';
import { errorMessage } from '@/lib/algorithms/recommendations-service';
import { quietRegenerateFavorites } from '@/lib/draws/draws-service';
import { RangePreviewPanel } from '@/components/algorithms/range-preview-panel';
import { createClient } from '@/lib/supabase/client';

/**
 * Min–max history range for one favorite, shown at the top of its tab.
 * Saved to Supabase (`app_settings.favorite_ranges`); live favorites are
 * recalculated right after saving.
 */
export function FavoriteRangeSetting({
    slot,
    saved,
    ready,
    onSaved,
}: {
    slot: FavoriteSlotNo;
    saved: FavoriteRange;
    /** False when range storage is unavailable (migration missing). */
    ready: boolean;
    onSaved: () => void;
}) {
    const { t } = useI18n();
    const [min, setMin] = useState(String(saved.min));
    const [max, setMax] = useState(String(saved.max));
    const [busy, setBusy] = useState(false);
    const [open, setOpen] = useState(false);
    const [message, setMessage] = useState<{ text: string; error: boolean } | null>(null);

    // Keep inputs in sync with the saved value (e.g. after a reload)…
    useEffect(() => {
        setMin(String(saved.min));
        setMax(String(saved.max));
    }, [slot, saved.min, saved.max]);

    // …but only a tab switch clears the status line, not the reload a save triggers.
    useEffect(() => {
        setMessage(null);
    }, [slot]);

    const draft = { min: Number.parseInt(min, 10), max: Number.parseInt(max, 10) };
    const problem = validateRange(draft);
    const dirty =
        ready && problem === null && (draft.min !== saved.min || draft.max !== saved.max);
    const kind = slot <= 2 ? 'window' : 'key';

    async function onSubmit(e: FormEvent) {
        e.preventDefault();
        if (!dirty) return;
        setBusy(true);
        setMessage(null);
        try {
            const client = createClient();
            await saveFavoriteRange(client, slot, draft);
            const report = await quietRegenerateFavorites(client);
            onSaved();
            // Say what the refresh actually did — "nothing happened" must never be silent.
            if (report.status === 'error') {
                setMessage({ text: t('algorithms.rangeSavedRefreshFailed', { error: report.message }), error: true });
            } else if (report.status === 'none') {
                setMessage({ text: t('algorithms.rangeSavedNoLive', draft), error: false });
            } else {
                const moved = report.slots.filter((s) => s.status === 'slight' || s.status === 'changed').length;
                setMessage({
                    text:
                        moved > 0
                            ? t('algorithms.rangeSavedChanged', { ...draft, count: moved })
                            : t('algorithms.rangeSavedUnchanged', draft),
                    error: false,
                });
            }
        } catch (err) {
            setMessage({
                text:
                    err instanceof RangesStorageMissingError
                        ? t('algorithms.rangeMigrationMissing')
                        : errorMessage(err, t('algorithms.rangeFailed')),
                error: true,
            });
        } finally {
            setBusy(false);
        }
    }

    const inputClass =
        'w-16 rounded-lg border border-[var(--lotto-border)] bg-white px-2 py-1.5 text-center text-sm tabular-nums';

    const isOpen = open || !ready;

    return (
        <form
            onSubmit={onSubmit}
            className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/40"
        >
            <button
                type="button"
                onClick={() => setOpen((v) => !v)}
                aria-expanded={isOpen}
                className="flex w-full items-center gap-2 px-3.5 py-2 text-left"
            >
                <AppIcon icon={SlidersHorizontal} size={15} className="text-[var(--lotto-muted)]" />
                <span className="text-sm font-semibold tracking-tight">
                    {t(kind === 'window' ? 'algorithms.rangeLabelWindow' : 'algorithms.rangeLabelKey')}
                </span>
                <span className="rounded-full bg-white px-2 py-0.5 text-xs font-semibold tabular-nums ring-1 ring-[var(--lotto-border)]">
                    {saved.min === saved.max ? saved.min : `${saved.min}–${saved.max}`} {t('algorithms.rangeRows')}
                </span>
                {dirty ? (
                    <span className="rounded-full bg-[var(--lotto-excellent)] px-2 py-0.5 text-[0.65rem] font-semibold text-[var(--lotto-fg)]">
                        {draft.min}–{draft.max}
                    </span>
                ) : null}
                {!isOpen && message ? (
                    <span
                        className={`min-w-0 flex-1 truncate text-xs ${message.error ? 'text-[#b42318]' : 'text-[var(--lotto-strong)]'}`}
                    >
                        {message.text}
                    </span>
                ) : (
                    <span className="flex-1" />
                )}
                <AppIcon
                    icon={ChevronDown}
                    size={16}
                    className={`text-[var(--lotto-muted)] transition-transform duration-200 ${isOpen ? 'rotate-180' : ''}`}
                />
            </button>

            <div
                className={`grid transition-[grid-template-rows] duration-200 ease-out ${
                    isOpen ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'
                }`}
            >
                <div className="overflow-hidden">
                    <div className="flex flex-wrap items-center gap-x-3 gap-y-2 border-t border-[var(--lotto-border)] px-3.5 py-3">
                        <label className="flex items-center gap-1.5 text-xs text-[var(--lotto-muted)]">
                            {t('algorithms.rangeMin')}
                            <input
                                type="number"
                                inputMode="numeric"
                                min={RANGE_LIMIT_MIN}
                                max={RANGE_LIMIT_MAX}
                                value={min}
                                onChange={(e) => setMin(e.target.value)}
                                className={inputClass}
                            />
                        </label>
                        <span className="text-[var(--lotto-muted)]">–</span>
                        <label className="flex items-center gap-1.5 text-xs text-[var(--lotto-muted)]">
                            {t('algorithms.rangeMax')}
                            <input
                                type="number"
                                inputMode="numeric"
                                min={RANGE_LIMIT_MIN}
                                max={RANGE_LIMIT_MAX}
                                value={max}
                                onChange={(e) => setMax(e.target.value)}
                                className={inputClass}
                            />
                        </label>
                        <span className="text-xs text-[var(--lotto-muted)]">{t('algorithms.rangeRows')}</span>
                        <button
                            type="submit"
                            disabled={!dirty || busy}
                            className="ml-auto rounded-full bg-[var(--lotto-fg)] px-3.5 py-1.5 text-xs font-semibold text-white disabled:opacity-40"
                        >
                            {busy ? t('common.saving') : t('common.save')}
                        </button>
                        {!ready ? (
                            <p className="w-full text-xs font-medium text-[#b42318]">
                                {t('algorithms.rangeMigrationMissing')}
                            </p>
                        ) : null}
                        <p className="w-full text-xs text-[var(--lotto-muted-soft)]">
                            {problem === 'order'
                                ? t('algorithms.rangeErrorOrder')
                                : problem
                                  ? t('algorithms.rangeErrorLimits', { min: RANGE_LIMIT_MIN, max: RANGE_LIMIT_MAX })
                                  : t(kind === 'window' ? 'algorithms.rangeHintWindow' : 'algorithms.rangeHintKey')}
                        </p>
                        {message ? (
                            <p className={`w-full text-xs ${message.error ? 'text-[#b42318]' : 'text-[var(--lotto-strong)]'}`}>
                                {message.text}
                            </p>
                        ) : null}
                        {isOpen ? <RangePreviewPanel slot={slot} saved={saved} draft={dirty ? draft : null} /> : null}
                    </div>
                </div>
            </div>
        </form>
    );
}
