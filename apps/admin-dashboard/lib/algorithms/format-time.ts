/**
 * Lotto 6/7 are Japanese draws, so favourite timestamps are shown in Japan
 * time with the zone printed — "Mon, 10/19/2026, 00:48:45 GMT+9".
 */
export const FAVORITES_TIME_ZONE = 'Asia/Tokyo';

export function formatExactTime(iso: string | null | undefined, locale: string): string | null {
    if (!iso) return null;
    try {
        return new Intl.DateTimeFormat(locale, {
            timeZone: FAVORITES_TIME_ZONE,
            weekday: 'short',
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false,
            timeZoneName: 'short',
        }).format(new Date(iso));
    } catch {
        return iso;
    }
}

/** Toast clock — "00:48:45 GMT+9". */
export function formatClock(iso: string, locale: string): string {
    try {
        return new Intl.DateTimeFormat(locale, {
            timeZone: FAVORITES_TIME_ZONE,
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false,
            timeZoneName: 'short',
        }).format(new Date(iso));
    } catch {
        return iso;
    }
}
