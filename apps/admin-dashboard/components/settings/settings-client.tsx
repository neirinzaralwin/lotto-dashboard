'use client';

import { FormEvent, useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import type { User } from '@supabase/supabase-js';
import { Eye, EyeOff } from 'lucide-react';
import { LOCALES, type Locale } from '@/lib/i18n/types';
import { useI18n } from '@/components/i18n/locale-provider';
import { PageHeader } from '@/components/layout/page-header';
import { AppIcon } from '@/components/ui/icon';
import { createClient } from '@/lib/supabase/client';

const MIN_PASSWORD_LENGTH = 8;
const FLASH_MS = 5000;

export function SettingsClient() {
    const { t, locale, setLocale } = useI18n();
    const router = useRouter();

    const [user, setUser] = useState<User | null>(null);
    const [currentPassword, setCurrentPassword] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [showCurrent, setShowCurrent] = useState(false);
    const [showNew, setShowNew] = useState(false);
    const [showConfirm, setShowConfirm] = useState(false);
    const [passwordBusy, setPasswordBusy] = useState(false);
    const [passwordError, setPasswordError] = useState<string | null>(null);
    const [passwordFlash, setPasswordFlash] = useState<string | null>(null);

    const [sessionBusy, setSessionBusy] = useState<'others' | 'global' | null>(null);
    const [sessionError, setSessionError] = useState<string | null>(null);
    const [sessionFlash, setSessionFlash] = useState<string | null>(null);

    useEffect(() => {
        void (async () => {
            const supabase = createClient();
            const { data } = await supabase.auth.getUser();
            setUser(data.user);
        })();
    }, []);

    useEffect(() => {
        if (!passwordFlash) return;
        const id = window.setTimeout(() => setPasswordFlash(null), FLASH_MS);
        return () => window.clearTimeout(id);
    }, [passwordFlash]);

    useEffect(() => {
        if (!sessionFlash) return;
        const id = window.setTimeout(() => setSessionFlash(null), FLASH_MS);
        return () => window.clearTimeout(id);
    }, [sessionFlash]);

    const confirmMismatch =
        confirmPassword.length > 0 && newPassword.length > 0 && newPassword !== confirmPassword;

    function touchPasswordFields() {
        setPasswordError(null);
        setPasswordFlash(null);
    }

    function formatLastSignIn(iso: string | undefined) {
        if (!iso) return t('settings.unknownTime');
        const d = new Date(iso);
        if (Number.isNaN(d.getTime())) return t('settings.unknownTime');
        return d.toLocaleString(locale === 'ja' ? 'ja-JP' : 'en-US', {
            dateStyle: 'medium',
            timeStyle: 'short',
        });
    }

    async function onChangePassword(e: FormEvent) {
        e.preventDefault();
        setPasswordError(null);
        setPasswordFlash(null);

        if (newPassword.length < MIN_PASSWORD_LENGTH) {
            setPasswordError(t('settings.passwordMin'));
            return;
        }
        if (newPassword !== confirmPassword) {
            setPasswordError(t('settings.passwordMismatch'));
            return;
        }
        if (newPassword === currentPassword) {
            setPasswordError(t('settings.passwordSameAsCurrent'));
            return;
        }

        const email = user?.email;
        if (!email) {
            setPasswordError(t('settings.passwordUpdateFailed'));
            return;
        }

        setPasswordBusy(true);
        try {
            const supabase = createClient();
            const { error: verifyError } = await supabase.auth.signInWithPassword({
                email,
                password: currentPassword,
            });
            if (verifyError) {
                setPasswordError(t('settings.currentPasswordWrong'));
                return;
            }

            const { error: updateError } = await supabase.auth.updateUser({
                password: newPassword,
            });
            if (updateError) {
                setPasswordError(updateError.message || t('settings.passwordUpdateFailed'));
                return;
            }

            await supabase.auth.signOut({ scope: 'others' });

            setCurrentPassword('');
            setNewPassword('');
            setConfirmPassword('');
            setShowCurrent(false);
            setShowNew(false);
            setShowConfirm(false);
            setPasswordFlash(t('settings.passwordUpdated'));
        } catch {
            setPasswordError(t('settings.passwordUpdateFailed'));
        } finally {
            setPasswordBusy(false);
        }
    }

    async function onSignOutOthers() {
        const ok = window.confirm(t('settings.signOutOthersConfirm'));
        if (!ok) return;
        setSessionError(null);
        setSessionFlash(null);
        setSessionBusy('others');
        try {
            const supabase = createClient();
            const { error } = await supabase.auth.signOut({ scope: 'others' });
            if (error) {
                setSessionError(error.message || t('settings.sessionActionFailed'));
                return;
            }
            setSessionFlash(t('settings.signOutOthersDone'));
        } catch {
            setSessionError(t('settings.sessionActionFailed'));
        } finally {
            setSessionBusy(null);
        }
    }

    async function onSignOutEverywhere() {
        const ok = window.confirm(t('settings.signOutEverywhereConfirm'));
        if (!ok) return;
        setSessionError(null);
        setSessionFlash(null);
        setSessionBusy('global');
        try {
            const supabase = createClient();
            const { error } = await supabase.auth.signOut({ scope: 'global' });
            if (error) {
                setSessionError(error.message || t('settings.sessionActionFailed'));
                return;
            }
            router.replace('/login');
            router.refresh();
        } catch {
            setSessionError(t('settings.sessionActionFailed'));
            setSessionBusy(null);
        }
    }

    return (
        <div className="space-y-6 sm:space-y-8">
            <PageHeader
                crumbs={[{ label: t('brand.lotto') }, { label: t('settings.crumbs') }]}
                title={t('settings.title')}
                subtitle={t('settings.subtitle')}
            />

            <section className="max-w-xl space-y-4 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-5">
                <div>
                    <h2 className="text-sm font-semibold tracking-tight">{t('settings.language')}</h2>
                    <p className="mt-1 text-sm text-[var(--lotto-muted)]">{t('settings.languageHint')}</p>
                </div>

                <div className="inline-flex max-w-full flex-wrap rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-0.5">
                    {LOCALES.map((opt) => {
                        const active = opt.id === locale;
                        return (
                            <button
                                key={opt.id}
                                type="button"
                                onClick={() => setLocale(opt.id as Locale)}
                                className={`rounded-full px-3.5 py-1.5 text-sm transition-colors ${
                                    active
                                        ? 'bg-[var(--lotto-fg)] font-semibold text-white'
                                        : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                                }`}
                            >
                                {opt.nativeLabel}
                            </button>
                        );
                    })}
                </div>

                <p className="text-[0.7rem] text-[var(--lotto-muted-soft)]">{t('settings.savedLocally')}</p>
            </section>

            <section className="max-w-xl space-y-4 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-5">
                <div>
                    <h2 className="text-sm font-semibold tracking-tight">{t('settings.password')}</h2>
                    <p className="mt-1 text-sm text-[var(--lotto-muted)]">{t('settings.passwordHint')}</p>
                </div>

                <form onSubmit={(e) => void onChangePassword(e)} className="space-y-3">
                    <PasswordField
                        label={t('settings.currentPassword')}
                        autoComplete="current-password"
                        value={currentPassword}
                        visible={showCurrent}
                        onToggleVisible={() => setShowCurrent((v) => !v)}
                        onChange={(value) => {
                            touchPasswordFields();
                            setCurrentPassword(value);
                        }}
                        showLabel={t('settings.showPassword')}
                        hideLabel={t('settings.hidePassword')}
                    />
                    <PasswordField
                        label={t('settings.newPassword')}
                        autoComplete="new-password"
                        value={newPassword}
                        visible={showNew}
                        minLength={MIN_PASSWORD_LENGTH}
                        onToggleVisible={() => setShowNew((v) => !v)}
                        onChange={(value) => {
                            touchPasswordFields();
                            setNewPassword(value);
                        }}
                        showLabel={t('settings.showPassword')}
                        hideLabel={t('settings.hidePassword')}
                    />
                    <PasswordField
                        label={t('settings.confirmPassword')}
                        autoComplete="new-password"
                        value={confirmPassword}
                        visible={showConfirm}
                        minLength={MIN_PASSWORD_LENGTH}
                        invalid={confirmMismatch}
                        onToggleVisible={() => setShowConfirm((v) => !v)}
                        onChange={(value) => {
                            touchPasswordFields();
                            setConfirmPassword(value);
                        }}
                        showLabel={t('settings.showPassword')}
                        hideLabel={t('settings.hidePassword')}
                    />
                    {confirmMismatch ? (
                        <p className="text-sm text-[#b42318]">{t('settings.passwordMismatch')}</p>
                    ) : null}

                    <p className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-caution-soft)] bg-[var(--lotto-caution-soft)]/50 px-3 py-2 text-xs text-[var(--lotto-fg)]">
                        {t('settings.passwordConsequence')}
                    </p>

                    {passwordError ? (
                        <p className="text-sm text-[#b42318]">{passwordError}</p>
                    ) : null}
                    {passwordFlash ? (
                        <p className="text-sm text-[var(--lotto-delta)]">{passwordFlash}</p>
                    ) : null}

                    <button
                        type="submit"
                        disabled={passwordBusy || confirmMismatch}
                        className="rounded-full bg-[var(--lotto-fg)] px-4 py-2.5 text-sm font-semibold text-white disabled:opacity-60"
                    >
                        {passwordBusy ? t('settings.changingPassword') : t('settings.changePassword')}
                    </button>
                </form>
            </section>

            <section className="max-w-xl space-y-4 rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-5">
                <div>
                    <h2 className="text-sm font-semibold tracking-tight">{t('settings.sessions')}</h2>
                    <p className="mt-1 text-sm text-[var(--lotto-muted)]">{t('settings.sessionsHint')}</p>
                </div>

                <div className="grid gap-3 rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] p-4 text-sm sm:grid-cols-2">
                    <div>
                        <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                            {t('settings.signedInAs')}
                        </p>
                        <p className="mt-1 font-medium break-all">{user?.email ?? '…'}</p>
                    </div>
                    <div>
                        <p className="text-[0.7rem] font-medium uppercase tracking-[0.14em] text-[var(--lotto-muted-soft)]">
                            {t('settings.lastSignIn')}
                        </p>
                        <p className="mt-1 font-medium">{formatLastSignIn(user?.last_sign_in_at)}</p>
                    </div>
                </div>

                <div className="space-y-3">
                    <div className="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
                        <div className="min-w-0">
                            <p className="text-sm font-medium">{t('settings.signOutOthers')}</p>
                            <p className="mt-0.5 text-xs text-[var(--lotto-muted)]">
                                {t('settings.signOutOthersHint')}
                            </p>
                        </div>
                        <button
                            type="button"
                            disabled={sessionBusy != null}
                            onClick={() => void onSignOutOthers()}
                            className="shrink-0 rounded-full border border-[var(--lotto-border)] bg-white px-4 py-2 text-sm font-semibold disabled:opacity-60"
                        >
                            {sessionBusy === 'others'
                                ? t('settings.working')
                                : t('settings.signOutOthers')}
                        </button>
                    </div>

                    <div className="flex flex-col gap-2 border-t border-[var(--lotto-border)] pt-3 sm:flex-row sm:items-start sm:justify-between">
                        <div className="min-w-0">
                            <p className="text-sm font-medium">{t('settings.signOutEverywhere')}</p>
                            <p className="mt-0.5 text-xs text-[var(--lotto-muted)]">
                                {t('settings.signOutEverywhereHint')}
                            </p>
                        </div>
                        <button
                            type="button"
                            disabled={sessionBusy != null}
                            onClick={() => void onSignOutEverywhere()}
                            className="shrink-0 rounded-full border border-[#b42318]/30 bg-[#f8e4e2] px-4 py-2 text-sm font-semibold text-[#b42318] disabled:opacity-60"
                        >
                            {sessionBusy === 'global'
                                ? t('settings.working')
                                : t('settings.signOutEverywhere')}
                        </button>
                    </div>
                </div>

                {sessionError ? <p className="text-sm text-[#b42318]">{sessionError}</p> : null}
                {sessionFlash ? (
                    <p className="text-sm text-[var(--lotto-delta)]">{sessionFlash}</p>
                ) : null}
            </section>
        </div>
    );
}

function PasswordField({
    label,
    value,
    visible,
    onChange,
    onToggleVisible,
    showLabel,
    hideLabel,
    autoComplete,
    minLength,
    invalid = false,
}: {
    label: string;
    value: string;
    visible: boolean;
    onChange: (value: string) => void;
    onToggleVisible: () => void;
    showLabel: string;
    hideLabel: string;
    autoComplete: string;
    minLength?: number;
    invalid?: boolean;
}) {
    return (
        <label className="block space-y-1.5 text-sm">
            <span className="text-[var(--lotto-muted)]">{label}</span>
            <span className="relative block">
                <input
                    type={visible ? 'text' : 'password'}
                    autoComplete={autoComplete}
                    required
                    minLength={minLength}
                    value={value}
                    onChange={(e) => onChange(e.target.value)}
                    className={`w-full rounded-xl border bg-white py-2 pl-3 pr-10 outline-none focus:border-[var(--lotto-border-strong)] ${
                        invalid
                            ? 'border-[#b42318]'
                            : 'border-[var(--lotto-border)]'
                    }`}
                />
                <button
                    type="button"
                    onClick={onToggleVisible}
                    className="absolute right-1.5 top-1/2 inline-flex h-8 w-8 -translate-y-1/2 items-center justify-center rounded-lg text-[var(--lotto-muted)] hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)]"
                    aria-label={visible ? hideLabel : showLabel}
                    title={visible ? hideLabel : showLabel}
                >
                    <AppIcon icon={visible ? EyeOff : Eye} size={16} />
                </button>
            </span>
        </label>
    );
}
