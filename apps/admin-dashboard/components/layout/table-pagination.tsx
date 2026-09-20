'use client';

import { ChevronLeft, ChevronRight } from 'lucide-react';
import { useI18n } from '@/components/i18n/locale-provider';
import { AppIcon } from '@/components/ui/icon';

export function TablePagination({
    page,
    pageSize,
    total,
    onPageChange,
}: {
    page: number;
    pageSize: number;
    total: number;
    onPageChange: (page: number) => void;
}) {
    const { t } = useI18n();
    const pageCount = Math.max(1, Math.ceil(total / pageSize));
    const safePage = Math.min(Math.max(1, page), pageCount);
    const from = total === 0 ? 0 : (safePage - 1) * pageSize + 1;
    const to = Math.min(safePage * pageSize, total);

    return (
        <div className="flex flex-col gap-3 border-t border-[var(--lotto-border)] px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
            <p className="text-sm text-[var(--lotto-muted)]">
                {total === 0
                    ? t('common.noResults')
                    : t('common.showingRange', { from, to, total })}
            </p>
            <div className="flex items-center gap-2">
                <button
                    type="button"
                    disabled={safePage <= 1}
                    onClick={() => onPageChange(safePage - 1)}
                    className="inline-flex h-9 items-center gap-1 rounded-full border border-[var(--lotto-border)] px-3 text-sm text-[var(--lotto-muted)] transition-colors hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)] disabled:cursor-default disabled:opacity-40"
                >
                    <AppIcon icon={ChevronLeft} size={16} />
                    {t('common.prev')}
                </button>
                <span className="min-w-[4.5rem] text-center text-sm font-medium tabular-nums">
                    {safePage} / {pageCount}
                </span>
                <button
                    type="button"
                    disabled={safePage >= pageCount}
                    onClick={() => onPageChange(safePage + 1)}
                    className="inline-flex h-9 items-center gap-1 rounded-full border border-[var(--lotto-border)] px-3 text-sm text-[var(--lotto-muted)] transition-colors hover:bg-[var(--lotto-surface-muted)] hover:text-[var(--lotto-fg)] disabled:cursor-default disabled:opacity-40"
                >
                    {t('common.next')}
                    <AppIcon icon={ChevronRight} size={16} />
                </button>
            </div>
        </div>
    );
}
