// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/USDT.sol";

contract USDTTest is Test {
    USDT public usdt;

    function setUp() public {
        usdt = new USDT();

        console.log("Contract address :", address(usdt));
    }

    function testUSDT() public {
        console.log("Token name :", usdt.name());
        console.log("Token symbol :", usdt.symbol());
        console.log("Token decimals :", usdt.decimals());

        address mintAddress = address(0x1);
        uint256 mintAmount = 1000 * 10 ** usdt.decimals();

        uint256 beforeMintAmount = usdt.balanceOf(mintAddress);
        vm.prank(usdt.owner());
        usdt.mint(mintAddress, mintAmount);
        uint256 afterMintAmount = usdt.balanceOf(mintAddress);

        assertEq(mintAmount, afterMintAmount - beforeMintAmount);
        console.log("Mint passed");

        address transferAddress = address(0x2);
        uint256 transferAmount = 500 * 10 ** usdt.decimals();

        uint256 beforeTransferAmount = usdt.balanceOf(transferAddress);
        vm.prank(mintAddress);
        usdt.transfer(transferAddress, transferAmount);
        uint256 afterTransferAmount = usdt.balanceOf(transferAddress);

        assertEq(transferAmount, afterTransferAmount - beforeTransferAmount);
        console.log("Transfer passed");

        address burnAddress = transferAddress;
        uint256 burnAmount = 200 * 10 ** usdt.decimals();

        uint256 beforeBurnAmount = usdt.balanceOf(burnAddress);
        vm.prank(burnAddress);
        usdt.burn(burnAmount);
        uint256 afterBurnAmount = usdt.balanceOf(burnAddress);

        assertEq(burnAmount, beforeBurnAmount - afterBurnAmount);
        console.log("Self burn passed");

        beforeBurnAmount = usdt.balanceOf(burnAddress);
        vm.prank(usdt.owner());
        usdt.burn(burnAddress, burnAmount);
        afterBurnAmount = usdt.balanceOf(burnAddress);

        assertEq(burnAmount, beforeBurnAmount - afterBurnAmount);
        console.log("Owner burn passed");
    }
}
