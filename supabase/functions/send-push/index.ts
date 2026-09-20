// Deploy: supabase functions deploy send-push
// Secret: supabase secrets set FIREBASE_SERVICE_ACCOUNT_JSON='{...}'

import 'jsr:@supabase/functions-js/edge-runtime.d.ts';
import { createClient } from 'jsr:@supabase/supabase-js@2';

type NotificationTarget = 'lotto6' | 'lotto7' | 'all';

type SendBody = {
    notificationId?: string;
    title?: string;
    body?: string;
    target?: NotificationTarget;
};

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

function json(data: unknown, status = 200) {
    return new Response(JSON.stringify(data), {
        status,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
}

function topicsFor(target: NotificationTarget): string[] {
    if (target === 'lotto6') return ['lotto6'];
    if (target === 'lotto7') return ['lotto7'];
    return ['lotto6', 'lotto7'];
}

function base64Url(data: ArrayBuffer | string): string {
    const bytes =
        typeof data === 'string' ? new TextEncoder().encode(data) : new Uint8Array(data);
    let binary = '';
    for (const b of bytes) binary += String.fromCharCode(b);
    return btoa(binary).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

async function importPrivateKey(pem: string): Promise<CryptoKey> {
    const cleaned = pem
        .replace(/-----BEGIN PRIVATE KEY-----/g, '')
        .replace(/-----END PRIVATE KEY-----/g, '')
        .replace(/\s+/g, '');
    const raw = Uint8Array.from(atob(cleaned), (c) => c.charCodeAt(0));
    return crypto.subtle.importKey(
        'pkcs8',
        raw,
        { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
        false,
        ['sign'],
    );
}

async function getGoogleAccessToken(serviceAccount: {
    client_email: string;
    private_key: string;
    token_uri?: string;
}): Promise<string> {
    const now = Math.floor(Date.now() / 1000);
    const header = base64Url(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
    const claim = base64Url(
        JSON.stringify({
            iss: serviceAccount.client_email,
            scope: 'https://www.googleapis.com/auth/firebase.messaging',
            aud: serviceAccount.token_uri ?? 'https://oauth2.googleapis.com/token',
            iat: now,
            exp: now + 3600,
        }),
    );
    const unsigned = `${header}.${claim}`;
    const key = await importPrivateKey(serviceAccount.private_key);
    const signature = await crypto.subtle.sign(
        'RSASSA-PKCS1-v1_5',
        key,
        new TextEncoder().encode(unsigned),
    );
    const jwt = `${unsigned}.${base64Url(signature)}`;

    const tokenRes = await fetch(serviceAccount.token_uri ?? 'https://oauth2.googleapis.com/token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
            grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
            assertion: jwt,
        }),
    });
    if (!tokenRes.ok) {
        const text = await tokenRes.text();
        throw new Error(`Google token exchange failed: ${text}`);
    }
    const tokenJson = (await tokenRes.json()) as { access_token?: string };
    if (!tokenJson.access_token) throw new Error('Google token response missing access_token');
    return tokenJson.access_token;
}

async function sendFcmToTopic(opts: {
    projectId: string;
    accessToken: string;
    topic: string;
    title: string;
    body: string;
}) {
    const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${opts.projectId}/messages:send`,
        {
            method: 'POST',
            headers: {
                Authorization: `Bearer ${opts.accessToken}`,
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                message: {
                    topic: opts.topic,
                    notification: {
                        title: opts.title,
                        body: opts.body,
                    },
                    data: {
                        topic: opts.topic,
                    },
                },
            }),
        },
    );
    if (!res.ok) {
        const text = await res.text();
        throw new Error(`FCM send failed (${opts.topic}): ${text}`);
    }
}

Deno.serve(async (req) => {
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
    }
    if (req.method !== 'POST') {
        return json({ error: 'Method not allowed' }, 405);
    }

    const supabaseUrl = Deno.env.get('SUPABASE_URL');
    const anonKey = Deno.env.get('SUPABASE_ANON_KEY');
    const serviceRole = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
    if (!supabaseUrl || !anonKey || !serviceRole) {
        return json({ error: 'supabase_env_missing' }, 500);
    }

    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
        return json({ error: 'unauthorized' }, 401);
    }

    const userClient = createClient(supabaseUrl, anonKey, {
        global: { headers: { Authorization: authHeader } },
    });
    const {
        data: { user },
        error: userError,
    } = await userClient.auth.getUser();
    if (userError || !user) {
        return json({ error: 'unauthorized' }, 401);
    }

    let payload: SendBody;
    try {
        payload = (await req.json()) as SendBody;
    } catch {
        return json({ error: 'invalid_json' }, 400);
    }

    const admin = createClient(supabaseUrl, serviceRole);

    let recordId = payload.notificationId ?? null;
    let title = payload.title?.trim() ?? '';
    let body = payload.body?.trim() ?? '';
    let target: NotificationTarget = payload.target ?? 'all';

    if (recordId) {
        const { data: existing, error } = await admin
            .from('notification_records')
            .select('id, title, body, target, status')
            .eq('id', recordId)
            .maybeSingle();
        if (error || !existing) {
            return json({ error: 'notification_not_found' }, 404);
        }
        if (existing.status === 'sent') {
            return json({ error: 'already_sent', id: existing.id }, 409);
        }
        title = existing.title;
        body = existing.body;
        target = existing.target as NotificationTarget;
    } else {
        if (!title || !body) {
            return json({ error: 'title_and_body_required' }, 400);
        }
        if (target !== 'lotto6' && target !== 'lotto7' && target !== 'all') {
            return json({ error: 'invalid_target' }, 400);
        }
        const { data: created, error } = await admin
            .from('notification_records')
            .insert({
                title,
                body,
                target,
                status: 'draft',
            })
            .select('id')
            .single();
        if (error || !created) {
            return json({ error: 'create_failed', detail: error?.message }, 500);
        }
        recordId = created.id as string;
    }

    const saRaw = Deno.env.get('FIREBASE_SERVICE_ACCOUNT_JSON');
    if (!saRaw) {
        return json(
            {
                error: 'fcm_not_configured',
                message:
                    'Set FIREBASE_SERVICE_ACCOUNT_JSON secret, then redeploy send-push. Draft was not marked sent.',
                id: recordId,
            },
            503,
        );
    }

    let serviceAccount: {
        project_id: string;
        client_email: string;
        private_key: string;
        token_uri?: string;
    };
    try {
        serviceAccount = JSON.parse(saRaw);
    } catch {
        return json({ error: 'fcm_service_account_invalid', id: recordId }, 500);
    }
    if (!serviceAccount.project_id || !serviceAccount.client_email || !serviceAccount.private_key) {
        return json({ error: 'fcm_service_account_incomplete', id: recordId }, 500);
    }

    try {
        const accessToken = await getGoogleAccessToken(serviceAccount);
        for (const topic of topicsFor(target)) {
            await sendFcmToTopic({
                projectId: serviceAccount.project_id,
                accessToken,
                topic,
                title,
                body,
            });
        }

        const now = new Date().toISOString();
        const { error: updateError } = await admin
            .from('notification_records')
            .update({ status: 'sent', sent_at: now, updated_at: now })
            .eq('id', recordId);
        if (updateError) {
            return json({ error: 'mark_sent_failed', detail: updateError.message, id: recordId }, 500);
        }

        return json({ ok: true, id: recordId, topics: topicsFor(target) });
    } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        return json({ error: 'fcm_send_failed', message, id: recordId }, 502);
    }
});
