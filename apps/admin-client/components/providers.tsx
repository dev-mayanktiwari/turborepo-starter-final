"use client";

import * as React from "react";
import { ThemeProvider as NextThemesProvider } from "next-themes";
import { WalletContextProvider } from "@/components/wallet-provider";

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <NextThemesProvider
      attribute="class"
      defaultTheme="system"
      enableSystem
      disableTransitionOnChange
      enableColorScheme
    >
      <WalletContextProvider>{children}</WalletContextProvider>
    </NextThemesProvider>
  );
}
