import { defaultWagmiConfig } from '@web3modal/wagmi/react/config'

import { cookieStorage, createStorage } from 'wagmi'
import { avalancheFuji } from 'wagmi/chains'
import { type Chain } from 'viem'

// Get projectId at https://cloud.walletconnect.com
export const projectId = process.env.NEXT_PUBLIC_PROJECT_ID

if (!projectId) throw new Error('Project ID is not defined')

const metadata = {
  name: 'Web3Modal',
  description: 'Web3Modal Example',
  url: 'https://web3modal.com', // origin must match your domain & subdomain
  icons: ['https://avatars.githubusercontent.com/u/37784886']
}

export const echo = {
  id: 78430,
  name: 'Echo Subnet',
  nativeCurrency: {
    decimals: 18,
    name: 'ECH',
    symbol: 'ECH'
  },
  rpcUrls: {
    public: { http: ['https://subnets.avax.network/echo/testnet/rpc'] },
    default: { http: ['https://subnets.avax.network/echo/testnet/rpc'] }
  },
  blockExplorers: {
    default: { name: 'avax-explorer', url: 'https://subnets-test.avax.network/echo' },
  },

}as const satisfies Chain

// Create wagmiConfig
export const config = defaultWagmiConfig({
  chains: [echo, avalancheFuji], // required
  projectId, // required
  metadata, // required
  ssr: true,
  storage: createStorage({
    storage: cookieStorage
  }),
  enableWalletConnect: true, // Optional - true by default
  enableInjected: true, // Optional - true by default
  enableEIP6963: true, // Optional - true by default
  enableCoinbase: true // Optional - true by default
})
