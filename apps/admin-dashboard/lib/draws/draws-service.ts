import type { Draw, DrawCreateInput, LotteryType } from '@repo/types';
import type { SupabaseClient } from '@supabase/supabase-js';
import { mapDrawRow, normalizeDrawNumber, toDrawInsert, type DrawRow } from '@/lib/draws/map';
import { maybeAutoNotifyOnPublish } from '@/lib/notifications';

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

export async function listDraws(
    client: SupabaseClient,
    filters: DrawListFilters = {},
): Promise<Draw[]> {
    let query = client.from('draws').select('*').order('draw_date', { ascending: false });

    if (filters.lotteryType && filters.lotteryType !== 'all') {
        query = query.eq('lottery_type', filters.lotteryType);
    }
    if (filters.published === 'published') {
        query = query.eq('is_published', true);
    } else if (filters.published === 'draft') {
        query = query.eq('is_published', false);
    }

    const { data, error } = await query;
    if (error) throw error;
    let rows = (data as DrawRow[]).map(mapDrawRow);

    const q = filters.search?.trim().toLowerCase();
    if (q) {
        rows = rows.filter(
            (d) =>
                d.drawNumber.toLowerCase().includes(q) ||
                d.drawDate.toLowerCase().includes(q) ||
                (d.prizeInfo ?? '').toLowerCase().includes(q),
        );
    }

    return rows;
}

export async function getDrawOverview(client: SupabaseClient) {
    const { data, error } = await client
        .from('draws')
        .select('*')
        .order('updated_at', { ascending: false });
    if (error) throw error;
    const draws = (data as DrawRow[]).map(mapDrawRow);
    const lotto6 = draws.filter((d) => d.lotteryType === 'lotto6');
    const lotto7 = draws.filter((d) => d.lotteryType === 'lotto7');
    const published = draws.filter((d) => d.isPublished);
    return {
        total: draws.length,
        lotto6Count: lotto6.length,
        lotto7Count: lotto7.length,
        publishedCount: published.length,
        draftCount: draws.length - published.length,
        latest: draws.slice(0, 8),
    };
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
    const { data, error } = await client
        .from('draws')
        .select('draw_number, draw_date')
        .eq('lottery_type', lotteryType);
    if (error) throw error;
    const map = new Map<string, { drawDate: string }>();
    for (const row of data ?? []) {
        const r = row as { draw_number: string; draw_date: string };
        map.set(normalizeDrawNumber(r.draw_number), { drawDate: r.draw_date });
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
): Promise<{ upserted: number }> {
    if (rows.length === 0) return { upserted: 0 };
    const payload = rows.map((r) => ({
        ...toDrawInsert(r),
        draw_number: normalizeDrawNumber(r.drawNumber),
    }));
    const { error, count } = await client.from('draws').upsert(payload, {
        onConflict: 'lottery_type,draw_number',
        count: 'exact',
    });
    if (error) throw error;

    const publishedByType = new Map<LotteryType, string>();
    for (const row of rows) {
        if (row.isPublished && !publishedByType.has(row.lotteryType)) {
            publishedByType.set(row.lotteryType, normalizeDrawNumber(row.drawNumber));
        }
    }
    for (const [lotteryType, drawNumber] of publishedByType) {
        await quietAutoNotify(client, lotteryType, drawNumber);
    }
    return { upserted: count ?? payload.length };
}
