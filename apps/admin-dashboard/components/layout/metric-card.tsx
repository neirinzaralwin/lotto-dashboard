import type { ReactNode } from 'react';

export function MetricCard({
    label,
    value,
    delta,
    hint,
}: {
    label: string;
    value: ReactNode;
    delta?: string;
    hint?: string;
}) {
    return (
        <div className="rounded-[var(--lotto-radius-sm)] border border-[var(--lotto-border)] bg-[var(--lotto-surface)] p-3.5 sm:rounded-[var(--lotto-radius)] sm:p-5">
            <div className="flex items-start justify-between gap-2">
                <p className="text-[0.72rem] font-medium leading-snug text-[var(--lotto-muted)] sm:text-[0.8rem]">
                    {label}
                </p>
                {delta ? (
                    <span className="inline-flex shrink-0 items-center rounded-full bg-[var(--lotto-delta-bg)] px-1.5 py-0.5 text-[0.65rem] font-semibold text-[var(--lotto-delta)] sm:px-2 sm:text-[0.7rem]">
                        {delta}
                    </span>
                ) : null}
            </div>
            <p className="mt-2.5 text-[1.65rem] font-semibold leading-none tracking-[-0.04em] sm:mt-4 sm:text-[2rem] md:text-[2.25rem]">
                {value}
            </p>
            {hint ? (
                <p className="mt-2 line-clamp-2 text-[0.7rem] text-[var(--lotto-muted-soft)] sm:mt-3 sm:text-xs">
                    {hint}
                </p>
            ) : null}
        </div>
    );
}
