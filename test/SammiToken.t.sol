// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SammiToken} from "../src/SammiToken.sol";

contract SammiTokenTest is Test {
    SammiToken public sammiToken;
    address public _deployer;

    function setUp() public {
        // uint256 startGas = gasleft();
        sammiToken = new SammiToken();
        _deployer = sammiToken.deployer();
        // uint256 gasUsed = startGas - gasleft();
        // console.log("gasUsed : %s", gasUsed);
    }

    function test_mint_deployer() public {
        sammiToken.mint(_deployer, 100);
        assertEq(sammiToken.balanceOf(_deployer), 100);
    }

    function test_mint_user() public {
        address user1 = vm.addr(0x1111);
        address user2 = vm.addr(0x2222);
        address user3 = vm.addr(0x3333);

        //user mint
        sammiToken.mint(user1, 10);
        sammiToken.mint(user2, 9);
        sammiToken.mint(user3, 8);
        assertEq(sammiToken.balanceOf(user1), 10);
        assertEq(sammiToken.balanceOf(user2), 9);
        assertEq(sammiToken.balanceOf(user3), 8);

        //user transfer
        vm.prank(user1);
        sammiToken.transfer(user2, 5);
        assertEq(sammiToken.balanceOf(user1), 5);
        assertEq(sammiToken.balanceOf(user2), 14);

        vm.prank(user2);
        sammiToken.transfer(user3, 4);
        assertEq(sammiToken.balanceOf(user2), 10);
        assertEq(sammiToken.balanceOf(user3), 12);

        vm.prank(user3);
        sammiToken.transfer(user1, 3);
        assertEq(sammiToken.balanceOf(user1), 8);
        assertEq(sammiToken.balanceOf(user3), 9);

        //user approve
        vm.prank(user1);
        sammiToken.approve(user2, 3);
        assertEq(sammiToken.allowance(user1, user2), 3);

        vm.prank(user2);
        sammiToken.transferFrom(user1, user3, 2);
        assertEq(sammiToken.balanceOf(user1), 6);
        assertEq(sammiToken.balanceOf(user3), 11);

        vm.prank(user2);
        sammiToken.transferFrom(user1, user2, 1);
        assertEq(sammiToken.balanceOf(user1), 5);
        assertEq(sammiToken.balanceOf(user2), 11);
    }
}
