# Solidity API

## Token

### minterAddress

```solidity
address minterAddress
```

### constructor

```solidity
constructor(string _tokenName, string _tokenSymbol, uint256 _supply) public
```

### onlyMinter

```solidity
modifier onlyMinter()
```

### setMinter

```solidity
function setMinter(address minter) external
```

### mint

```solidity
function mint(address _to, uint256 _amount) external
```

### burn

```solidity
function burn(address _from, uint256 _amount) external
```

## IError

### notSimpleDEX

```solidity
error notSimpleDEX()
```

### ethNotSent

```solidity
error ethNotSent()
```

### notMinter

```solidity
error notMinter()
```

### notEnoughBalance

```solidity
error notEnoughBalance()
```

### invalidAddress

```solidity
error invalidAddress()
```

### invalidTreasuryAddress

```solidity
error invalidTreasuryAddress()
```

### invalidAmount

```solidity
error invalidAmount()
```

### invalidUserBalance

```solidity
error invalidUserBalance()
```

## IToken

### mint

```solidity
function mint(address _to, uint256 _amount) external
```

### burn

```solidity
function burn(address _from, uint256 _amount) external
```

## Treasury

### owner

```solidity
address owner
```

### simpleDexAddress

```solidity
address simpleDexAddress
```

### constructor

```solidity
constructor(address SimpleDEX) public
```

### receive

```solidity
receive() external payable
```

### onlySimpleDEX

```solidity
modifier onlySimpleDEX()
```

### withdraw

```solidity
function withdraw(address to, uint256 amount) external
```

## ITreasury

### withdraw

```solidity
function withdraw(address _to, uint256 amount) external
```

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

## SimpleDex

### token

```solidity
address token
```

### externalTreasury

```solidity
address externalTreasury
```

### ethUsdContract

```solidity
contract PriceConsumer ethUsdContract
```

### ethPriceDecimals

```solidity
uint256 ethPriceDecimals
```

### ethPrice

```solidity
uint256 ethPrice
```

### Bought

```solidity
event Bought(uint256 amount)
```

### Sold

```solidity
event Sold(uint256 amount)
```

### constructor

```solidity
constructor(address _token, address oracleEthUsdPrice) public
```

### receive

```solidity
receive() external payable
```

### setTreasury

```solidity
function setTreasury(address _treasury) external
```

### treasuryMovs

```solidity
function treasuryMovs(address to, uint256 _amount) internal
```

### buyToken

```solidity
function buyToken() public payable
```

### sellToken

```solidity
function sellToken(uint256 amountToSell) public
```

### emergencyTransfer

```solidity
function emergencyTransfer(address _token, uint256 _amount, address _recipient) external
```

