'use client';

import Link from 'next/link';
import { useEffect, useMemo, useState } from 'react';
import { Bell, Dices, Sparkles, Upload } from 'lucide-react';
import type { Draw } from '@repo/types';
import { NumberBall, QuietText, StatusPill } from '@/components/bento/primitives';
import { useI18n } from '@/components/i18n/locale-provider';
import { MetricCard } from '@/components/layout/metric-card';
import { PageHeader } from '@/components/layout/page-header';
import { AppIcon } from '@/components/ui/icon';
import { createClient } from '@/lib/supabase/client';
import { getDrawOverview } from '@/lib/draws/draws-service';

type OverviewState = {
    total: number;
    lotto6Count: number;
    lotto7Count: number;
    publishedCount: number;
    draftCount: number;
    latest: Draw[];
};

function formatDate(iso: string, locale: string) {
    const d = new Date(`${iso}T00:00:00`);
    return d.toLocaleDateString(locale === 'ja' ? 'ja-JP' : 'en-US', {
        day: 'numeric',
        month: 'short',
        year: 'numeric',
    });
}

export function OverviewClient() {
    const { t, locale } = useI18n();
    const [data, setData] = useState<OverviewState | null>(null);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        void (async () => {
            try {
                const client = createClient();
                const overview = await getDrawOverview(client);
                setData(overview);
            } catch (err) {
                setError(err instanceof Error ? err.message : t('overview.loadFailed'));
            }
        })();
    }, [t]);

    const latest6 = data?.latest.find((d) => d.lotteryType === 'lotto6');
    const latest7 = data?.latest.find((d) => d.lotteryType === 'lotto7');
    const publishedPct =
        data && data.total > 0 ? Math.round((data.publishedCount / data.total) * 100) : 0;

    const controls = useMemo(
        () =>
            [
                {
                    href: '/draws',
                    icon: Dices,
                    title: t('overview.controlDraws'),
                    body: t('overview.controlDrawsBody'),
                    meta: data
                        ? t('overview.unpublished', { count: data.draftCount })
                        : '—',
                },
                {
                    href: '/import',
                    icon: Upload,
                    title: t('overview.controlImport'),
                    body: t('overview.controlImportBody'),
                    meta: t('overview.controlImportMeta'),
                },
                {
                    href: '/algorithms',
                    icon: Sparkles,
                    title: t('overview.controlAlgorithms'),
                    body: t('overview.controlAlgorithmsBody'),
                    meta: t('common.comingSoon'),
                },
                {
                    href: '/notifications',
                    icon: Bell,
                    title: t('overview.controlNotifications'),
                    body: t('overview.controlNotificationsBody'),
                    meta: t('overview.controlNotificationsMeta'),
                },
            ] as const,
        [t, data],
    );

    return (
        <div className="space-y-6 sm:space-y-8">
            <PageHeader
                crumbs={[{ label: t('brand.lotto') }, { label: t('overview.title') }]}
                title={t('overview.title')}
                subtitle={t('overview.subtitle')}
            />

            {error ? <p className="text-sm text-red-600">{error}</p> : null}

            <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
                <MetricCard
                    label={t('overview.totalDraws')}
                    value={data ? String(data.total) : '…'}
                />
                <MetricCard
                    label={t('common.lotto6')}
                    value={data ? String(data.lotto6Count) : '…'}
                />
                <MetricCard
                    label={t('common.lotto7')}
                    value={data ? String(data.lotto7Count) : '…'}
                />
                <MetricCard
                    label={t('overview.published')}
                    value={data ? `${data.publishedCount} (${publishedPct}%)` : '…'}
                />
            </div>

            <div className="grid gap-4 lg:grid-cols-2">
                {[
                    { label: t('common.lotto6'), draw: latest6 },
                    { label: t('common.lotto7'), draw: latest7 },
                ].map(({ label, draw }) => (
                    <div
                        key={label}
                        className="rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-4"
                    >
                        <div className="mb-3 flex items-center justify-between gap-2">
                            <h2 className="text-sm font-semibold uppercase tracking-wide text-[var(--lotto-muted-soft)]">
                                {t('overview.latest', { type: label })}
                            </h2>
                            {draw ? (
                                <StatusPill tone={draw.isPublished ? 'strong' : 'neutral'}>
                                    {draw.isPublished ? t('common.published') : t('common.draft')}
                                </StatusPill>
                            ) : null}
                        </div>
                        {draw ? (
                            <>
                                <p className="text-lg font-semibold">
                                    {t('overview.drawLabel', { number: draw.drawNumber })}
                                </p>
                                <QuietText>{formatDate(draw.drawDate, locale)}</QuietText>
                                <div className="mt-3 flex flex-wrap gap-2">
                                    {draw.winningNumbers.map((n) => (
                                        <NumberBall key={`${draw.id}-m-${n}`} value={n} />
                                    ))}
                                    {draw.bonusNumbers.map((n) => (
                                        <NumberBall
                                            key={`${draw.id}-b-${n}`}
                                            value={n}
                                            tone="excellent"
                                        />
                                    ))}
                                </div>
                            </>
                        ) : (
                            <QuietText>
                                {data ? t('overview.noDrawYet') : t('common.loading')}
                            </QuietText>
                        )}
                    </div>
                ))}
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
                {controls.map((item) => (
                    <Link
                        key={item.href}
                        href={item.href}
                        className="rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-white p-4 transition-colors hover:bg-[var(--lotto-surface)]"
                    >
                        <div className="mb-2 flex items-center gap-2">
                            <AppIcon icon={item.icon} size={18} />
                            <h3 className="font-semibold">{item.title}</h3>
                        </div>
                        <p className="text-sm text-[var(--lotto-muted)]">{item.body}</p>
                        <p className="mt-2 text-xs font-medium text-[var(--lotto-muted-soft)]">
                            {item.meta}
                        </p>
                    </Link>
                ))}
            </div>
        </div>
    );
}
