const { ethers } = require("hardhat");

async function main() {
  const PriceFeed_1 = await ethers.getContractFactory("PriceFeed_1");
  const priceFeed_1 = await PriceFeed_1.deploy();
  var tx = await priceFeed_1.deploymentTransaction();
  await tx.wait(10);

  var basic2Address = await priceFeed_1.getAddress();
  console.log("PriceFeed_1 deployed to:", basic2Address);

  // Add consumer to subscription

  // verify smart contract
  await hre.run("verify:verify", {
    address: basic2Address,
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
