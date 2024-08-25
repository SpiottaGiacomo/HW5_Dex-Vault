# Solidity API

## PriceConsumer

### priceFeed

```solidity
contract AggregatorV3Interface priceFeed
```

### constructor

```solidity
constructor(address clOracleAddress) public
```

### getLatestPrice

```solidity
function getLatestPrice() public view returns (int256)
```

### getPriceDecimals

```solidity
function getPriceDecimals() public view returns (uint256)
```

