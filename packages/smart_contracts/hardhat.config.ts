import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

const config: HardhatUserConfig = {
  solidity: '0.8.18',
  networks: {
    echo: {
      url: 'https://subnets.avax.network/echo/testnet/rpc',
      chainId: 173750,
      accounts: [
        '0xd02eea6052529458cca873975cf6b226a92282758784a2e06d6733aa45ea47b9'
      ]
    },
    'c-chain': {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      chainId: 43113,
      accounts: [
        '0xd02eea6052529458cca873975cf6b226a92282758784a2e06d6733aa45ea47b9'
      ]
    }
  }
}

export default config
