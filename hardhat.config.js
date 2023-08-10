require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    mumbai: {
      url: process.env.MUMBAI_TESNET_URL,
      accounts: [
        process.env.PRIVATE_KEY || "",
        process.env.PRIVATE_KEY_2 || "",
      ],
      timeout: 0,
      gas: "auto",
      gasPrice: "auto",
    },
    sepolia: {
      url: process.env.SEPOLIA_TESNET_URL,
      accounts: [process.env.PRIVATE_KEY || ""],
      timeout: 0,
      gas: "auto",
      gasPrice: "auto",
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.API_KEY_POLYGONSCAN,
      sepolia: process.env.API_KEY_ETHERSCAN,
    },
  },
};
