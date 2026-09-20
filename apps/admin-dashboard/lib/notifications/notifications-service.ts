import type {
    NotificationDraftInput,
    NotificationSettings,
    NotificationTarget,
    PushNotificationRecord,
} from '@repo/types';
import type { SupabaseClient } from '@supabase/supabase-js';

export type { NotificationDraftInput };

export const NOTIFICATIONS_PAGE_SIZE = 20;

export const emptyNotificationDraft = (): NotificationDraftInput => ({
    title: '',
    body: '',
    target: 'all',
});

type NotificationRow = {
    id: string;
    title: string;
    body: string;
    target: NotificationTarget;
    status: 'draft' | 'sent';
    sent_at: string | null;
    created_at: string;
    updated_at: string;
};

type SettingsRow = {
    id: string;
    auto_notify_lotto6: boolean;
    auto_notify_lotto7: boolean;
    updated_at: string;
};

function mapRecord(row: NotificationRow): PushNotificationRecord {
    return {
        id: row.id,
        title: row.title,
        body: row.body,
        target: row.target,
        status: row.status,
        sentAt: row.sent_at,
        createdAt: row.created_at,
        updatedAt: row.updated_at,
    };
}

function mapSettings(row: SettingsRow): NotificationSettings {
    return {
        id: row.id,
        autoNotifyLotto6: row.auto_notify_lotto6,
        autoNotifyLotto7: row.auto_notify_lotto7,
        updatedAt: row.updated_at,
    };
}

export function formatNotificationWhen(iso?: string | null): string {
    if (!iso) return '—';
    const d = new Date(iso);
    return d.toLocaleString(undefined, {
        day: 'numeric',
        month: 'short',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    });
}

export async function listNotifications(
    client: SupabaseClient,
): Promise<PushNotificationRecord[]> {
    const { data, error } = await client
        .from('notification_records')
        .select('*')
        .order('updated_at', { ascending: false });
    if (error) throw error;
    return ((data ?? []) as NotificationRow[]).map(mapRecord);
}

export async function createNotification(
    client: SupabaseClient,
    input: NotificationDraftInput,
): Promise<PushNotificationRecord> {
    const { data, error } = await client
        .from('notification_records')
        .insert({
            title: input.title.trim(),
            body: input.body.trim(),
            target: input.target,
            status: 'draft',
        })
        .select('*')
        .single();
    if (error) throw error;
    return mapRecord(data as NotificationRow);
}

export async function updateNotification(
    client: SupabaseClient,
    id: string,
    input: NotificationDraftInput,
): Promise<PushNotificationRecord> {
    const { data, error } = await client
        .from('notification_records')
        .update({
            title: input.title.trim(),
            body: input.body.trim(),
            target: input.target,
            updated_at: new Date().toISOString(),
        })
        .eq('id', id)
        .eq('status', 'draft')
        .select('*')
        .single();
    if (error) throw error;
    return mapRecord(data as NotificationRow);
}

export async function deleteNotification(client: SupabaseClient, id: string): Promise<void> {
    const { error } = await client.from('notification_records').delete().eq('id', id);
    if (error) throw error;
}

export async function getNotificationSettings(
    client: SupabaseClient,
): Promise<NotificationSettings> {
    const { data, error } = await client
        .from('notification_settings')
        .select('*')
        .order('updated_at', { ascending: false })
        .limit(1)
        .maybeSingle();
    if (error) throw error;
    if (data) return mapSettings(data as SettingsRow);

    const { data: created, error: createError } = await client
        .from('notification_settings')
        .insert({ auto_notify_lotto6: true, auto_notify_lotto7: true })
        .select('*')
        .single();
    if (createError) throw createError;
    return mapSettings(created as SettingsRow);
}

export async function saveNotificationSettings(
    client: SupabaseClient,
    settings: Pick<NotificationSettings, 'id' | 'autoNotifyLotto6' | 'autoNotifyLotto7'>,
): Promise<NotificationSettings> {
    const { data, error } = await client
        .from('notification_settings')
        .update({
            auto_notify_lotto6: settings.autoNotifyLotto6,
            auto_notify_lotto7: settings.autoNotifyLotto7,
            updated_at: new Date().toISOString(),
        })
        .eq('id', settings.id)
        .select('*')
        .single();
    if (error) throw error;
    return mapSettings(data as SettingsRow);
}

export type SendPushResult =
    | { ok: true; id: string; topics: string[] }
    | { ok: false; error: string; message?: string; id?: string; status: number };

export async function invokeSendPush(
    client: SupabaseClient,
    body: { notificationId: string } | { title: string; body: string; target: NotificationTarget },
): Promise<SendPushResult> {
    const { data, error } = await client.functions.invoke('send-push', { body });
    if (error) {
        const status =
            typeof (error as { context?: { status?: number } }).context?.status === 'number'
                ? (error as { context: { status: number } }).context.status
                : 500;
        let parsed: { error?: string; message?: string; id?: string } | null = null;
        try {
            const ctx = (error as { context?: Response }).context;
            if (ctx && typeof ctx.json === 'function') {
                parsed = (await ctx.json()) as { error?: string; message?: string; id?: string };
            }
        } catch {
            /* ignore */
        }
        return {
            ok: false,
            error: parsed?.error ?? error.message ?? 'send_failed',
            message: parsed?.message,
            id: parsed?.id,
            status,
        };
    }

    const payload = data as { ok?: boolean; id?: string; topics?: string[]; error?: string; message?: string };
    if (payload?.ok && payload.id) {
        return { ok: true, id: payload.id, topics: payload.topics ?? [] };
    }
    return {
        ok: false,
        error: payload?.error ?? 'send_failed',
        message: payload?.message,
        id: payload?.id,
        status: 500,
    };
}

/** Fire-and-forget friendly auto-notify after a draw is published. */
export async function maybeAutoNotifyOnPublish(
    client: SupabaseClient,
    lotteryType: 'lotto6' | 'lotto7',
    drawNumber: string,
): Promise<SendPushResult | null> {
    const settings = await getNotificationSettings(client);
    const enabled =
        lotteryType === 'lotto6' ? settings.autoNotifyLotto6 : settings.autoNotifyLotto7;
    if (!enabled) return null;

    const label = lotteryType === 'lotto6' ? 'Lotto 6' : 'Lotto 7';
    return invokeSendPush(client, {
        title: `${label} results are live`,
        body: `Draw ${drawNumber} is published. Open the app to view winning numbers.`,
        target: lotteryType,
    });
}
