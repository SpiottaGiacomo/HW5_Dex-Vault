// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./PriceConsumer.sol";
import "./interfaces/IError.sol";
import "./interfaces/IToken.sol";
import "./interfaces/ITreasury.sol";

contract SimpleDex is Ownable, IError {

    address public token;
    address public externalTreasury;

    PriceConsumer public ethUsdContract;
    uint public ethPriceDecimals;
    uint256 public ethPrice;

    event Bought(uint amount);
    event Sold(uint amount);

    constructor(address _token, address oracleEthUsdPrice) Ownable(msg.sender) {
        token = _token;
        ethUsdContract = new PriceConsumer(oracleEthUsdPrice);
        ethPriceDecimals = ethUsdContract.getPriceDecimals();
    }

    receive() external payable {
        buyToken();
    }

    function setTreasury(address _treasury) external onlyOwner {
        if(_treasury == address(0)){
            revert invalidAddress();
        }

        externalTreasury = _treasury;
    }

    function treasuryMovs(address to, uint256 _amount) internal {
        (bool sent, ) = payable(to).call{value: _amount}("");
        if(!sent){
            revert ethNotSent();
        }
    }

    function buyToken() payable public {
        if(externalTreasury == address(0)) {
            revert invalidTreasuryAddress();
        }
        uint256 amountToBuy = msg.value;
        if(amountToBuy == 0){
            revert invalidAmount();
        }
 
        uint256 dexBalance = IERC20(token).balanceOf(address(this));

        // ethPrice = uint256(ethUsdContract.getLatestPrice());
        ethPrice = 325925282145;
        uint256 amountToSend = amountToBuy * ethPrice / (10 ** ethPriceDecimals);

        treasuryMovs(externalTreasury, amountToBuy);
        IToken(token).mint(msg.sender, amountToSend);

        emit Bought(amountToSend);
    }

    function sellToken(uint256 amountToSell) public {
        if(amountToSell == 0){
            revert invalidAmount();
        }
        if(IERC20(token).balanceOf(msg.sender) < amountToSell){
            revert invalidUserBalance();
        }
        // uint256 allowance = IERC20(token).allowance(msg.sender, address(this));
        // require(allowance >= amountToSell, "Check the selling quantity");
        
        ethPrice = 325925282145;
        uint256 amountToSend = amountToSell * (10 ** ethPriceDecimals) / ethPrice;

        IToken(token).burn(msg.sender, amountToSell);

        if(address(externalTreasury).balance < amountToSend) {
            revert notEnoughBalance();
        }

        ITreasury(externalTreasury).withdraw(msg.sender, amountToSend);

        emit Sold(amountToSell);
    }

    function emergencyTransfer(address _token, uint256 _amount, address _recipient) external onlyOwner {
        if (_token == address(0)) {
            (bool sent, ) = payable(_recipient).call{value: _amount}("");
            require(sent, "!sent");
        } else {
            SafeERC20.safeTransfer(IERC20(_token), _recipient, _amount);
        }
    }
}
