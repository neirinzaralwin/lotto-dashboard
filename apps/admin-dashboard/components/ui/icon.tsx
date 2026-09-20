import type { LucideIcon, LucideProps } from 'lucide-react';

/** Global icon defaults — use Lucide everywhere in admin-dashboard. */
export const iconDefaults = {
    size: 18,
    strokeWidth: 1.75,
} as const;

export type AppIconProps = LucideProps & {
    icon: LucideIcon;
};

export function AppIcon({ icon: Icon, size = iconDefaults.size, strokeWidth = iconDefaults.strokeWidth, ...rest }: AppIconProps) {
    return <Icon size={size} strokeWidth={strokeWidth} aria-hidden {...rest} />;
}
