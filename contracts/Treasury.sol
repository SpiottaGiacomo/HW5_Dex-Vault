// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./interfaces/IError.sol";
import "./interfaces/ITreasury.sol";

contract Treasury is IError, ITreasury {
    address public owner;
    address public simpleDexAddress;

    constructor(address SimpleDEX){
        if(SimpleDEX == address(0)){
            revert invalidAddress();
        }
        owner = msg.sender;
        simpleDexAddress = SimpleDEX;
    }

    receive() payable external {}

    modifier onlySimpleDEX(){
        if(msg.sender != simpleDexAddress){
            revert notSimpleDEX();
        }
        _;
    }

    function withdraw(address to, uint amount) external onlySimpleDEX{
        (bool sent, ) = payable(to).call{value: amount}("");
        if(!sent){
            revert ethNotSent();
        }
    }

}