'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { AlertTriangle, CheckCircle2, X } from 'lucide-react';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';
import {
    onFavoritesRefreshed,
    type FavoritesRefreshReport,
} from '@/lib/algorithms/favorites-events';
import { formatClock } from '@/lib/algorithms/format-time';

const VISIBLE_MS = 3000;
const ERROR_VISIBLE_MS = 6000;

/** Short-lived toast shown after a draw change auto-refreshes the favourites. */
export function FavoritesRefreshToast() {
    const { t, locale } = useI18n();
    const [report, setReport] = useState<FavoritesRefreshReport | null>(null);

    useEffect(() => onFavoritesRefreshed(setReport), []);

    useEffect(() => {
        if (!report) return;
        const id = window.setTimeout(
            () => setReport(null),
            report.status === 'error' ? ERROR_VISIBLE_MS : VISIBLE_MS,
        );
        return () => window.clearTimeout(id);
    }, [report]);

    if (!report || report.status === 'none') return null;

    const time = formatClock(report.at, locale);
    const isError = report.status === 'error';

    let detail: string;
    if (report.status === 'error') {
        detail = `${t('favoritesToast.failedBody')} (${report.message})`;
    } else {
        const moved = report.slots.filter((s) => s.status === 'slight' || s.status === 'changed');
        const stale = report.slots.filter((s) => s.status === 'stale');
        const label = (s: (typeof report.slots)[number]) =>
            `${t(`common.${s.lotteryType}`)} #${s.slot}`;
        const parts: string[] = [];
        parts.push(
            moved.length === 0
                ? t('favoritesToast.unchanged', { count: report.refreshed })
                : t('favoritesToast.changed', {
                      changed: moved.length,
                      count: report.refreshed,
                      list: moved.map((s) => `${label(s)} (${s.diff}/${s.total})`).join(', '),
                  }),
        );
        if (stale.length > 0) {
            parts.push(t('favoritesToast.stale', { list: stale.map(label).join(', ') }));
        }
        detail = parts.join(' ');
    }

    return (
        <div
            role="status"
            aria-live="polite"
            className="fixed inset-x-4 bottom-24 z-50 mx-auto max-w-sm md:inset-x-auto md:right-6 md:bottom-6"
        >
            <div
                className={`flex items-start gap-3 rounded-[var(--lotto-radius-sm)] border bg-[var(--lotto-surface)] px-4 py-3 shadow-lg ${
                    isError ? 'border-red-300' : 'border-[var(--lotto-border)]'
                }`}
            >
                <AppIcon
                    icon={isError ? AlertTriangle : CheckCircle2}
                    size={18}
                    className={isError ? 'mt-0.5 text-red-600' : 'mt-0.5 text-emerald-600'}
                />
                <div className="min-w-0 flex-1">
                    <p className="text-sm font-semibold tracking-tight">
                        {isError ? t('favoritesToast.failedTitle') : t('favoritesToast.title')}
                        <span className="ml-2 text-xs font-normal text-[var(--lotto-muted)]">
                            {time}
                        </span>
                    </p>
                    <p className="mt-0.5 text-xs text-[var(--lotto-muted)]">{detail}</p>
                    <Link
                        href="/algorithms"
                        className="mt-1 inline-block text-xs font-semibold underline underline-offset-2"
                    >
                        {t('favoritesToast.view')}
                    </Link>
                </div>
                <button
                    type="button"
                    onClick={() => setReport(null)}
                    aria-label={t('common.close')}
                    className="text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]"
                >
                    <AppIcon icon={X} size={16} />
                </button>
            </div>
        </div>
    );
}
