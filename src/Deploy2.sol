// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Counter.sol";

interface Hevm {
    function ffi(string[] calldata) external returns (bytes memory);
}

Hevm constant vm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

contract Deploy2 {
    Counter c;

    constructor() {
        c = Counter(deployContract(abi.encode(uint256(1337))));
    }

    function echidna_counter_elite() public view returns (bool) {
        return c.number() < 1339;
    }

    function deployContract(bytes memory args) internal returns (address addr) {
        bytes memory bytecode = abi.encodePacked(type(Counter).creationCode, args);
        /// @solidity memory-safe-assembly
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(addr != address(0), "StdCheats deployCode(string,bytes): Deployment failed.");
    }
}
