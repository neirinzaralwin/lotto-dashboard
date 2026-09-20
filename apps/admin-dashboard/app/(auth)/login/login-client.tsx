'use client';

import { FormEvent, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useI18n } from '@/components/i18n/locale-provider';
import { createClient } from '@/lib/supabase/client';

export default function LoginClient() {
    const router = useRouter();
    const searchParams = useSearchParams();
    const next = searchParams.get('next') || '/';
    const { t } = useI18n();

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);

    async function onSubmit(e: FormEvent) {
        e.preventDefault();
        setLoading(true);
        setError(null);
        try {
            const supabase = createClient();
            const { error: signError } = await supabase.auth.signInWithPassword({ email, password });
            if (signError) {
                setError(signError.message);
                return;
            }
            router.replace(next);
            router.refresh();
        } catch (err) {
            setError(err instanceof Error ? err.message : t('login.failed'));
        } finally {
            setLoading(false);
        }
    }

    return (
        <div className="flex min-h-screen items-center justify-center bg-[var(--lotto-bg)] px-4 text-[var(--lotto-fg)]">
            <form
                onSubmit={onSubmit}
                className="w-full max-w-sm space-y-5 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-6 shadow-sm"
            >
                <div>
                    <p className="text-[0.7rem] font-medium uppercase tracking-[0.16em] text-[var(--lotto-muted-soft)]">
                        {t('login.admin')}
                    </p>
                    <h1 className="mt-1 text-2xl font-semibold tracking-tight">{t('login.title')}</h1>
                    <p className="mt-1 text-sm text-[var(--lotto-muted)]">{t('login.subtitle')}</p>
                </div>
                <label className="block space-y-1.5 text-sm">
                    <span className="text-[var(--lotto-muted)]">{t('login.email')}</span>
                    <input
                        type="email"
                        required
                        autoComplete="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        className="w-full rounded-xl border border-[var(--lotto-border)] bg-white px-3 py-2 outline-none focus:border-[var(--lotto-border-strong)]"
                    />
                </label>
                <label className="block space-y-1.5 text-sm">
                    <span className="text-[var(--lotto-muted)]">{t('login.password')}</span>
                    <input
                        type="password"
                        required
                        autoComplete="current-password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        className="w-full rounded-xl border border-[var(--lotto-border)] bg-white px-3 py-2 outline-none focus:border-[var(--lotto-border-strong)]"
                    />
                </label>
                {error ? <p className="text-sm text-red-600">{error}</p> : null}
                <button
                    type="submit"
                    disabled={loading}
                    className="w-full rounded-full bg-[var(--lotto-fg)] px-4 py-2.5 text-sm font-semibold text-white disabled:opacity-60"
                >
                    {loading ? t('login.submitting') : t('login.submit')}
                </button>
            </form>
        </div>
    );
}
