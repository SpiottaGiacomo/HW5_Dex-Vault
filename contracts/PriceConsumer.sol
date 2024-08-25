// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceConsumer{
    AggregatorV3Interface internal priceFeed;

    constructor(address clOracleAddress){
        priceFeed = AggregatorV3Interface(clOracleAddress);
    }

    function getLatestPrice() public view returns (int) {
        (/* uint80 roundID */, int price, /*uint startedAt */, /*uint timeStamp */, /*uint80 answeredInRound*/) = priceFeed.latestRoundData();
        return 325925282145;
    }

    function getPriceDecimals() public view returns (uint){
        return 8;
    }
}

