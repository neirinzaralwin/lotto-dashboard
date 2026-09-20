import type { ReactNode } from 'react';
import Link from 'next/link';
import { ChevronRight } from 'lucide-react';
import { AppIcon } from '@/components/ui/icon';

export type Crumb = { label: string; href?: string };

export function PageHeader({
    crumbs,
    title,
    subtitle,
    mark,
    actions,
}: {
    crumbs: Crumb[];
    title: string;
    subtitle?: string;
    mark?: ReactNode;
    actions?: ReactNode;
}) {
    return (
        <div className="flex flex-col gap-4 sm:gap-5 sm:flex-row sm:items-start sm:justify-between">
            <div className="min-w-0 space-y-2.5 sm:space-y-3">
                <nav className="flex flex-wrap items-center gap-1 text-[0.75rem] text-[var(--lotto-muted)] sm:gap-1.5 sm:text-[0.8rem]">
                    {crumbs.map((crumb, i) => (
                        <span key={`${crumb.label}-${i}`} className="inline-flex items-center gap-1 sm:gap-1.5">
                            {i > 0 ? (
                                <AppIcon icon={ChevronRight} size={13} className="text-[var(--lotto-muted-soft)]" />
                            ) : null}
                            {crumb.href ? (
                                <Link href={crumb.href} className="hover:text-[var(--lotto-fg)]">
                                    {crumb.label}
                                </Link>
                            ) : (
                                <span className="text-[var(--lotto-fg)]">{crumb.label}</span>
                            )}
                        </span>
                    ))}
                </nav>
                <div className="flex items-start gap-3 sm:items-center sm:gap-3.5">
                    {mark ? (
                        <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-[var(--lotto-radius-xs)] border border-[var(--lotto-border)] bg-[var(--lotto-surface-muted)] sm:h-12 sm:w-12">
                            {mark}
                        </div>
                    ) : null}
                    <div className="min-w-0">
                        <h1 className="text-[1.4rem] font-semibold tracking-[-0.03em] sm:text-[1.65rem] md:text-[1.85rem]">
                            {title}
                        </h1>
                        {subtitle ? (
                            <p className="mt-0.5 line-clamp-2 text-[0.8rem] leading-snug text-[var(--lotto-muted)] sm:text-sm">
                                {subtitle}
                            </p>
                        ) : null}
                    </div>
                </div>
            </div>
            {actions ? (
                <div className="flex w-full flex-wrap items-center gap-2 sm:w-auto sm:justify-end">{actions}</div>
            ) : null}
        </div>
    );
}
