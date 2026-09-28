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
    title: 'Lotto Admin',
    description: 'Calm intelligence — Lotto 6 & Lotto 7 results admin',
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
