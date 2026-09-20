'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import {
    ArrowLeftToLine,
    ArrowRightToLine,
    Bell,
    Dices,
    LayoutDashboard,
    LogOut,
    Search,
    Settings,
    Sparkles,
    Upload,
} from 'lucide-react';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';
import { ShellSearchOverlay } from '@/components/layout/shell-search-overlay';
import { ShellSearchProvider, useShellSearch } from '@/components/layout/shell-search';
import { createClient } from '@/lib/supabase/client';

const SIDEBAR_COLLAPSED_KEY = 'lotto-admin-sidebar-collapsed';

const navItems = [
    { href: '/', labelKey: 'nav.overview', icon: LayoutDashboard, exact: true },
    { href: '/draws', labelKey: 'nav.draws', icon: Dices },
    { href: '/import', labelKey: 'nav.import', icon: Upload },
    { href: '/algorithms', labelKey: 'nav.algorithms', icon: Sparkles },
    { href: '/notifications', labelKey: 'nav.alerts', icon: Bell },
] as const;

export function AppShell({ children }: { children: React.ReactNode }) {
    return (
        <ShellSearchProvider>
            <ShellFrame>{children}</ShellFrame>
        </ShellSearchProvider>
    );
}

function isActive(pathname: string, href: string, exact?: boolean) {
    return exact ? pathname === href : pathname.startsWith(href);
}

function ShellFrame({ children }: { children: React.ReactNode }) {
    const pathname = usePathname();
    const router = useRouter();
    const { t } = useI18n();
    const { query, setQuery, mode, open, setOpen, hasNumberFilter, filledBalls } = useShellSearch();
    const searchAnchorRef = useRef<HTMLDivElement>(null);
    const [collapsed, setCollapsed] = useState(true);
    const [sidebarReady, setSidebarReady] = useState(false);

    const nav = useMemo(
        () =>
            navItems.map((item) => ({
                ...item,
                label: t(item.labelKey),
            })),
        [t],
    );

    useEffect(() => {
        try {
            const stored = window.localStorage.getItem(SIDEBAR_COLLAPSED_KEY);
            if (stored === '0' || stored === 'false') setCollapsed(false);
            else if (stored === '1' || stored === 'true') setCollapsed(true);
        } catch {
            /* ignore */
        }
        setSidebarReady(true);
    }, []);

    function toggleSidebar() {
        setCollapsed((prev) => {
            const next = !prev;
            try {
                window.localStorage.setItem(SIDEBAR_COLLAPSED_KEY, next ? '1' : '0');
            } catch {
                /* ignore */
            }
            return next;
        });
    }

    const triggerValue =
        mode === 'numbers' && hasNumberFilter
            ? t('nav.balls', { list: filledBalls.join(' · ') })
            : query;

    async function signOut() {
        const supabase = createClient();
        await supabase.auth.signOut({ scope: 'local' });
        router.replace('/login');
        router.refresh();
    }

    const settingsActive = isActive(pathname, '/settings');
    const footerLinkClass = (active: boolean) =>
        `inline-flex h-11 items-center rounded-[var(--lotto-radius-xs)] transition-colors ${
            collapsed ? 'w-11 justify-center' : 'w-full gap-3 px-3 text-sm font-medium'
        } ${
            active
                ? 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]'
                : 'text-[var(--lotto-muted)] hover:bg-white/70 hover:text-[var(--lotto-fg)]'
        }`;

    return (
        <div className="flex min-h-screen bg-[var(--lotto-bg)] text-[var(--lotto-fg)]">
            <aside
                className={`sticky top-0 z-20 hidden h-screen shrink-0 flex-col border-r border-[var(--lotto-border)] bg-[var(--lotto-sidebar)] py-4 transition-[width] duration-200 ease-out md:flex ${
                    collapsed
                        ? 'w-[var(--lotto-sidebar-width)] items-center px-0'
                        : 'w-[var(--lotto-sidebar-width-expanded)] items-stretch px-3'
                } ${sidebarReady ? '' : 'opacity-0'}`}
                aria-label={t('nav.primary')}
                data-collapsed={collapsed ? 'true' : 'false'}
            >
                <div
                    className={`mb-6 flex items-center ${
                        collapsed ? 'justify-center' : 'gap-2 px-0.5'
                    }`}
                >
                    <Link
                        href="/"
                        className="flex h-10 w-10 shrink-0 items-center justify-center rounded-[var(--lotto-radius-xs)] bg-[var(--lotto-fg)] text-[0.7rem] font-semibold tracking-tight text-white"
                        title={t('brand.admin')}
                    >
                        L
                    </Link>
                    {!collapsed ? (
                        <span className="min-w-0 flex-1 truncate text-sm font-semibold tracking-tight">
                            {t('brand.admin')}
                        </span>
                    ) : null}
                </div>

                <nav
                    className={`flex flex-1 flex-col gap-1.5 ${
                        collapsed ? 'items-center' : 'items-stretch'
                    }`}
                >
                    {nav.map((item) => {
                        const active = isActive(pathname, item.href, 'exact' in item && item.exact);
                        return (
                            <Link
                                key={item.href}
                                href={item.href}
                                title={item.label}
                                aria-label={item.label}
                                aria-current={active ? 'page' : undefined}
                                className={`inline-flex h-11 items-center rounded-[var(--lotto-radius-xs)] transition-colors ${
                                    collapsed
                                        ? 'w-11 justify-center'
                                        : 'w-full gap-3 px-3 text-sm font-medium'
                                } ${
                                    active
                                        ? 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]'
                                        : 'text-[var(--lotto-muted)] hover:bg-white/70 hover:text-[var(--lotto-fg)]'
                                }`}
                            >
                                <AppIcon icon={item.icon} size={20} />
                                {!collapsed ? <span className="truncate">{item.label}</span> : null}
                            </Link>
                        );
                    })}
                </nav>

                <div
                    className={`mt-2 flex flex-col gap-1.5 ${
                        collapsed ? 'items-center' : 'items-stretch'
                    }`}
                >
                    <Link
                        href="/settings"
                        title={t('nav.settings')}
                        aria-label={t('nav.settings')}
                        aria-current={settingsActive ? 'page' : undefined}
                        className={footerLinkClass(settingsActive)}
                    >
                        <AppIcon icon={Settings} size={20} />
                        {!collapsed ? (
                            <span className="truncate">{t('nav.settings')}</span>
                        ) : null}
                    </Link>
                    <button
                        type="button"
                        onClick={signOut}
                        title={t('nav.signOut')}
                        aria-label={t('nav.signOut')}
                        className={footerLinkClass(false)}
                    >
                        <AppIcon icon={LogOut} size={20} />
                        {!collapsed ? (
                            <span className="truncate">{t('nav.signOut')}</span>
                        ) : null}
                    </button>
                </div>
            </aside>

            <div className="flex min-w-0 flex-1 flex-col pb-[calc(4.25rem+env(safe-area-inset-bottom))] md:pb-0">
                <header className="sticky top-0 z-40 flex items-center justify-between gap-3 border-b border-[var(--lotto-border)] bg-[var(--lotto-bg)]/95 px-4 py-2.5 backdrop-blur-md sm:px-6 sm:py-3 md:pl-1 md:pr-8 md:py-3">
                    <div className="flex shrink-0 items-center gap-2.5">
                        <button
                            type="button"
                            onClick={toggleSidebar}
                            title={collapsed ? t('nav.expandSidebar') : t('nav.collapseSidebar')}
                            aria-label={
                                collapsed ? t('nav.expandSidebar') : t('nav.collapseSidebar')
                            }
                            aria-expanded={!collapsed}
                            className="hidden h-8 w-8 items-center justify-center rounded-md text-[var(--lotto-muted)] transition-colors hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)] md:inline-flex"
                        >
                            <AppIcon
                                icon={collapsed ? ArrowRightToLine : ArrowLeftToLine}
                                size={18}
                            />
                        </button>
                        <Link
                            href="/"
                            className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-[var(--lotto-fg)] text-[0.65rem] font-semibold text-white md:hidden"
                            aria-label={t('nav.home')}
                        >
                            L
                        </Link>
                        <Link
                            href="/settings"
                            title={t('nav.settings')}
                            aria-label={t('nav.settings')}
                            className={`inline-flex h-8 w-8 items-center justify-center rounded-md text-[var(--lotto-muted)] transition-colors hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)] md:hidden ${
                                settingsActive ? 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]' : ''
                            }`}
                        >
                            <AppIcon icon={Settings} size={16} />
                        </Link>
                    </div>
                    <div
                        ref={searchAnchorRef}
                        className="relative w-full max-w-[11.5rem] sm:max-w-[220px] md:max-w-[260px]"
                    >
                        <label className="relative block">
                            <span className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 text-[var(--lotto-muted-soft)] sm:left-3">
                                <AppIcon icon={Search} size={14} />
                            </span>
                            <input
                                value={triggerValue}
                                onChange={(e) => {
                                    if (mode === 'numbers') return;
                                    setQuery(e.target.value);
                                    setOpen(true);
                                }}
                                onFocus={() => setOpen(true)}
                                onClick={() => setOpen(true)}
                                readOnly={mode === 'numbers'}
                                placeholder={t('common.search')}
                                aria-expanded={open}
                                aria-haspopup="dialog"
                                className="w-full rounded-full border border-[var(--lotto-border)] bg-[var(--lotto-surface)] py-1.5 pl-8 pr-2.5 text-[0.8rem] outline-none transition-colors placeholder:text-[var(--lotto-muted-soft)] focus:border-[var(--lotto-border-strong)] sm:py-2 sm:pl-9 sm:pr-3"
                            />
                        </label>
                        <ShellSearchOverlay anchorRef={searchAnchorRef} />
                    </div>
                </header>

                <main className="mx-auto w-full max-w-6xl flex-1 px-4 py-5 sm:px-6 sm:py-8 md:px-8 md:py-10">
                    {children}
                </main>
            </div>

            <nav
                className="fixed inset-x-0 bottom-0 z-30 border-t border-[var(--lotto-border)] bg-[var(--lotto-bg)]/95 backdrop-blur-md md:hidden"
                style={{ paddingBottom: 'env(safe-area-inset-bottom)' }}
                aria-label={t('nav.primary')}
            >
                <ul className="mx-auto flex max-w-lg items-stretch justify-between px-1 pt-1">
                    {nav.map((item) => {
                        const active = isActive(pathname, item.href, 'exact' in item && item.exact);
                        return (
                            <li key={item.href} className="flex-1">
                                <Link
                                    href={item.href}
                                    aria-current={active ? 'page' : undefined}
                                    className={`flex flex-col items-center gap-0.5 px-1 py-2 text-[0.65rem] font-medium ${
                                        active ? 'text-[var(--lotto-fg)]' : 'text-[var(--lotto-muted-soft)]'
                                    }`}
                                >
                                    <span
                                        className={`inline-flex h-8 w-8 items-center justify-center rounded-lg ${
                                            active ? 'bg-[var(--lotto-accent-soft)]' : ''
                                        }`}
                                    >
                                        <AppIcon icon={item.icon} size={18} strokeWidth={active ? 2 : 1.5} />
                                    </span>
                                    {item.label}
                                </Link>
                            </li>
                        );
                    })}
                </ul>
            </nav>
        </div>
    );
}
