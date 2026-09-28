'use client';

import { useMemo, useState } from 'react';
import { ArrowRight, CalendarDays, Equal, Hash, Sparkles } from 'lucide-react';
import type { LotteryType } from '@repo/types';
import {
    BentoCard,
    CardLabel,
    NumberBall,
    QuietText,
    StatusPill,
} from '@/components/bento/primitives';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';
import { digitalRootOfNumber } from '@/lib/algorithms/digital-root';
import type { FavoriteTwoColumnTrace, FavoriteTwoResult } from '@/lib/algorithms/favorite-two';

type Props = {
    lotto6: FavoriteTwoResult;
    lotto7: FavoriteTwoResult;
};

export function FavoriteTwoThinking({ lotto6, lotto7 }: Props) {
    const { t, locale } = useI18n();
    const [lotteryType, setLotteryType] = useState<LotteryType>('lotto6');
    const [activeColumn, setActiveColumn] = useState(0);

    const result = lotteryType === 'lotto6' ? lotto6 : lotto7;
    const mainColumns = result.columns.filter((c) => c.kind === 'main');
    const safeColumnIndex = Math.min(activeColumn, Math.max(0, mainColumns.length - 1));
    const active = mainColumns[safeColumnIndex] ?? mainColumns[0]!;

    const skippedCount = useMemo(
        () => result.scanRows.filter((r) => !r.matched).length,
        [result.scanRows],
    );

    const triggerLabel =
        result.triggeredBy === 'import'
            ? t('algorithms.triggerImport')
            : result.triggeredBy === 'draw'
              ? t('algorithms.triggerDraw')
              : t('algorithms.triggerDemo');

    return (
        <BentoCard className="!gap-0 overflow-hidden !p-0" tone="surface">
            <div className="border-b border-[var(--lotto-border)] bg-[linear-gradient(135deg,var(--lotto-bg-soft)_0%,var(--lotto-excellent-soft)_55%,var(--lotto-strong-soft)_100%)] px-4 py-5 sm:px-6 sm:py-6">
                <div className="flex flex-wrap items-start justify-between gap-3">
                    <div className="max-w-2xl">
                        <CardLabel className="!text-[var(--lotto-fg)]/70">
                            {t('algorithms.thinkingLabel', { n: 3 })}
                        </CardLabel>
                        <h2 className="mt-1 text-2xl font-semibold tracking-[-0.03em] sm:text-3xl">
                            {t('algorithms.thinkingTitleKeyMode')}
                        </h2>
                        <QuietText className="!mt-2 !text-sm !text-[var(--lotto-fg)]/75">
                            {t('algorithms.thinkingBodyKeyMode')}
                        </QuietText>
                    </div>
                    <div className="flex flex-wrap gap-2">
                        <StatusPill tone="strong">{triggerLabel}</StatusPill>
                        {result.keyRoot != null ? (
                            <StatusPill tone="excellent">
                                {t('algorithms.keyRoot', { root: result.keyRoot })}
                            </StatusPill>
                        ) : (
                            <StatusPill tone="caution">{t('algorithms.noKeyRoot')}</StatusPill>
                        )}
                    </div>
                </div>

                <div className="mt-5 grid gap-2 sm:grid-cols-3">
                    <TriggerStep
                        icon={CalendarDays}
                        step="01"
                        title={t('algorithms.stepKeyScanTitle')}
                        body={t('algorithms.stepKeyScanBody')}
                    />
                    <TriggerStep
                        icon={Equal}
                        step="02"
                        title={t('algorithms.stepKeyMatchTitle')}
                        body={t('algorithms.stepKeyMatchBody')}
                    />
                    <TriggerStep
                        icon={Hash}
                        step="03"
                        title={t('algorithms.stepKeyFilterTitle')}
                        body={t('algorithms.stepKeyFilterBody')}
                    />
                </div>
            </div>

            <div className="space-y-5 px-4 py-5 sm:px-6 sm:py-6">
                <div className="flex flex-wrap items-center justify-between gap-3">
                    <div className="inline-flex rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-1">
                        {(['lotto6', 'lotto7'] as const).map((type) => (
                            <button
                                key={type}
                                type="button"
                                onClick={() => {
                                    setLotteryType(type);
                                    setActiveColumn(0);
                                }}
                                className={`rounded-full px-3.5 py-1.5 text-sm font-semibold transition ${
                                    lotteryType === type
                                        ? 'bg-[var(--lotto-fg)] text-white'
                                        : 'text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                                }`}
                            >
                                {t(`common.${type}`)}
                            </button>
                        ))}
                    </div>
                    <p className="text-xs text-[var(--lotto-muted)]">
                        {t('algorithms.scanMeta', {
                            scanned: result.scanRows.length,
                            skipped: skippedCount,
                            history: result.history.length,
                        })}
                    </p>
                </div>

                <div className="grid gap-5 xl:grid-cols-[minmax(0,1.2fr)_minmax(0,1fr)]">
                    <section className="space-y-3">
                        <div className="flex items-center justify-between gap-2">
                            <h3 className="text-sm font-semibold tracking-tight">
                                {t('algorithms.scanTitle')}
                            </h3>
                            <QuietText className="!text-xs">{t('algorithms.scanHint')}</QuietText>
                        </div>

                        <div className="overflow-x-auto rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)]">
                            <table className="min-w-full border-collapse text-sm">
                                <thead>
                                    <tr className="bg-[var(--lotto-surface-muted)] text-left text-[0.7rem] uppercase tracking-[0.12em] text-[var(--lotto-muted-soft)]">
                                        <th className="px-3 py-2.5 font-medium">{t('algorithms.colDraw')}</th>
                                        <th className="px-3 py-2.5 font-medium">{t('algorithms.colDate')}</th>
                                        <th className="px-3 py-2.5 text-center font-medium">
                                            {t('algorithms.colDateRoot')}
                                        </th>
                                        <th className="px-3 py-2.5 text-center font-medium">
                                            {t('algorithms.colTimeRoot')}
                                        </th>
                                        <th className="px-3 py-2.5 text-center font-medium">
                                            {t('algorithms.colMatch')}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {result.scanRows.map((row, rowIndex) => (
                                        <tr
                                            key={`${row.drawNumber}-${row.drawDate}`}
                                            className={`border-t border-[var(--lotto-border)] ${
                                                row.matched ? 'bg-[var(--lotto-strong-soft)]/50' : ''
                                            }`}
                                            style={{
                                                animation: `lotto-rise 0.45s cubic-bezier(0.22, 1, 0.36, 1) ${rowIndex * 0.05}s both`,
                                            }}
                                        >
                                            <td className="whitespace-nowrap px-3 py-2.5 font-medium">
                                                #{row.drawNumber}
                                                <span className="mt-0.5 block text-[0.65rem] font-normal text-[var(--lotto-muted-soft)]">
                                                    {t('algorithms.timeColumnHint')}
                                                </span>
                                            </td>
                                            <td className="whitespace-nowrap px-3 py-2.5 text-[var(--lotto-muted)]">
                                                {formatDate(row.drawDate, locale)}
                                            </td>
                                            <td className="px-3 py-2.5 text-center">
                                                <RootChip value={row.dateRoot} hot={row.matched} />
                                            </td>
                                            <td className="px-3 py-2.5 text-center">
                                                <RootChip value={row.timeRoot} hot={row.matched} />
                                            </td>
                                            <td className="px-3 py-2.5 text-center">
                                                {row.matched ? (
                                                    <StatusPill tone="strong">
                                                        {t('algorithms.matched')}
                                                    </StatusPill>
                                                ) : (
                                                    <span className="text-xs text-[var(--lotto-muted-soft)]">
                                                        {t('algorithms.skipped')}
                                                    </span>
                                                )}
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </section>

                    <section className="space-y-3">
                        <div className="flex items-center justify-between gap-2">
                            <h3 className="text-sm font-semibold tracking-tight">
                                {t('algorithms.columnThinkTitle', {
                                    column: safeColumnIndex + 1,
                                })}
                            </h3>
                            <div className="flex flex-wrap gap-1.5">
                                {mainColumns.map((col) => (
                                    <button
                                        key={`d-${col.columnIndex}`}
                                        type="button"
                                        onClick={() => setActiveColumn(col.columnIndex)}
                                        className={`rounded-full px-2.5 py-1 text-xs font-semibold transition ${
                                            safeColumnIndex === col.columnIndex
                                                ? 'bg-[var(--lotto-fg)] text-white'
                                                : 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-muted)]'
                                        }`}
                                    >
                                        D{col.columnIndex + 1}
                                    </button>
                                ))}
                            </div>
                        </div>

                        <div className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/60 p-4">
                            <QuietText className="!text-xs">
                                {result.keyRoot == null
                                    ? t('algorithms.columnThinkHintKeyEmpty')
                                    : t('algorithms.columnThinkHintKeyMode', {
                                          root: result.keyRoot,
                                          kept: active.eligibleValues.length,
                                          total: active.columnValues.filter((v) => v > 0).length,
                                      })}
                            </QuietText>

                            <RootExampleStrip
                                values={active.columnValues}
                                keyRoot={result.keyRoot}
                            />

                            <ul className="mt-4 space-y-2.5">
                                {active.frequencies.slice(0, 6).map((freq, index) => {
                                    const isWinner = freq.digit === active.pickedDigit;
                                    const width = `${Math.max(8, Math.round(freq.share * 100))}%`;
                                    return (
                                        <li key={freq.digit} className="space-y-1">
                                            <div className="flex items-center justify-between text-xs">
                                                <span className="font-semibold">
                                                    {freq.digit}
                                                    <span className="ml-1.5 font-normal text-[var(--lotto-muted)]">
                                                        (DR {digitalRootOfNumber(freq.digit)})
                                                    </span>
                                                    {isWinner ? (
                                                        <span className="ml-2 text-[var(--lotto-delta)]">
                                                            ← {t('algorithms.picked')}
                                                        </span>
                                                    ) : null}
                                                </span>
                                                <span className="text-[var(--lotto-muted)]">
                                                    {t('algorithms.times', { count: freq.count })}
                                                </span>
                                            </div>
                                            <div className="h-2.5 overflow-hidden rounded-full bg-[var(--lotto-border)]">
                                                <div
                                                    className={`h-full rounded-full ${
                                                        isWinner
                                                            ? 'bg-[var(--lotto-strong)]'
                                                            : index === 0
                                                              ? 'bg-[var(--lotto-excellent)]'
                                                              : 'bg-[var(--lotto-fg)]/35'
                                                    }`}
                                                    style={{
                                                        width,
                                                        animation: `lotto-rise 0.5s cubic-bezier(0.22, 1, 0.36, 1) ${index * 0.05}s both`,
                                                    }}
                                                />
                                            </div>
                                        </li>
                                    );
                                })}
                                {active.frequencies.length === 0 ? (
                                    <li className="text-sm text-[var(--lotto-muted)]">
                                        {t('algorithms.noEligibleDigits')}
                                    </li>
                                ) : null}
                            </ul>

                            <ColumnTrail columns={mainColumns} activeIndex={safeColumnIndex} />
                        </div>
                    </section>
                </div>

                <div className="rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-fg)] px-4 py-4 text-white sm:px-5">
                    <div className="flex flex-wrap items-center justify-between gap-3">
                        <div>
                            <p className="text-[0.7rem] font-medium uppercase tracking-[0.16em] text-white/55">
                                {t('algorithms.resultLabel')}
                            </p>
                            <p className="mt-1 text-lg font-semibold tracking-tight">
                                {t('algorithms.resultTitle', { type: t(`common.${lotteryType}`), n: 3 })}
                            </p>
                        </div>
                        <div className="flex items-center gap-2 text-xs text-white/60">
                            <span>{t('algorithms.stepKeyFilterTitle')}</span>
                            <AppIcon icon={ArrowRight} size={14} className="text-white/60" />
                            <span>{t('algorithms.favoriteN', { n: 3 })}</span>
                        </div>
                    </div>
                    <div className="mt-4 flex flex-wrap items-center gap-2">
                        {result.winningNumbers.map((n, i) => (
                            <NumberBall key={`res2-m-${i}`} value={n || '·'} tone="ink" size="lg" />
                        ))}
                        <span className="mx-1 hidden h-8 w-px bg-white/20 sm:inline-block" aria-hidden />
                        {result.bonusNumbers.map((n, i) => (
                            <NumberBall
                                key={`res2-b-${i}`}
                                value={n || '·'}
                                tone="excellent"
                                size="lg"
                            />
                        ))}
                    </div>
                </div>
            </div>
        </BentoCard>
    );
}

function TriggerStep({
    icon,
    step,
    title,
    body,
}: {
    icon: typeof Sparkles;
    step: string;
    title: string;
    body: string;
}) {
    return (
        <div className="rounded-[var(--lotto-radius-sm)] border border-black/5 bg-white/70 p-3 backdrop-blur-sm">
            <div className="flex items-center gap-2">
                <span className="inline-flex h-7 w-7 items-center justify-center rounded-full bg-[var(--lotto-fg)] text-[0.65rem] font-semibold text-white">
                    {step}
                </span>
                <AppIcon icon={icon} size={16} />
                <p className="text-sm font-semibold tracking-tight">{title}</p>
            </div>
            <p className="mt-2 text-xs leading-relaxed text-[var(--lotto-muted)]">{body}</p>
        </div>
    );
}

function RootChip({ value, hot }: { value: number; hot?: boolean }) {
    return (
        <span
            className={`inline-flex h-8 w-8 items-center justify-center rounded-full text-xs font-semibold ${
                hot
                    ? 'bg-[var(--lotto-strong)] text-white'
                    : 'bg-zinc-100 text-zinc-700 ring-1 ring-zinc-300/70'
            }`}
        >
            {value || '·'}
        </span>
    );
}

function RootExampleStrip({
    values,
    keyRoot,
}: {
    values: number[];
    keyRoot: number | null;
}) {
    const { t } = useI18n();
    const sample = values.filter((v) => v > 0).slice(-8);
    if (sample.length === 0 || keyRoot == null) return null;

    return (
        <div className="mt-3 flex flex-wrap gap-1.5">
            {sample.map((v, i) => {
                const root = digitalRootOfNumber(v);
                const keep = root === keyRoot;
                return (
                    <span
                        key={`${v}-${i}`}
                        title={`${v} → DR ${root}`}
                        className={`inline-flex items-center gap-1 rounded-full px-2 py-1 text-[0.7rem] font-medium ${
                            keep
                                ? 'bg-[var(--lotto-strong-soft)] text-[var(--lotto-delta)]'
                                : 'bg-white text-[var(--lotto-muted)] line-through opacity-60 ring-1 ring-[var(--lotto-border)]'
                        }`}
                    >
                        {v}
                        <span className="opacity-70">→{root}</span>
                        {keep ? null : (
                            <span className="sr-only">{t('algorithms.filteredOut')}</span>
                        )}
                    </span>
                );
            })}
        </div>
    );
}

function ColumnTrail({
    columns,
    activeIndex,
}: {
    columns: FavoriteTwoColumnTrace[];
    activeIndex: number;
}) {
    const { t } = useI18n();
    return (
        <div className="mt-5 border-t border-[var(--lotto-border)] pt-4">
            <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                {t('algorithms.trailLabel', { n: 3 })}
            </p>
            <div className="mt-2.5 flex flex-wrap gap-1.5">
                {columns.map((col) => (
                    <span
                        key={`trail2-${col.columnIndex}`}
                        className={`inline-flex min-w-9 items-center justify-center rounded-full px-2.5 py-1 text-xs font-semibold ${
                            col.columnIndex === activeIndex
                                ? 'bg-[var(--lotto-fg)] text-white'
                                : 'bg-white text-[var(--lotto-fg)] ring-1 ring-[var(--lotto-border)]'
                        }`}
                    >
                        {col.pickedDigit || '·'}
                    </span>
                ))}
            </div>
        </div>
    );
}

function formatDate(iso: string, locale: string): string {
    if (!iso) return '—';
    try {
        return new Intl.DateTimeFormat(locale, { dateStyle: 'medium' }).format(new Date(iso));
    } catch {
        return iso;
    }
}
