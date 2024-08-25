# Solidity API

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

