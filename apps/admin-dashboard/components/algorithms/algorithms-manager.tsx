'use client';

import { useCallback, useEffect, useState } from 'react';
import { Sparkles } from 'lucide-react';
import type { LotteryType } from '@repo/types';
import { FavoriteOneThinking } from '@/components/algorithms/favorite-one-thinking';
import { FavoriteFourThinking } from '@/components/algorithms/favorite-four-thinking';
import { FavoriteTwoThinking } from '@/components/algorithms/favorite-two-thinking';
import { FavoriteThreeThinking } from '@/components/algorithms/favorite-three-thinking';
import {
    BentoCard,
    CardLabel,
    NumberBall,
    QuietText,
    StatusPill,
} from '@/components/bento/primitives';
import { useI18n } from '@/components/i18n/locale-provider';
import { PageHeader } from '@/components/layout/page-header';
import { UnderlineTabs } from '@/components/layout/underline-tabs';
import { AppIcon } from '@/components/ui/icon';
import type { FavoriteOneResult } from '@/lib/algorithms/favorite-one';
import type { FavoriteFourResult } from '@/lib/algorithms/favorite-four';
import type { FavoriteTwoResult } from '@/lib/algorithms/favorite-two';
import type { FavoriteThreeResult } from '@/lib/algorithms/favorite-three';
import {
    FAVORITES_PER_TYPE,
    generateAndPublishAllFavorites,
    isSlotReady,
    listAllFavoriteSlots,
    loadPublishedFavorites,
    publishedKey,
    publishFavoriteSlot,
    unpublishFavoriteSlot,
    type FavoriteSlot,
    type PublishedFavorite,
} from '@/lib/algorithms/recommendations-service';
import { createClient } from '@/lib/supabase/client';

type ThinkingTab = 'favorite1' | 'favorite2' | 'favorite3' | 'favorite4';

const hasNumbers = isSlotReady;

function formatGeneratedAt(iso: string | null, locale: string): string | null {
    if (!iso) return null;
    try {
        return new Intl.DateTimeFormat(locale, {
            dateStyle: 'medium',
            timeStyle: 'short',
        }).format(new Date(iso));
    } catch {
        return iso;
    }
}

export function AlgorithmsManager() {
    const { t, locale } = useI18n();
    const [tab, setTab] = useState<ThinkingTab>('favorite1');
    const [lotto6, setLotto6] = useState<FavoriteSlot[]>([]);
    const [lotto7, setLotto7] = useState<FavoriteSlot[]>([]);
    const [thinkingOne, setThinkingOne] = useState<{
        lotto6: FavoriteOneResult;
        lotto7: FavoriteOneResult;
    } | null>(null);
    const [thinkingTwo, setThinkingTwo] = useState<{
        lotto6: FavoriteTwoResult;
        lotto7: FavoriteTwoResult;
    } | null>(null);
    const [thinkingThree, setThinkingThree] = useState<{
        lotto6: FavoriteThreeResult;
        lotto7: FavoriteThreeResult;
    } | null>(null);
    const [thinkingFour, setThinkingFour] = useState<{
        lotto6: FavoriteFourResult;
        lotto7: FavoriteFourResult;
    } | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [published, setPublished] = useState<Map<string, PublishedFavorite>>(
        () => new Map(),
    );
    const [busyKey, setBusyKey] = useState<string | null>(null);
    const [generating, setGenerating] = useState(false);
    // View-only: display favorite numbers low to high. Off by default —
    // stored/published order is never modified.
    const [sortAscending, setSortAscending] = useState(false);
    const [notice, setNotice] = useState<{ text: string; error: boolean } | null>(
        null,
    );

    const reload = useCallback(async () => {
        setLoading(true);
        setError(null);
        try {
            let client = null;
            try {
                client = createClient();
            } catch {
                client = null;
            }
            const data = await listAllFavoriteSlots(client);
            setLotto6(data.lotto6);
            setLotto7(data.lotto7);
            setThinkingOne(data.thinkingOne);
            setThinkingTwo(data.thinkingTwo);
            setThinkingThree(data.thinkingThree);
            setThinkingFour(data.thinkingFour);
            if (client) {
                try {
                    setPublished(await loadPublishedFavorites(client));
                } catch {
                    setPublished(new Map());
                }
            } else {
                setPublished(new Map());
            }
        } catch (err) {
            setError(err instanceof Error ? err.message : t('algorithms.loadFailed'));
        } finally {
            setLoading(false);
        }
    }, [t]);

    useEffect(() => {
        void reload();
    }, [reload]);

    const onTogglePublish = useCallback(
        async (slot: FavoriteSlot) => {
            if (!slot.algorithmName) return;
            const key = publishedKey(slot.lotteryType, slot.algorithmName);
            setBusyKey(key);
            setNotice(null);
            try {
                const client = createClient();
                if (published.has(key)) {
                    await unpublishFavoriteSlot(client, slot);
                    setNotice({ text: t('algorithms.unpublishedOk'), error: false });
                } else {
                    await publishFavoriteSlot(client, slot);
                    setNotice({ text: t('algorithms.publishedOk'), error: false });
                }
                setPublished(await loadPublishedFavorites(client));
            } catch (err) {
                setNotice({
                    text: err instanceof Error ? err.message : t('algorithms.publishFailed'),
                    error: true,
                });
            } finally {
                setBusyKey(null);
            }
        },
        [published, t],
    );

    /**
     * One-click path: recompute every slot from the latest draws and save them
     * all to Supabase. Existing published rows are replaced, so pressing this
     * again is how you regenerate.
     */
    const onGenerate = useCallback(async () => {
        setGenerating(true);
        setNotice(null);
        try {
            const client = createClient();
            const { published: count, skipped, data } = await generateAndPublishAllFavorites(
                client,
            );
            setLotto6(data.lotto6);
            setLotto7(data.lotto7);
            setThinkingOne(data.thinkingOne);
            setThinkingTwo(data.thinkingTwo);
            setThinkingThree(data.thinkingThree);
            setThinkingFour(data.thinkingFour);
            setPublished(await loadPublishedFavorites(client));
            setNotice({
                text: skipped
                    ? t('algorithms.generatedOkSome', { count, skipped })
                    : t('algorithms.generatedOk', { count }),
                error: false,
            });
        } catch (err) {
            setNotice({
                text: err instanceof Error ? err.message : t('algorithms.generateFailed'),
                error: true,
            });
        } finally {
            setGenerating(false);
        }
    }, [t]);

    return (
        <div className="space-y-6 sm:space-y-8">
            <PageHeader
                crumbs={[
                    { label: t('brand.lotto'), href: '/' },
                    { label: t('algorithms.crumbs') },
                ]}
                title={t('algorithms.title')}
                subtitle={t('algorithms.subtitle')}
                mark={<AppIcon icon={Sparkles} size={22} />}
            />

            <div className="flex flex-wrap items-center justify-between gap-3">
                <QuietText className="!text-sm">{t('algorithms.intro')}</QuietText>
                <div className="flex flex-wrap items-center gap-4">
                    <span className="inline-flex items-center gap-2 text-xs font-semibold tracking-tight text-[var(--lotto-muted)]">
                        <button
                            type="button"
                            role="switch"
                            aria-checked={sortAscending}
                            aria-label={t('algorithms.sortAscending')}
                            onClick={() => setSortAscending((v) => !v)}
                            className={`relative h-6 w-10 shrink-0 rounded-full transition-colors ${
                                sortAscending
                                    ? 'bg-[var(--lotto-fg)]'
                                    : 'bg-[var(--lotto-border-strong)]'
                            }`}
                        >
                            <span
                                className={`absolute top-0.5 left-0.5 h-5 w-5 rounded-full bg-white transition-transform ${
                                    sortAscending ? 'translate-x-4' : 'translate-x-0'
                                }`}
                            />
                        </button>
                        {t('algorithms.sortAscending')}
                    </span>
                    <button
                        type="button"
                        disabled={generating || loading}
                        onClick={() => void onGenerate()}
                        className="inline-flex items-center gap-2 rounded-full bg-[var(--lotto-fg)] px-4 py-2 text-xs font-semibold tracking-tight text-white transition-opacity hover:opacity-90 disabled:opacity-50"
                    >
                        <Sparkles size={14} aria-hidden />
                        {generating ? t('algorithms.generating') : t('algorithms.generate')}
                    </button>
                </div>
            </div>

            {error ? <p className="text-sm text-[#b42318]">{error}</p> : null}

            {notice ? (
                <StatusPill tone={notice.error ? 'caution' : 'excellent'}>
                    {notice.text}
                </StatusPill>
            ) : null}

            {loading ? (
                <p className="text-sm text-[var(--lotto-muted)]">{t('common.loading')}</p>
            ) : (
                <>
                    {/* Tabs are keyed by slot number and ordered 1→4, so the tab label
                        always matches the "Favorite N" heading inside the panel.
                        slot → algorithm: 1=7d mode, 2=7d rarest, 3=key mode, 4=key rarest. */}
                    <UnderlineTabs
                        tabs={[
                            { id: 'favorite1', label: t('algorithms.tabFavorite1') },
                            { id: 'favorite2', label: t('algorithms.tabFavorite2') },
                            { id: 'favorite3', label: t('algorithms.tabFavorite3') },
                            { id: 'favorite4', label: t('algorithms.tabFavorite4') },
                        ]}
                        value={tab}
                        onChange={setTab}
                    />

                    {tab === 'favorite1' && thinkingOne ? (
                        <FavoriteOneThinking
                            lotto6={thinkingOne.lotto6}
                            lotto7={thinkingOne.lotto7}
                        />
                    ) : null}

                    {tab === 'favorite2' && thinkingFour ? (
                        <FavoriteFourThinking
                            lotto6={thinkingFour.lotto6}
                            lotto7={thinkingFour.lotto7}
                        />
                    ) : null}

                    {tab === 'favorite3' && thinkingTwo ? (
                        <FavoriteTwoThinking
                            lotto6={thinkingTwo.lotto6}
                            lotto7={thinkingTwo.lotto7}
                        />
                    ) : null}

                    {tab === 'favorite4' && thinkingThree ? (
                        <FavoriteThreeThinking
                            lotto6={thinkingThree.lotto6}
                            lotto7={thinkingThree.lotto7}
                        />
                    ) : null}

                    <div className="grid gap-5 lg:grid-cols-2">
                        <FavoritesBoard
                            lotteryType="lotto6"
                            slots={lotto6}
                            locale={locale}
                            published={published}
                            busyKey={busyKey}
                            sortAscending={sortAscending}
                            onTogglePublish={(slot) => void onTogglePublish(slot)}
                        />
                        <FavoritesBoard
                            lotteryType="lotto7"
                            slots={lotto7}
                            locale={locale}
                            published={published}
                            busyKey={busyKey}
                            sortAscending={sortAscending}
                            onTogglePublish={(slot) => void onTogglePublish(slot)}
                        />
                    </div>
                </>
            )}
        </div>
    );
}

function FavoritesBoard({
    lotteryType,
    slots,
    locale,
    published,
    busyKey,
    sortAscending,
    onTogglePublish,
}: {
    lotteryType: LotteryType;
    slots: FavoriteSlot[];
    locale: string;
    published: Map<string, PublishedFavorite>;
    busyKey: string | null;
    sortAscending: boolean;
    onTogglePublish: (slot: FavoriteSlot) => void;
}) {
    const { t } = useI18n();
    const readyCount = slots.filter(hasNumbers).length;

    return (
        <BentoCard className="!p-4 sm:!p-5" tone="surface">
            <div className="flex flex-wrap items-start justify-between gap-3">
                <div>
                    <CardLabel>{t('algorithms.systemPicksLabel')}</CardLabel>
                    <h2 className="mt-1 text-xl font-semibold tracking-[-0.02em]">
                        {t(`common.${lotteryType}`)}
                    </h2>
                    <QuietText className="!mt-1 !text-sm">
                        {t('algorithms.slotsHint', { count: FAVORITES_PER_TYPE })}
                    </QuietText>
                </div>
                <StatusPill tone={readyCount > 0 ? 'strong' : 'neutral'}>
                    {t('algorithms.readyCount', { count: readyCount })}
                </StatusPill>
            </div>

            <ol className="mt-5 space-y-3">
                {slots.map((slot) => (
                    <FavoriteTicket
                        key={`${lotteryType}-${slot.slot}`}
                        slot={slot}
                        locale={locale}
                        published={published}
                        busyKey={busyKey}
                        sortAscending={sortAscending}
                        onTogglePublish={onTogglePublish}
                    />
                ))}
            </ol>
        </BentoCard>
    );
}

function FavoriteTicket({
    slot,
    locale,
    published,
    busyKey,
    sortAscending,
    onTogglePublish,
}: {
    slot: FavoriteSlot;
    locale: string;
    published: Map<string, PublishedFavorite>;
    busyKey: string | null;
    sortAscending: boolean;
    onTogglePublish: (slot: FavoriteSlot) => void;
}) {
    const { t } = useI18n();
    const ready = hasNumbers(slot);
    // View-only ascending order — copies, never the stored arrays.
    const mains = sortAscending
        ? [...slot.winningNumbers].sort((a, b) => a - b)
        : slot.winningNumbers;
    const bonus = sortAscending
        ? [...slot.bonusNumbers].sort((a, b) => a - b)
        : slot.bonusNumbers;
    // Live DB state — not the computed flag. Publishing snapshots the
    // current mains + bonus to `recommendations` for the mobile app.
    const live = slot.algorithmName
        ? published.get(publishedKey(slot.lotteryType, slot.algorithmName))
        : undefined;
    const generated = formatGeneratedAt(live?.generatedAt ?? slot.generatedAt, locale);
    const busy = busyKey === (slot.algorithmName ? publishedKey(slot.lotteryType, slot.algorithmName) : null);

    return (
        <li className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)]/50 px-3 py-3.5 sm:px-4 sm:py-4">
            <div className="flex flex-wrap items-center justify-between gap-2">
                <div className="flex items-center gap-2.5">
                    <span
                        className="inline-flex h-8 w-8 items-center justify-center rounded-full bg-[var(--lotto-fg)] text-sm font-semibold text-white"
                        aria-hidden
                    >
                        {slot.slot}
                    </span>
                    <div>
                        <p className="text-sm font-semibold tracking-tight">
                            {t('algorithms.favoriteN', { n: slot.slot })}
                        </p>
                        {slot.algorithmName ? (
                            <p className="text-xs text-[var(--lotto-muted)]">{slot.algorithmName}</p>
                        ) : null}
                    </div>
                </div>
                {ready ? (
                    <StatusPill tone={live ? 'excellent' : 'neutral'}>
                        {live ? t('common.published') : t('common.draft')}
                    </StatusPill>
                ) : (
                    <StatusPill tone="caution">{t('algorithms.awaitingPick')}</StatusPill>
                )}
            </div>

            {ready ? (
                <>
                    <div className="mt-3.5 flex flex-wrap items-center gap-1.5 sm:gap-2">
                        {mains.map((n, i) => (
                            <NumberBall
                                key={`${slot.lotteryType}-${slot.slot}-m-${n}-${i}`}
                                value={n}
                                tone="ink"
                                size="lg"
                            />
                        ))}
                        <span
                            className="mx-0.5 hidden h-6 w-px bg-[var(--lotto-border-strong)] sm:inline-block"
                            aria-hidden
                        />
                        {bonus.map((n, i) => (
                            <NumberBall
                                key={`${slot.lotteryType}-${slot.slot}-b-${n}-${i}`}
                                value={n}
                                tone="excellent"
                                size="lg"
                            />
                        ))}
                    </div>
                    {generated ? (
                        <p className="mt-3 text-xs text-[var(--lotto-muted-soft)]">
                            {t('algorithms.generatedAt', { when: generated })}
                        </p>
                    ) : null}
                    <div className="mt-3">
                        <button
                            type="button"
                            disabled={busy}
                            onClick={() => onTogglePublish(slot)}
                            className="rounded-full border border-[var(--lotto-border)] px-3.5 py-1.5 text-xs font-semibold tracking-tight hover:bg-[var(--lotto-surface-muted)] disabled:opacity-50"
                        >
                            {busy
                                ? t('algorithms.publishing')
                                : live
                                  ? t('common.unpublish')
                                  : t('common.publish')}
                        </button>
                    </div>
                </>
            ) : (
                <p className="mt-3 text-sm text-[var(--lotto-muted)]">
                    {t('algorithms.emptySlotHint')}
                </p>
            )}
        </li>
    );
}
