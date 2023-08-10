const { ethers } = require("hardhat");

async function main() {
  const VotacionKeeper = await ethers.getContractFactory("VotacionKeeper");
  const votacionKeeper = await VotacionKeeper.deploy();
  var tx = await votacionKeeper.deploymentTransaction();
  await tx.wait(10);

  var votacionKeeperAddress = await votacionKeeper.getAddress();
  console.log("VotacionKeeper deployed to:", votacionKeeperAddress);

  // verify smart contract
  await hre.run("verify:verify", {
    address: votacionKeeperAddress,
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
  var VotacionKeeper = await ethers.getContractFactory("VotacionKeeperSol");
  var VotacionKeeperAddress = "0xC591efAd90bb503d4A07A6fe1B339D14d3581aEE";
  var votacionKeeper = await VotacionKeeper.attach(VotacionKeeperAddress);

  var [owner, alice] = await ethers.getSigners();
  await votacionKeeper.votar(1);
  await votacionKeeper.connect(alice).votar(1);
*/
