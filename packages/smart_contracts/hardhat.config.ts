import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

const config: HardhatUserConfig = {
  solidity: '0.8.18',
  networks: {
    fuji: {
      url: '​https://api.avax-test.network/ext/bc/C/rpc',
      chainId: 43113
    },
    amplify: {
      url: 'https://subnets.avax.network/amplify/testnet/rpc',
      chainId: 78430
    }
  }
}

export default config
