import { ethers } from 'hardhat'

async function main () {
  const teleporterMessengerAddress =
    '0x253b2784c75e510dD0fF1da844684a1aC0aa5fcf'
  const dummyContract = await ethers.deployContract('DummyContract', [
    teleporterMessengerAddress
    
  ])

  const dummyContractResponse = await dummyContract.waitForDeployment()

  console.debug(
    `DummyContract address: ${await dummyContractResponse.getAddress()}`
  )
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error)
  process.exitCode = 1
})
