import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

const config: HardhatUserConfig = {
  solidity: '0.8.18',
  networks: {
    echo: {
      url: 'https://subnets.avax.network/echo/testnet/rpc',
      chainId: 173750
    },
    'c-chain': {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      chainId: 43113
    }
  }
}

export default config
