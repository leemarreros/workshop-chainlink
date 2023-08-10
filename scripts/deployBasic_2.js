const { ethers } = require("hardhat");

async function main() {
  const BasicRandomNumber3 = await ethers.getContractFactory(
    "BasicRandomNumber3"
  );
  const basicRandomNumber3 = await BasicRandomNumber3.deploy();
  var tx = await basicRandomNumber3.deploymentTransaction();
  await tx.wait(10);

  var basic2Address = await basicRandomNumber3.getAddress();
  console.log("Basic deployed to:", basic2Address);

  // Add consumer to subscription
  var address = "0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed";
  var abi = ["function addConsumer(uint64,address) external"];
  var signer = await ethers.provider.getSigner();
  const vrfCoordinator = new ethers.Contract(address, abi, signer);

  var subscriptionId = 5507;
  var consumerAddress = basic2Address;
  await vrfCoordinator.addConsumer(subscriptionId, basic2Address);

  // verify smart contract
  await hre.run("verify:verify", {
    address: basic2Address,
    constructorArguments: [],
  });
}

/**
  Conectarte a Mumbai testnet desde el terminal
  npx hardhat console --network mumbai

  // Conectarte con el contrato en Mumbai
  var Basic2 = await ethers.getContractFactory("Basic2");
  var BasicAddress = "0xBB9bA1BBfe5114061fFbF0d643910b64BA4C0490";
  var basic2 = await Basic2.attach(BasicAddress);

  // Solicitar numero random
  var tx = await basic2.requestRandomWordsVRF();
  console.log(tx.hash);

  // Consultar lista de Ids
  var ids = await basic2.obtenerListaDeIds();

  // Usar ID para consultar pedido
  var pedido = await basic2.consultarPedido(ids[2]);
 */

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
