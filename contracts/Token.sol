// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IError.sol";
import "./interfaces/IToken.sol";

contract Token is ERC20, Ownable, IError, IToken{

    address public minterAddress;

    constructor(string memory _tokenName, 
                string memory _tokenSymbol,
                uint256 _supply) ERC20(_tokenName, _tokenSymbol) Ownable(msg.sender){
                    _mint(msg.sender, _supply*(1e18));
                }

    modifier onlyMinter () {
        if(msg.sender != minterAddress) {
            revert notMinter() ;
        }
        _;
    }

    function setMinter(address minter) external onlyOwner{
        if (minter == address(0)){
            revert invalidAddress();
        }
        minterAddress = minter;
    }
    
    function mint(address _to, uint256 _amount) external onlyOwner{
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) external onlyMinter{
        _burn(_from, _amount);
    }
}