'use client';

import type { LucideIcon } from 'lucide-react';
import { AppIcon } from '@/components/ui/icon';

export type UnderlineTab<T extends string> = {
    id: T;
    label: string;
    count?: number;
    icon?: LucideIcon;
};

export function UnderlineTabs<T extends string>({
    tabs,
    value,
    onChange,
}: {
    tabs: UnderlineTab<T>[];
    value: T;
    onChange: (id: T) => void;
}) {
    return (
        <div className="flex gap-6 overflow-x-auto border-b border-[var(--lotto-border)]">
            {tabs.map((tab) => {
                const active = tab.id === value;
                return (
                    <button
                        key={tab.id}
                        type="button"
                        onClick={() => onChange(tab.id)}
                        className={`relative inline-flex shrink-0 items-center gap-2 pb-3 text-sm transition-colors ${
                            active
                                ? 'font-semibold text-[var(--lotto-fg)]'
                                : 'font-medium text-[var(--lotto-muted)] hover:text-[var(--lotto-fg)]'
                        }`}
                    >
                        {tab.icon ? <AppIcon icon={tab.icon} size={15} strokeWidth={1.5} /> : null}
                        {tab.label}
                        {typeof tab.count === 'number' ? (
                            <span className="rounded-full bg-[var(--lotto-accent-soft)] px-2 py-0.5 text-[0.7rem] font-medium text-[var(--lotto-muted)]">
                                {tab.count}
                            </span>
                        ) : null}
                        {active ? (
                            <span className="absolute inset-x-0 -bottom-px h-[2px] rounded-full bg-[var(--lotto-fg)]" />
                        ) : null}
                    </button>
                );
            })}
        </div>
    );
}
