'use client';

import { useMemo, useState } from 'react';
import { ArrowRight, Database, Sparkles, Upload } from 'lucide-react';
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
import {
    FAVORITE_FOUR_MAX_WINDOW,
    FAVORITE_FOUR_MIN_WINDOW,
    type FavoriteFourResult,
} from '@/lib/algorithms/favorite-four';
import type { ColumnPickTrace } from '@/lib/algorithms/favorite-one';

type Props = {
    lotto6: FavoriteFourResult;
    lotto7: FavoriteFourResult;
};

export function FavoriteFourThinking({ lotto6, lotto7 }: Props) {
    const { t, locale } = useI18n();
    const [lotteryType, setLotteryType] = useState<LotteryType>('lotto6');
    const [activeColumn, setActiveColumn] = useState(0);

    const result = lotteryType === 'lotto6' ? lotto6 : lotto7;
    const mainColumns = result.columns.filter((c) => c.kind === 'main');
    const bonusColumns = result.columns.filter((c) => c.kind === 'bonus');
    const safeColumnIndex = Math.min(activeColumn, Math.max(0, mainColumns.length - 1));
    const active = mainColumns[safeColumnIndex] ?? mainColumns[0]!;

    const chronological = useMemo(() => [...result.rows].reverse(), [result.rows]);

    const triggerLabel =
        result.triggeredBy === 'import'
            ? t('algorithms.triggerImport')
            : result.triggeredBy === 'draw'
              ? t('algorithms.triggerDraw')
              : t('algorithms.triggerDemo');

    return (
        <BentoCard className="!gap-0 overflow-hidden !p-0" tone="surface">
            <div className="border-b border-[var(--lotto-border)] bg-[linear-gradient(135deg,var(--lotto-bg-soft)_0%,var(--lotto-strong-soft)_48%,var(--lotto-excellent-soft)_100%)] px-4 py-5 sm:px-6 sm:py-6">
                <div className="flex flex-wrap items-start justify-between gap-3">
                    <div className="max-w-2xl">
                        <CardLabel className="!text-[var(--lotto-fg)]/70">
                            {t('algorithms.thinkingLabel', { n: 2 })}
                        </CardLabel>
                        <h2 className="mt-1 text-2xl font-semibold tracking-[-0.03em] sm:text-3xl">
                            {t('algorithms.thinkingTitle7dRarest')}
                        </h2>
                        <QuietText className="!mt-2 !text-sm !text-[var(--lotto-fg)]/75">
                            {t('algorithms.thinkingBody7dRarest')}
                        </QuietText>
                    </div>
                    <StatusPill tone="strong">{triggerLabel}</StatusPill>
                </div>

                <div className="mt-5 grid gap-2 sm:grid-cols-3">
                    <TriggerStep
                        icon={Database}
                        step="01"
                        title={t('algorithms.stepTriggerTitle')}
                        body={t('algorithms.stepTriggerBody')}
                    />
                    <TriggerStep
                        icon={Upload}
                        step="02"
                        title={t('algorithms.stepWindowTitle')}
                        body={t('algorithms.stepWindowBody', {
                            count: `${FAVORITE_FOUR_MIN_WINDOW}–${FAVORITE_FOUR_MAX_WINDOW}`,
                        })}
                    />
                    <TriggerStep
                        icon={Sparkles}
                        step="03"
                        title={t('algorithms.step7dRarestTitle')}
                        body={t('algorithms.step7dRarestBody')}
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
                        {t('algorithms.windowMeta', {
                            count: result.windowSize,
                            date: formatDate(result.latestDate, locale),
                        })}
                    </p>
                </div>

                <WindowLockPanel result={result} />

                <div className="grid gap-5 xl:grid-cols-[minmax(0,1.35fr)_minmax(0,1fr)]">
                    <section className="space-y-3">
                        <div className="flex items-center justify-between gap-2">
                            <h3 className="text-sm font-semibold tracking-tight">
                                {t('algorithms.windowMatrixTitle')}
                            </h3>
                            <QuietText className="!text-xs">
                                {t('algorithms.windowMatrixHint')}
                            </QuietText>
                        </div>

                        <div className="overflow-x-auto rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)]">
                            <table className="min-w-full border-collapse text-sm">
                                <thead>
                                    <tr className="bg-[var(--lotto-surface-muted)] text-left text-[0.7rem] uppercase tracking-[0.12em] text-[var(--lotto-muted-soft)]">
                                        <th className="px-3 py-2.5 font-medium">{t('algorithms.colDraw')}</th>
                                        <th className="px-3 py-2.5 font-medium">{t('algorithms.colDate')}</th>
                                        {mainColumns.map((col) => (
                                            <th key={`h-m-${col.columnIndex}`} className="px-1.5 py-2.5 text-center font-medium">
                                                <button
                                                    type="button"
                                                    onClick={() => setActiveColumn(col.columnIndex)}
                                                    className={`inline-flex min-w-8 items-center justify-center rounded-full px-2 py-1 transition ${
                                                        safeColumnIndex === col.columnIndex
                                                            ? 'bg-[var(--lotto-fg)] text-white'
                                                            : 'hover:bg-[var(--lotto-accent-soft)]'
                                                    }`}
                                                >
                                                    D{col.columnIndex + 1}
                                                </button>
                                            </th>
                                        ))}
                                        {bonusColumns.map((col) => (
                                            <th
                                                key={`h-b-${col.columnIndex}`}
                                                className="px-1.5 py-2.5 text-center font-medium text-[var(--lotto-excellent)]"
                                            >
                                                B{col.columnIndex + 1}
                                            </th>
                                        ))}
                                    </tr>
                                </thead>
                                <tbody>
                                    {chronological.map((row, rowIndex) => (
                                        <tr
                                            key={`${row.drawNumber}-${row.drawDate}`}
                                            className="border-t border-[var(--lotto-border)]"
                                            style={{
                                                animation: `lotto-rise 0.45s cubic-bezier(0.22, 1, 0.36, 1) ${rowIndex * 0.04}s both`,
                                            }}
                                        >
                                            <td className="whitespace-nowrap px-3 py-2.5 font-medium">
                                                #{row.drawNumber}
                                            </td>
                                            <td className="whitespace-nowrap px-3 py-2.5 text-[var(--lotto-muted)]">
                                                {formatDate(row.drawDate, locale)}
                                            </td>
                                            {mainColumns.map((col) => {
                                                const value = row.winningNumbers[col.columnIndex] ?? 0;
                                                const isMode = value === col.modeDigit;
                                                const isActive = safeColumnIndex === col.columnIndex;
                                                return (
                                                    <td
                                                        key={`c-m-${row.drawNumber}-${col.columnIndex}`}
                                                        className="px-1.5 py-2 text-center"
                                                    >
                                                        <span
                                                            className={`inline-flex h-8 w-8 items-center justify-center rounded-full text-xs font-semibold transition ${
                                                                isMode && isActive
                                                                    ? 'bg-[var(--lotto-strong)] text-white ring-2 ring-[var(--lotto-strong)]/40'
                                                                    : isMode
                                                                      ? 'bg-[var(--lotto-strong-soft)] text-[var(--lotto-delta)]'
                                                                      : isActive
                                                                        ? 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]'
                                                                        : 'bg-zinc-100 text-zinc-700'
                                                            }`}
                                                        >
                                                            {value || '·'}
                                                        </span>
                                                    </td>
                                                );
                                            })}
                                            {bonusColumns.map((col) => {
                                                const value = row.bonusNumbers[col.columnIndex] ?? 0;
                                                const isMode = value === col.modeDigit;
                                                return (
                                                    <td
                                                        key={`c-b-${row.drawNumber}-${col.columnIndex}`}
                                                        className="px-1.5 py-2 text-center"
                                                    >
                                                        <span
                                                            className={`inline-flex h-8 w-8 items-center justify-center rounded-full text-xs font-semibold ${
                                                                isMode
                                                                    ? 'bg-[var(--lotto-excellent)] text-[var(--lotto-fg)]'
                                                                    : 'bg-[var(--lotto-excellent-soft)]/60 text-[var(--lotto-fg)]'
                                                            }`}
                                                        >
                                                            {value || '·'}
                                                        </span>
                                                    </td>
                                                );
                                            })}
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
                            <StatusPill tone={active.usedFallback ? 'caution' : 'excellent'}>
                                {active.usedFallback
                                    ? t('algorithms.fallbackUsed')
                                    : t('algorithms.rareWinner')}
                            </StatusPill>
                        </div>

                        <div className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/60 p-4">
                            <QuietText className="!text-xs">
                                {t('algorithms.columnThinkHint7dRarest', {
                                    digit: active.modeDigit,
                                    count:
                                        active.frequencies.find((f) => f.digit === active.modeDigit)
                                            ?.count ?? 0,
                                })}
                            </QuietText>

                            <ul className="mt-4 space-y-2.5">
                                {active.frequencies.slice(0, 6).map((freq, index) => {
                                    const isWinner = freq.digit === active.pickedDigit;
                                    const width = `${Math.max(8, Math.round(freq.share * 100))}%`;
                                    return (
                                        <li key={freq.digit} className="space-y-1">
                                            <div className="flex items-center justify-between text-xs">
                                                <span className="font-semibold">
                                                    {freq.digit}
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
                                                    className={`h-full rounded-full transition-all duration-500 ${
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
                                {t('algorithms.resultTitle', { type: t(`common.${lotteryType}`), n: 2 })}
                            </p>
                        </div>
                        <div className="flex items-center gap-2 text-xs text-white/60">
                            <span>{t('algorithms.step7dRarestTitle')}</span>
                            <AppIcon icon={ArrowRight} size={14} className="text-white/60" />
                            <span>{t('algorithms.favoriteN', { n: 2 })}</span>
                        </div>
                    </div>
                    <div className="mt-4 flex flex-wrap items-center gap-2">
                        {result.winningNumbers.map((n, i) => (
                            <NumberBall
                                key={`res-m-${i}`}
                                value={n}
                                tone="ink"
                                size="lg"
                            />
                        ))}
                        <span className="mx-1 hidden h-8 w-px bg-white/20 sm:inline-block" aria-hidden />
                        {result.bonusNumbers.map((n, i) => (
                            <NumberBall
                                key={`res-b-${i}`}
                                value={n}
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

function WindowLockPanel({ result }: { result: FavoriteFourResult }) {
    const { t } = useI18n();
    return (
        <section className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/60 p-4">
            <div className="flex flex-wrap items-center justify-between gap-2">
                <h3 className="text-sm font-semibold tracking-tight">
                    {t('algorithms.windowLockTitle', { row: result.windowSize })}
                </h3>
                {result.window.shortHistory ? (
                    <StatusPill tone="caution">
                        {t('algorithms.windowShortHistory', { count: result.windowSize })}
                    </StatusPill>
                ) : null}
            </div>
            <QuietText className="!mt-1.5 !text-xs">
                {t('algorithms.windowLockHint', { min: FAVORITE_FOUR_MIN_WINDOW })}
            </QuietText>
            <ul className="mt-3 flex flex-wrap gap-1.5">
                {result.window.columns.map((col) => (
                    <li
                        key={col.name}
                        className="inline-flex items-center gap-1.5 rounded-full bg-white px-2.5 py-1 text-xs ring-1 ring-[var(--lotto-border)]"
                    >
                        <span className="font-semibold">{col.name}</span>
                        <span className="text-[var(--lotto-muted-soft)]">r{col.lockRow}</span>
                        {col.exhausted ? (
                            <span className="text-[var(--lotto-muted-soft)]">
                                · {t('algorithms.windowLockExhausted')}
                            </span>
                        ) : null}
                        {col.earlyRepeats.length > 0 ? (
                            <span className="text-[var(--lotto-muted-soft)]">
                                ·{' '}
                                {t('algorithms.windowLockSkipped', {
                                    rows: col.earlyRepeats.map((r) => r.row).join(', '),
                                })}
                            </span>
                        ) : null}
                    </li>
                ))}
            </ul>
        </section>
    );
}

function TriggerStep({
    icon,
    step,
    title,
    body,
}: {
    icon: typeof Database;
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

function ColumnTrail({
    columns,
    activeIndex,
}: {
    columns: ColumnPickTrace[];
    activeIndex: number;
}) {
    const { t } = useI18n();
    return (
        <div className="mt-5 border-t border-[var(--lotto-border)] pt-4">
            <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                {t('algorithms.trailLabel', { n: 2 })}
            </p>
            <div className="mt-2.5 flex flex-wrap gap-1.5">
                {columns.map((col) => (
                    <span
                        key={`trail-${col.columnIndex}`}
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
