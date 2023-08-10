const { ethers } = require("hardhat");

async function main() {
  const VotacionKeeper2 = await ethers.getContractFactory("VotacionKeeper2");
  const votacionKeeper2 = await VotacionKeeper2.deploy();
  var tx = await votacionKeeper2.deploymentTransaction();
  await tx.wait(10);

  var votacionKeeper2Address = await votacionKeeper2.getAddress();
  console.log("VotacionKeeper2 deployed to:", votacionKeeper2Address);

  // verify smart contract
  await hre.run("verify:verify", {
    address: votacionKeeper2Address,
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

/**
  Conectarte a Mumbai testnet desde el terminal
  npx hardhat console --network mumbai

  // Conectarte con el contrato en Mumbai
  const VotacionKeeper2 = await ethers.getContractFactory("VotacionKeeper2");
  var VotacionKeeper2Address = "0x3C060466a62055a49f2eaac8ac4855661ECEbeAa";
  var votacionKeeper2 = await VotacionKeeper2.attach(VotacionKeeper2Address);

  var [owner, alice] = await ethers.getSigners();
  await votacionKeeper2.votar(1);
  await votacionKeeper2.connect(alice).votar(1);
*/
