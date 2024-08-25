// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IError{
    error notSimpleDEX();
    error ethNotSent();
    error notMinter();
    error notEnoughBalance();
    error invalidAddress();
    error invalidTreasuryAddress();
    error invalidAmount();
    error invalidUserBalance();
}