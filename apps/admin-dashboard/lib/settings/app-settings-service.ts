import type { SupabaseClient } from '@supabase/supabase-js';
import type { AppSettings } from '@repo/types';

interface AppSettingsRow {
    id: string;
    privacy_policy_url: string | null;
    terms_of_service_url: string | null;
    updated_at: string;
}

function mapAppSettings(row: AppSettingsRow): AppSettings {
    return {
        id: row.id,
        privacyPolicyUrl: row.privacy_policy_url ?? '',
        termsOfServiceUrl: row.terms_of_service_url ?? '',
        updatedAt: row.updated_at,
    };
}

export async function getAppSettings(client: SupabaseClient): Promise<AppSettings> {
    const { data, error } = await client
        .from('app_settings')
        .select('*')
        .order('updated_at', { ascending: false })
        .limit(1)
        .maybeSingle();
    if (error) throw error;
    if (data) return mapAppSettings(data as AppSettingsRow);

    const { data: created, error: createError } = await client
        .from('app_settings')
        .insert({ privacy_policy_url: '', terms_of_service_url: '' })
        .select('*')
        .single();
    if (createError) throw createError;
    return mapAppSettings(created as AppSettingsRow);
}

export async function saveAppSettings(
    client: SupabaseClient,
    settings: Pick<AppSettings, 'id' | 'privacyPolicyUrl' | 'termsOfServiceUrl'>,
): Promise<AppSettings> {
    const { data, error } = await client
        .from('app_settings')
        .update({
            privacy_policy_url: settings.privacyPolicyUrl.trim(),
            terms_of_service_url: settings.termsOfServiceUrl.trim(),
            updated_at: new Date().toISOString(),
        })
        .eq('id', settings.id)
        .select('*')
        .single();
    if (error) throw error;
    return mapAppSettings(data as AppSettingsRow);
}
