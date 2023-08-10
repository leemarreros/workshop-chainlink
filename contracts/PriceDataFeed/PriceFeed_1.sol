// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeed_1 {
    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    address ethUsdAgg = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    AggregatorV3Interface internal dataEthUs = AggregatorV3Interface(ethUsdAgg);

    function getRatioEthUsd() public view returns (int, uint256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataEthUs.latestRoundData();

        uint256 decimals = dataEthUs.decimals();
        return (answer, decimals);
    }

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
     */
    address btcUsdAgg = 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22;
    AggregatorV3Interface internal dataBtcUs = AggregatorV3Interface(btcUsdAgg);

    function getRatioBtcUsd() public view returns (int, uint256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataBtcUs.latestRoundData();

        uint256 decimals = dataBtcUs.decimals();
        return (answer, decimals);
    }
}
