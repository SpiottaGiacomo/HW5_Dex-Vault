// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IToken{
    function mint(address _to, uint256 _amount) external;
    function burn(address _from, uint256 _amount) external;
}