const { ethers } = require("hardhat");

async function main() {
  // USDC
  const USDC = await ethers.getContractFactory("USDC");
  const usdc = await USDC.attach("0xCc53008eCd213bdeF4C0b834cbcfBc2B214197bd");
  var usdcAddress = await usdc.getAddress();
  console.log("Usdc address:", usdcAddress);

  // Rifa
  const RifaDescentralizadaAfter = await ethers.getContractFactory(
    "RifaDescentralizadaAfter"
  );
  const rifaDescentralizadaAfter = await RifaDescentralizadaAfter.deploy(
    await usdc.getAddress()
  );
  var tx = await rifaDescentralizadaAfter.deploymentTransaction();
  await tx.wait(10);

  var rifaAddress = await rifaDescentralizadaAfter.getAddress();
  console.log("Rifa address:", rifaAddress);

  // Add consumer to subscription
  var address = "0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed";
  var abi = ["function addConsumer(uint64,address) external"];
  var signer = await ethers.provider.getSigner();
  const vrfCoordinator = new ethers.Contract(address, abi, signer);

  var subscriptionId = 5507;
  var consumerAddress = rifaAddress;
  await vrfCoordinator.addConsumer(subscriptionId, rifaAddress);

  // verify smart contract
  await hre.run("verify:verify", {
    address: rifaAddress,
    constructorArguments: [await usdc.getAddress()],
  });
}

/**
  Conectarte a Mumbai testnet desde el terminal
  npx hardhat console --network mumbai

  // Conectarte con el contrato en Mumbai
  var USDC = await ethers.getContractFactory("USDC");
  var usdcAddress = "0xCc53008eCd213bdeF4C0b834cbcfBc2B214197bd";
  var usdc = await USDC.attach(usdcAddress);

  var RifaDescentralizada = await ethers.getContractFactory("RifaDescentralizadaAfter");
  var RifaAddress = "0x97B31CA1D2686F28f5E13B79cB092e9b24073f30";
  var rifaDecentralizada = await RifaDescentralizada.attach(RifaAddress);

  // Creador de rifa le da permiso al contrato para transferir USDC
  // Comenzar aqui si se desea volver a crear rifa
  var premio = ethers.parseEther("1000")
  await usdc.approve(RifaAddress, premio)
  
  // Creador crea Rifa
  var premio = ethers.parseEther("1000")
  var precio = ethers.parseEther("10");
  var fechaFin = (await ethers.provider.getBlock()).timestamp + 60 * 2;
  var tx = await rifaDecentralizada.crearRifa(premio, precio, fechaFin);
  console.log(tx.hash);

  // Participar en Rifa
  var [owner, alice] = await ethers.getSigners();
    // Acuñar tokens a Alice
    await usdc.mint(alice.address, precio);
    // Alice aprueba al contrato para transferir USDC
    await usdc.connect(alice).approve(RifaAddress, precio);
    await usdc.connect(owner).approve(RifaAddress, precio);
  
  var creador = owner.address;
  var tx = await rifaDecentralizada.connect(owner).participarEnRifa(creador);
  var tx = await rifaDecentralizada.connect(alice).participarEnRifa(creador);

  // Finalizar Rifa
  await rifaDecentralizada.finalizarRifa(creador);
 */

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
