'use client';

import { ClipboardEvent, KeyboardEvent, useRef } from 'react';
import { useI18n } from '@/components/i18n/locale-provider';
import { applyPastedNumbers, parsePastedNumbers } from '@/lib/draws/parse-number-list';

export function NumberOtpInput({
    values,
    onChange,
    max,
    labelledBy,
    tone = 'main',
    size = 'md',
}: {
    values: number[];
    onChange: (next: number[]) => void;
    max: number;
    labelledBy: string;
    tone?: 'main' | 'bonus';
    size?: 'sm' | 'md';
}) {
    const { t } = useI18n();
    const refs = useRef<Array<HTMLInputElement | null>>([]);

    function focusAt(index: number) {
        const el = refs.current[index];
        if (!el) return;
        el.focus();
        el.select();
    }

    function commit(next: number[]) {
        onChange(next);
    }

    function handlePaste(index: number, e: ClipboardEvent<HTMLInputElement>) {
        e.preventDefault();
        const pasted = parsePastedNumbers(e.clipboardData.getData('text'));
        if (pasted.length === 0) return;
        const next = applyPastedNumbers(values, index, pasted);
        commit(next);
        const from = pasted.length >= values.length ? 0 : index;
        const last = Math.min(from + pasted.length, values.length) - 1;
        focusAt(Math.max(0, last));
    }

    function handleChange(index: number, raw: string) {
        const digits = raw.replace(/\D/g, '').slice(0, 2);
        const next = [...values];
        next[index] = digits ? Number.parseInt(digits, 10) : 0;
        commit(next);
        if (digits.length === 2 && index < values.length - 1) {
            focusAt(index + 1);
        }
    }

    function handleKeyDown(index: number, e: KeyboardEvent<HTMLInputElement>) {
        if (e.key === 'ArrowLeft' && index > 0) {
            e.preventDefault();
            focusAt(index - 1);
            return;
        }
        if (e.key === 'ArrowRight' && index < values.length - 1) {
            e.preventDefault();
            focusAt(index + 1);
            return;
        }
        if ((e.key === ' ' || e.key === 'Enter') && index < values.length - 1) {
            e.preventDefault();
            focusAt(index + 1);
            return;
        }
        if (e.key === 'Backspace' && !values[index] && index > 0) {
            e.preventDefault();
            const next = [...values];
            next[index - 1] = 0;
            commit(next);
            focusAt(index - 1);
        }
    }

    const counts = new Map<number, number>();
    for (const n of values) {
        if (n > 0) counts.set(n, (counts.get(n) ?? 0) + 1);
    }

    const shell =
        tone === 'bonus'
            ? 'border-[var(--lotto-excellent-soft)] bg-[var(--lotto-excellent-soft)]/35'
            : 'border-[var(--lotto-border)] bg-white';

    const box =
        size === 'sm'
            ? 'h-9 w-9 rounded-lg text-[0.75rem] sm:h-9 sm:w-9'
            : 'h-11 w-11 rounded-xl text-sm sm:h-12 sm:w-12';

    return (
        <div
            className={`flex flex-wrap ${size === 'sm' ? 'gap-1.5' : 'gap-2'}`}
            role="group"
            aria-labelledby={labelledBy}
        >
            {values.map((n, index) => {
                const invalid = n > 0 && (n > max || (counts.get(n) ?? 0) > 1);
                return (
                    <input
                        key={`${tone}-${index}`}
                        ref={(el) => {
                            refs.current[index] = el;
                        }}
                        inputMode="numeric"
                        pattern="[0-9]*"
                        autoComplete="off"
                        maxLength={2}
                        aria-label={
                            tone === 'bonus'
                                ? t('otp.bonusNumber', { n: index + 1 })
                                : t('otp.mainNumber', { n: index + 1 })
                        }
                        value={n > 0 ? String(n) : ''}
                        placeholder="–"
                        onPaste={(e) => handlePaste(index, e)}
                        onChange={(e) => handleChange(index, e.target.value)}
                        onKeyDown={(e) => handleKeyDown(index, e)}
                        onFocus={(e) => e.currentTarget.select()}
                        className={`${box} border text-center font-semibold tabular-nums outline-none transition-colors placeholder:text-[var(--lotto-muted-soft)] focus:border-[var(--lotto-fg)] focus:ring-2 focus:ring-[var(--lotto-fg)]/10 ${shell} ${
                            invalid ? 'border-[#b42318] text-[#b42318]' : 'text-[var(--lotto-fg)]'
                        }`}
                    />
                );
            })}
        </div>
    );
}
