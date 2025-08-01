// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    constructor(uint256 x) {
        number = x;
    }

    function increment() public {
        number++;
    }
}
