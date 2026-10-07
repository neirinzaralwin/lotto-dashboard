import type { Draw, DrawCreateInput, LotteryType } from '@repo/types';
import type { SupabaseClient } from '@supabase/supabase-js';
import { mapDrawRow, normalizeDrawNumber, toDrawInsert, type DrawRow } from '@/lib/draws/map';
import { maybeAutoNotifyOnPublish } from '@/lib/notifications';

/** PostgREST/Supabase default max rows per request — page past it for full history. */
const DRAWS_PAGE_SIZE = 1000;

export type DrawListFilters = {
    lotteryType?: LotteryType | 'all';
    published?: 'all' | 'published' | 'draft';
    search?: string;
};

async function quietAutoNotify(
    client: SupabaseClient,
    lotteryType: LotteryType,
    drawNumber: string,
) {
    try {
        await maybeAutoNotifyOnPublish(client, lotteryType, drawNumber);
    } catch {
        /* non-blocking: publish succeeds even if push fails */
    }
}

async function fetchAllRows<T>(
    build: (
        from: number,
        to: number,
    ) => PromiseLike<{ data: T[] | null; error: { message: string } | null }>,
): Promise<T[]> {
    const all: T[] = [];
    let from = 0;
    for (;;) {
        const { data, error } = await build(from, from + DRAWS_PAGE_SIZE - 1);
        if (error) throw error;
        const batch = data ?? [];
        all.push(...batch);
        if (batch.length < DRAWS_PAGE_SIZE) break;
        from += DRAWS_PAGE_SIZE;
    }
    return all;
}

export async function listDraws(
    client: SupabaseClient,
    filters: DrawListFilters = {},
): Promise<Draw[]> {
    const rows = await fetchAllRows<DrawRow>(async (from, to) => {
        let query = client
            .from('draws')
            .select('*')
            .order('draw_date', { ascending: false })
            .range(from, to);

        if (filters.lotteryType && filters.lotteryType !== 'all') {
            query = query.eq('lottery_type', filters.lotteryType);
        }
        if (filters.published === 'published') {
            query = query.eq('is_published', true);
        } else if (filters.published === 'draft') {
            query = query.eq('is_published', false);
        }

        return query;
    });

    let mapped = rows.map(mapDrawRow);

    const q = filters.search?.trim().toLowerCase();
    if (q) {
        mapped = mapped.filter(
            (d) =>
                d.drawNumber.toLowerCase().includes(q) ||
                d.drawDate.toLowerCase().includes(q),
        );
    }

    return mapped;
}

export async function getDrawOverview(client: SupabaseClient) {
    const rows = await fetchAllRows<DrawRow>((from, to) =>
        client
            .from('draws')
            .select('*')
            .order('updated_at', { ascending: false })
            .range(from, to),
    );
    const draws = rows.map(mapDrawRow);
    const lotto6 = draws.filter((d) => d.lotteryType === 'lotto6');
    const lotto7 = draws.filter((d) => d.lotteryType === 'lotto7');
    const published = draws.filter((d) => d.isPublished);
    return {
        total: draws.length,
        lotto6Count: lotto6.length,
        lotto7Count: lotto7.length,
        publishedCount: published.length,
        draftCount: draws.length - published.length,
        latest: [pickLatestDraw(lotto6), pickLatestDraw(lotto7)].filter(
            (d): d is Draw => d !== null,
        ),
    };
}

/** True latest = highest numeric draw_number (fallback: newest draw_date). */
function pickLatestDraw(draws: Draw[]): Draw | null {
    if (draws.length === 0) return null;
    return [...draws].sort((a, b) => {
        const numDiff = parseDrawNumber(b.drawNumber) - parseDrawNumber(a.drawNumber);
        if (numDiff !== 0) return numDiff;
        return b.drawDate.localeCompare(a.drawDate);
    })[0]!;
}

function parseDrawNumber(raw: string): number {
    const match = raw.match(/(\d+)/);
    if (!match?.[1]) return Number.NEGATIVE_INFINITY;
    return Number.parseInt(match[1], 10);
}

export async function createDraw(client: SupabaseClient, input: DrawCreateInput): Promise<Draw> {
    const payload = {
        ...toDrawInsert(input),
        draw_number: normalizeDrawNumber(input.drawNumber),
    };
    const { data, error } = await client.from('draws').insert(payload).select('*').single();
    if (error) throw error;
    const draw = mapDrawRow(data as DrawRow);
    if (draw.isPublished) {
        await quietAutoNotify(client, draw.lotteryType, draw.drawNumber);
    }
    return draw;
}

export async function updateDraw(
    client: SupabaseClient,
    id: string,
    input: Partial<DrawCreateInput> & { isPublished?: boolean },
): Promise<Draw> {
    let wasPublished = false;
    if (input.isPublished === true) {
        const { data: before } = await client
            .from('draws')
            .select('is_published')
            .eq('id', id)
            .maybeSingle();
        wasPublished = Boolean((before as { is_published?: boolean } | null)?.is_published);
    }

    const patch: Record<string, unknown> = {};
    if (input.lotteryType !== undefined) patch.lottery_type = input.lotteryType;
    if (input.drawNumber !== undefined) patch.draw_number = normalizeDrawNumber(input.drawNumber);
    if (input.drawDate !== undefined) patch.draw_date = input.drawDate;
    if (input.winningNumbers !== undefined) patch.winning_numbers = input.winningNumbers;
    if (input.bonusNumbers !== undefined) patch.bonus_numbers = input.bonusNumbers;
    if (input.prizeInfo !== undefined) patch.prize_info = input.prizeInfo;
    if (input.isPublished !== undefined) patch.is_published = input.isPublished;

    const { data, error } = await client.from('draws').update(patch).eq('id', id).select('*').single();
    if (error) throw error;
    const draw = mapDrawRow(data as DrawRow);
    if (input.isPublished === true && !wasPublished && draw.isPublished) {
        await quietAutoNotify(client, draw.lotteryType, draw.drawNumber);
    }
    return draw;
}

export async function deleteDraw(client: SupabaseClient, id: string): Promise<void> {
    const { error } = await client.from('draws').delete().eq('id', id);
    if (error) throw error;
}

export async function setDrawPublished(
    client: SupabaseClient,
    id: string,
    isPublished: boolean,
): Promise<Draw> {
    return updateDraw(client, id, { isPublished });
}

export async function listExistingDrawKeys(
    client: SupabaseClient,
    lotteryType: LotteryType,
): Promise<Set<string>> {
    const summaries = await listExistingDrawSummaries(client, lotteryType);
    return new Set(summaries.keys());
}

/** Draw number → date for import conflict period visualization. */
export async function listExistingDrawSummaries(
    client: SupabaseClient,
    lotteryType: LotteryType,
): Promise<Map<string, { drawDate: string }>> {
    const rows = await fetchAllRows<{ draw_number: string; draw_date: string }>((from, to) =>
        client
            .from('draws')
            .select('draw_number, draw_date')
            .eq('lottery_type', lotteryType)
            .range(from, to),
    );
    const map = new Map<string, { drawDate: string }>();
    for (const row of rows) {
        map.set(normalizeDrawNumber(row.draw_number), { drawDate: row.draw_date });
    }
    return map;
}

export async function setDrawsPublished(
    client: SupabaseClient,
    ids: string[],
    isPublished: boolean,
): Promise<number> {
    if (ids.length === 0) return 0;
    const { data: before } = isPublished
        ? await client.from('draws').select('id, lottery_type, draw_number, is_published').in('id', ids)
        : { data: null };
    const { data, error } = await client
        .from('draws')
        .update({ is_published: isPublished })
        .in('id', ids)
        .select('id');
    if (error) throw error;

    if (isPublished && before) {
        const newlyPublished = (
            before as Array<{
                id: string;
                lottery_type: LotteryType;
                draw_number: string;
                is_published: boolean;
            }>
        ).filter((row) => !row.is_published);

        const byType = new Map<LotteryType, string>();
        for (const row of newlyPublished) {
            if (!byType.has(row.lottery_type)) {
                byType.set(row.lottery_type, row.draw_number);
            }
        }
        for (const [lotteryType, drawNumber] of byType) {
            await quietAutoNotify(client, lotteryType, drawNumber);
        }
    }
    return data?.length ?? 0;
}

export async function upsertDraws(
    client: SupabaseClient,
    rows: DrawCreateInput[],
    opts: { autoNotify?: boolean } = {},
): Promise<{ upserted: number }> {
    if (rows.length === 0) return { upserted: 0 };
    const payload = rows.map((r) => ({
        ...toDrawInsert(r),
        draw_number: normalizeDrawNumber(r.drawNumber),
    }));

    let upserted = 0;
    for (let i = 0; i < payload.length; i += DRAWS_PAGE_SIZE) {
        const chunk = payload.slice(i, i + DRAWS_PAGE_SIZE);
        const { error, count } = await client.from('draws').upsert(chunk, {
            onConflict: 'lottery_type,draw_number',
            count: 'exact',
        });
        if (error) throw error;
        upserted += count ?? chunk.length;
    }

    const publishedByType = new Map<LotteryType, string>();
    for (const row of rows) {
        if (row.isPublished && !publishedByType.has(row.lotteryType)) {
            publishedByType.set(row.lotteryType, normalizeDrawNumber(row.drawNumber));
        }
    }
    if (opts.autoNotify !== false) {
        for (const [lotteryType, drawNumber] of publishedByType) {
            await quietAutoNotify(client, lotteryType, drawNumber);
        }
    }
    return { upserted };
}
