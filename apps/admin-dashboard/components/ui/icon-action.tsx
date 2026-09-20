import type { LucideIcon } from 'lucide-react';
import { AppIcon } from '@/components/ui/icon';

export function IconAction({
    label,
    icon,
    onClick,
    danger = false,
}: {
    label: string;
    icon: LucideIcon;
    onClick: () => void;
    danger?: boolean;
}) {
    return (
        <button
            type="button"
            title={label}
            aria-label={label}
            onClick={onClick}
            className={`inline-flex h-8 w-8 items-center justify-center rounded-md transition-colors ${
                danger
                    ? 'text-[var(--lotto-muted-soft)] hover:bg-[#f8e4e2] hover:text-[#b42318]'
                    : 'text-[var(--lotto-muted-soft)] hover:bg-[var(--lotto-accent-soft)] hover:text-[var(--lotto-fg)]'
            }`}
        >
            <AppIcon icon={icon} size={15} strokeWidth={1.5} />
        </button>
    );
}
