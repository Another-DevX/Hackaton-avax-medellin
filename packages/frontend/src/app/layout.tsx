import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';
import { ContextProvider } from '@/context';
import { cookieToInitialState } from 'wagmi'
import { headers } from 'next/headers'
import { config } from '@/config'

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'Create Next App',
  description: 'Generated by create next app',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const initialState = cookieToInitialState(config, headers().get('cookie'));
  return (
    <html lang='en'>
      <body className={inter.className}>
        <ContextProvider initialState={initialState}>
          {children}
        </ContextProvider>
      </body>
    </html>
  );
}
