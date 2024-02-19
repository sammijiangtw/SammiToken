// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SammiToken} from "../src/SammiToken.sol";

contract SammiTokenScript is Script {
    function setUp() public {}

    function run() public {
        // vm.broadcast();

        vm.startBroadcast();
        SammiToken st = new SammiToken();
        vm.stopBroadcast();
    }
}
