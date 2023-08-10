const { ethers } = require("hardhat");

async function main() {
  var USDC = await ethers.getContractFactory("USDC");
  var usdcAddress = "0xCc53008eCd213bdeF4C0b834cbcfBc2B214197bd";
  var usdc = await USDC.attach(usdcAddress);

  var addresses = [
    "0x9c11A44a0f29707AFDEbFBB7EaefecDC04135B4B",
    "0xCc53008eCd213bdeF4C0b834cbcfBc2B214197bd",
    "0xca420cc41ccf5499c05ab3c0b771ce780198555e",
  ];
  for (const address of addresses) {
    await usdc.transfer(address, ethers.parseEther("10000"));
  }
  console.log("Completed!");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
