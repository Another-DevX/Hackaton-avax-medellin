import { ethers } from 'hardhat'

async function main () {
  const teleporterMessengerAddress =
    '0x253b2784c75e510dD0fF1da844684a1aC0aa5fcf'
  const destinationChainId =
    '0x1278d1be4b987e847be3465940eb5066c4604a7fbd6e086900823597d81af4c1'
  const destinationAddress = '0x6B09E65cfCac859d38fc7D629958891A4e9380C2'
  const hyperVayult = await ethers.deployContract('HyperVault', [
    teleporterMessengerAddress,
    destinationChainId,
    destinationAddress
  ])
  const hyperVaultResponse = await hyperVayult.waitForDeployment()

  console.debug(`HyperVault address: ${await hyperVaultResponse.getAddress()}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
