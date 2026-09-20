'use client';

import { useEffect } from 'react';
import { X } from 'lucide-react';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';

export function SlideOver({
    open,
    title,
    onClose,
    children,
    wide = false,
}: {
    open: boolean;
    title: string;
    onClose: () => void;
    children: React.ReactNode;
    wide?: boolean;
}) {
    const { t } = useI18n();
    useEffect(() => {
        if (!open) return;
        const onKey = (e: KeyboardEvent) => {
            if (e.key === 'Escape') onClose();
        };
        document.addEventListener('keydown', onKey);
        const prev = document.body.style.overflow;
        document.body.style.overflow = 'hidden';
        return () => {
            document.removeEventListener('keydown', onKey);
            document.body.style.overflow = prev;
        };
    }, [open, onClose]);

    return (
        <div
            className={`fixed inset-0 z-50 ${open ? 'pointer-events-auto' : 'pointer-events-none'}`}
            aria-hidden={!open}
        >
            <button
                type="button"
                aria-label={t('common.closePanel')}
                onClick={onClose}
                className={`absolute inset-0 bg-[var(--lotto-fg)]/20 transition-opacity duration-300 ${
                    open ? 'opacity-100' : 'opacity-0'
                }`}
            />
            <aside
                role="dialog"
                aria-modal="true"
                aria-label={title}
                className={`absolute inset-y-0 right-0 flex w-full flex-col border-l border-[var(--lotto-border)] bg-[var(--lotto-surface)] shadow-[-12px_0_40px_rgba(0,0,0,0.06)] transition-transform duration-300 ease-[cubic-bezier(0.22,1,0.36,1)] ${
                    wide ? 'max-w-xl' : 'max-w-md'
                } ${open ? 'translate-x-0' : 'translate-x-full'}`}
            >
                <div className="flex items-center justify-between gap-3 border-b border-[var(--lotto-border)] px-5 py-4">
                    <h2 className="text-base font-semibold tracking-[-0.02em]">{title}</h2>
                    <button
                        type="button"
                        onClick={onClose}
                        className="inline-flex h-9 w-9 items-center justify-center rounded-[var(--lotto-radius-xs)] text-[var(--lotto-muted)] hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)]"
                        aria-label={t('common.close')}
                    >
                        <AppIcon icon={X} size={18} />
                    </button>
                </div>
                <div className="flex-1 overflow-y-auto px-5 py-5">{children}</div>
            </aside>
        </div>
    );
}
