'use client';

import {
    createContext,
    useCallback,
    useContext,
    useEffect,
    useMemo,
    useState,
    type ReactNode,
} from 'react';
import { messages } from '@/lib/i18n/messages';
import {
    DEFAULT_LOCALE,
    getMessage,
    LOCALE_STORAGE_KEY,
    type Locale,
} from '@/lib/i18n/types';

type LocaleContextValue = {
    locale: Locale;
    setLocale: (locale: Locale) => void;
    t: (key: string, params?: Record<string, string | number>) => string;
    ready: boolean;
};

const LocaleContext = createContext<LocaleContextValue | null>(null);

function readStoredLocale(): Locale {
    try {
        const raw = window.localStorage.getItem(LOCALE_STORAGE_KEY);
        if (raw === 'en' || raw === 'ja') return raw;
    } catch {
        /* ignore */
    }
    return DEFAULT_LOCALE;
}

export function LocaleProvider({ children }: { children: ReactNode }) {
    const [locale, setLocaleState] = useState<Locale>(DEFAULT_LOCALE);
    const [ready, setReady] = useState(false);

    useEffect(() => {
        setLocaleState(readStoredLocale());
        setReady(true);
    }, []);

    useEffect(() => {
        if (!ready) return;
        document.documentElement.lang = locale;
    }, [locale, ready]);

    const setLocale = useCallback((next: Locale) => {
        setLocaleState(next);
        try {
            window.localStorage.setItem(LOCALE_STORAGE_KEY, next);
        } catch {
            /* ignore */
        }
    }, []);

    const t = useCallback(
        (key: string, params?: Record<string, string | number>) =>
            getMessage(messages[locale], key, params),
        [locale],
    );

    const value = useMemo(
        () => ({ locale, setLocale, t, ready }),
        [locale, setLocale, t, ready],
    );

    return <LocaleContext.Provider value={value}>{children}</LocaleContext.Provider>;
}

export function useI18n() {
    const ctx = useContext(LocaleContext);
    if (!ctx) {
        throw new Error('useI18n must be used within LocaleProvider');
    }
    return ctx;
}
