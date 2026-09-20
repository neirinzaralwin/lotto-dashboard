import { Suspense } from 'react';
import { DrawsManager } from '@/components/draws/draws-manager';

export default function DrawsPage() {
    return (
        <Suspense fallback={<p className="text-sm text-[var(--lotto-muted)]">Loading draws…</p>}>
            <DrawsManager />
        </Suspense>
    );
}
