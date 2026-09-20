'use client';

import { useI18n } from '@/components/i18n/locale-provider';

export default function AlgorithmsPage() {
    const { t } = useI18n();
    return (
        <div className="space-y-3">
            <h1 className="text-2xl font-semibold">{t('algorithms.title')}</h1>
            <p className="text-[var(--lotto-muted)]">{t('algorithms.subtitle')}</p>
        </div>
    );
}
