// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/USDT.sol";

contract USDTScript is Script {
    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        USDT usdt = new USDT();

        console.log("Contract address :", address(usdt));

        vm.stopBroadcast();
    }
}
