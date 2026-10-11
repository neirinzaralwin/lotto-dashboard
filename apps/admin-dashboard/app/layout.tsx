import type { Metadata } from 'next';
import { DM_Sans } from 'next/font/google';
import { AppProviders } from '@/components/providers';
import './globals.css';

const dmSans = DM_Sans({
    subsets: ['latin'],
    variable: '--font-dm-sans',
    display: 'swap',
    weight: ['400', '500', '600', '700'],
});

export const metadata: Metadata = {
    title: 'Win Search LOTO6•7 当選予想 検索',
    description: 'Win Search LOTO6•7 当選予想 検索 — Lotto 6 & Lotto 7 results admin',
    manifest: '/manifest.webmanifest',
    icons: {
        icon: [{ url: '/favicon.ico', sizes: 'any' }],
        apple: [{ url: '/apple-touch-icon.png', sizes: '180x180' }],
    },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
    return (
        <html lang="en" suppressHydrationWarning>
            <body
                className={`${dmSans.variable} antialiased`}
                style={{ fontFamily: 'var(--font-dm-sans), var(--font-sans)' }}
                suppressHydrationWarning
            >
                <AppProviders>{children}</AppProviders>
            </body>
        </html>
    );
}
