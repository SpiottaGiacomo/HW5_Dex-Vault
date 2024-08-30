// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceConsumer{
    AggregatorV3Interface internal priceFeed;

    constructor(address clOracleAddress){
        priceFeed = AggregatorV3Interface(clOracleAddress);
    }

    function getLatestPrice() public view returns (int256) {
    ( /*uint80 roundID*/,
      int256 price,
      /*uint256 startedAt*/,
      /*uint256 timeStamp*/,
      /*uint80 answeredInRound*/ 
    )= priceFeed.latestRoundData();
    return price;
  }

    function getPriceDecimals() public view returns (uint) {
    return uint(priceFeed.decimals());
  }
}

