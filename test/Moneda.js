const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Hackeando Moneda", function () {
  async function deployFixture() {
    const [owner, otherAccount] = await ethers.getSigners();
    const initialBalance = ethers.parseEther("10");

    const Moneda = await ethers.getContractFactory("Moneda");
    const moneda = await Moneda.deploy({ value: initialBalance });

    const HackerMoneda = await ethers.getContractFactory("HackerMoneda");
    const hackerMoneda = await HackerMoneda.deploy(await moneda.getAddress(), {
      value: initialBalance,
    });

    return { moneda, hackerMoneda, owner, otherAccount };
  }

  describe("Attack", function () {
    it("Should set the right unlockTime", async function () {
      const { moneda, hackerMoneda } = await loadFixture(deployFixture);
      var ethBalance;

      const hackerAddress = await hackerMoneda.getAddress();
      ethBalance = await ethers.provider.getBalance(hackerAddress);
      console.log("Ether Balance 0", ethBalance.toString());

      await hackerMoneda.attack();
      ethBalance = await ethers.provider.getBalance(hackerAddress);
      console.log("Ether Balance 1", ethBalance.toString());

      await hackerMoneda.attack();
      ethBalance = await ethers.provider.getBalance(hackerAddress);
      console.log("Ether Balance 2", ethBalance.toString());

      await hackerMoneda.attack();
      ethBalance = await ethers.provider.getBalance(hackerAddress);
      console.log("Ether Balance 3", ethBalance.toString());
    });
  });
});
