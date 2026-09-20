export type Locale = 'en' | 'ja';

export const LOCALES: { id: Locale; label: string; nativeLabel: string }[] = [
    { id: 'en', label: 'English', nativeLabel: 'English' },
    { id: 'ja', label: 'Japanese', nativeLabel: '日本語' },
];

export const DEFAULT_LOCALE: Locale = 'en';
export const LOCALE_STORAGE_KEY = 'lotto-admin-locale';

export type MessageTree = { [key: string]: string | MessageTree };

export function getMessage(
    tree: MessageTree,
    path: string,
    params?: Record<string, string | number>,
): string {
    const parts = path.split('.');
    let node: string | MessageTree | undefined = tree;
    for (const part of parts) {
        if (node == null || typeof node === 'string') {
            node = undefined;
            break;
        }
        node = node[part];
    }
    let text = typeof node === 'string' ? node : path;
    if (params) {
        for (const [k, v] of Object.entries(params)) {
            text = text.replaceAll(`{${k}}`, String(v));
        }
    }
    return text;
}
