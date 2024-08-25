// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface ITreasury {
    function withdraw(address _to, uint256 amount) external;
}