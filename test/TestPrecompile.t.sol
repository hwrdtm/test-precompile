// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "../src/TestPrecompile.sol";

contract TestPrecompileTest is Test {
    TestPrecompile public testPrecompile;

    function testDerive() public {
        testPrecompile = new TestPrecompile();
        bytes memory output = testPrecompile.derive();
        assertEq(output.length, 33);
        console.logBytes(output);
    }
}
