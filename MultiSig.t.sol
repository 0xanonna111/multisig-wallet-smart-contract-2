// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "./MultiSigWallet.sol";

contract MultiSigTest is Test {
    MultiSigWallet public wallet;
    address[] owners;
    address owner1 = address(1);
    address owner2 = address(2);
    address recipient = address(3);

    function setUp() public {
        owners.push(owner1);
        owners.push(owner2);
        wallet = new MultiSigWallet(owners, 2);
        vm.deal(address(wallet), 10 ether);
    }

    function testSubmitAndConfirm() public {
        vm.prank(owner1);
        wallet.submitTransaction(recipient, 1 ether);

        vm.prank(owner1);
        wallet.confirmTransaction(0);
        
        vm.prank(owner2);
        wallet.confirmTransaction(0);

        (,,,uint256 confirmations) = wallet.transactions(0);
        assertEq(confirmations, 2);
    }

    function testExecution() public {
        vm.prank(owner1);
        wallet.submitTransaction(recipient, 1 ether);
        vm.prank(owner1);
        wallet.confirmTransaction(0);
        vm.prank(owner2);
        wallet.confirmTransaction(0);

        vm.prank(owner1);
        wallet.executeTransaction(0);

        assertEq(recipient.balance, 1 ether);
    }
}
