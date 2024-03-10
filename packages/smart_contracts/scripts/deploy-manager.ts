import { ethers } from 'hardhat'

async function main () {
  const teleporterMessengerAddress =
    '0x253b2784c75e510dD0fF1da844684a1aC0aa5fcf'
  const destinationChainId =
    '0x7fc93d85c6d62c5b2ac0b519c87010ea5294012d1e407030d6acd0021cac10d5'
  const hyperVayultManager = await ethers.deployContract('HyperVaultManager', [
    teleporterMessengerAddress,
    destinationChainId,
  ])
  const hyperVaultManagerResponse = await hyperVayultManager.waitForDeployment()

  console.debug(`HyperVaultManager address: ${await hyperVaultManagerResponse.getAddress()}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
