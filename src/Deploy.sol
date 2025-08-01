// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Counter.sol";

interface Hevm {
    function ffi(string[] calldata) external returns (bytes memory);
}

Hevm constant vm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

contract Deploy {
    Counter c;

    constructor() {
        c = Counter(deployContract("src/Counter.sol:Counter", abi.encode(uint256(1337))));
    }

    function echidna_counter_elite() public view returns (bool) {
        return c.number() < 1339;
    }

    function getCode(string memory contractPath) internal returns (bytes memory) {
        string[] memory inputs = new string[](3);
        inputs[0] = "sh";
        inputs[1] = "-c";
        inputs[2] = string(abi.encodePacked("forge inspect ", contractPath, " bytecode | tr -d '\\n'"));

        return vm.ffi(inputs);
    }

    function deployContract(string memory what, bytes memory args) internal returns (address addr) {
        bytes memory bytecode = abi.encodePacked(getCode(what), args);
        /// @solidity memory-safe-assembly
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(addr != address(0), "StdCheats deployCode(string,bytes): Deployment failed.");
    }
}
