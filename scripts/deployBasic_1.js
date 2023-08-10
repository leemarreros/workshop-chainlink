const { ethers } = require("hardhat");

async function main() {
  const BasicRandomNumber2 = await ethers.getContractFactory(
    "BasicRandomNumber2"
  );
  const basicRandomNumber2 = await BasicRandomNumber2.deploy();
  var tx = await basicRandomNumber2.deploymentTransaction();
  await tx.wait(10);

  var basicAddress = await basicRandomNumber2.getAddress();
  console.log("Basic deployed to:", basicAddress);

  // Add consumer to subscription
  var address = "0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed";
  var abi = ["function addConsumer(uint64,address) external"];
  var signer = await ethers.provider.getSigner();
  const vrfCoordinator = new ethers.Contract(address, abi, signer);

  var subscriptionId = 5507;
  var consumerAddress = basicAddress;
  await vrfCoordinator.addConsumer(subscriptionId, basicAddress);

  // verify smart contract
  await hre.run("verify:verify", {
    address: basicAddress,
    constructorArguments: [],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
