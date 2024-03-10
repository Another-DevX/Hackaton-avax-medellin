import { ethers } from 'hardhat'

async function main () {
  const teleporterMessengerAddress =
    '0x253b2784c75e510dD0fF1da844684a1aC0aa5fcf'
  const destinationChainId =
    '0x1278d1be4b987e847be3465940eb5066c4604a7fbd6e086900823597d81af4c1'
  const destinationAddress = '0xb880139315372C44B930184f7B124Be8e5D63bc7'
  const mistic = await ethers.deployContract('Mystic', [
    teleporterMessengerAddress,
    destinationChainId,
    destinationAddress
  ])
  const misticResponse = await mistic.waitForDeployment()

  console.debug(`Mistic address: ${await misticResponse.getAddress()}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
