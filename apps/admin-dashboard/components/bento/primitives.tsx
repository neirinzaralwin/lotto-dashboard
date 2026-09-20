import type { ReactNode } from 'react';

export function BentoCard({
    children,
    className = '',
    tone = 'surface',
}: {
    children: ReactNode;
    className?: string;
    tone?: 'surface' | 'ink' | 'muted' | 'excellent' | 'strong';
}) {
    const tones = {
        surface: 'bg-[var(--lotto-surface)] text-[var(--lotto-fg)]',
        ink: 'bg-[var(--lotto-fg)] text-[var(--lotto-bg)]',
        muted: 'bg-[var(--lotto-surface-muted)] text-[var(--lotto-fg)]',
        excellent: 'bg-[var(--lotto-excellent-soft)] text-[var(--lotto-fg)]',
        strong: 'bg-[var(--lotto-strong-soft)] text-[var(--lotto-fg)]',
    } as const;

    return (
        <section
            className={`flex flex-col rounded-[var(--lotto-radius)] border border-[var(--lotto-border)] p-6 md:p-7 ${tones[tone]} ${className}`}
        >
            {children}
        </section>
    );
}

export function CardLabel({ children, className = '' }: { children: ReactNode; className?: string }) {
    return (
        <p className={`text-[0.7rem] font-medium uppercase tracking-[0.16em] text-[var(--lotto-muted-soft)] ${className}`}>
            {children}
        </p>
    );
}

export function BigNumber({ children, className = '' }: { children: ReactNode; className?: string }) {
    return (
        <p className={`mt-3 text-[3.25rem] font-semibold leading-none tracking-[-0.04em] md:text-[3.75rem] ${className}`}>
            {children}
        </p>
    );
}

export function QuietText({ children, className = '' }: { children: ReactNode; className?: string }) {
    return <p className={`text-[0.95rem] leading-relaxed text-[var(--lotto-muted)] ${className}`}>{children}</p>;
}

/** Primitive score: filled/empty dots instead of a chart */
export function DotMeter({ filled, total = 5, accent = 'ink' }: { filled: number; total?: number; accent?: 'ink' | 'excellent' | 'strong' }) {
    const color =
        accent === 'excellent'
            ? 'bg-[var(--lotto-excellent)]'
            : accent === 'strong'
              ? 'bg-[var(--lotto-strong)]'
              : 'bg-[var(--lotto-fg)]';

    return (
        <div className="flex items-center gap-2" aria-hidden>
            {Array.from({ length: total }, (_, i) => (
                <span
                    key={i}
                    className={`h-2.5 w-2.5 rounded-full ${i < filled ? color : 'bg-[var(--lotto-border-strong)]'}`}
                />
            ))}
        </div>
    );
}

export function NumberBall({
    value,
    tone = 'ink',
    size = 'md',
}: {
    value: string | number;
    tone?: 'ink' | 'excellent' | 'strong' | 'ghost';
    size?: 'sm' | 'md' | 'lg';
}) {
    const tones = {
        ink: 'bg-zinc-200 text-zinc-800 ring-1 ring-inset ring-zinc-300/80',
        excellent: 'bg-[var(--lotto-excellent)] text-[var(--lotto-fg)]',
        strong: 'bg-[var(--lotto-strong)] text-white',
        ghost: 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]',
    } as const;

    const sizes = {
        sm: 'h-8 w-8 text-xs',
        md: 'h-8 w-8 text-xs sm:h-10 sm:w-10 sm:text-sm md:h-11 md:w-11 md:text-base',
        lg: 'h-10 w-10 text-sm sm:h-12 sm:w-12 sm:text-base md:h-14 md:w-14 md:text-lg',
    } as const;

    return (
        <span
            className={`inline-flex items-center justify-center rounded-full font-semibold tracking-tight ${tones[tone]} ${sizes[size]}`}
        >
            {value}
        </span>
    );
}

export function StatusPill({
    children,
    tone = 'neutral',
}: {
    children: ReactNode;
    tone?: 'neutral' | 'excellent' | 'strong' | 'caution';
}) {
    const tones = {
        neutral: 'bg-[var(--lotto-accent-soft)] text-[var(--lotto-fg)]',
        excellent: 'bg-[var(--lotto-excellent-soft)] text-[#8a4f28]',
        strong: 'bg-[var(--lotto-strong-soft)] text-[#2f5f3d]',
        caution: 'bg-[var(--lotto-caution-soft)] text-[#6b5f22]',
    } as const;

    return (
        <span className={`inline-flex items-center rounded-full px-3 py-1 text-[0.75rem] font-medium ${tones[tone]}`}>
            {children}
        </span>
    );
}
