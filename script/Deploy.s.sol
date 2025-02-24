// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {safeconsole} from "forge-std/safeconsole.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

import {HelixboxBadge} from "../src/HelixboxBadge.sol";

contract Deploy is Script {
    address dao = 0xD0a0899c5dc2FEb253D57Ab0b7c6d1b1Fcbbf824;

    modifier broadcast() {
        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }

    function run() public broadcast {
        safeconsole.log("Chain Id: ", block.chainid);
        address proxy =
            Upgrades.deployUUPSProxy("HelixboxBadge.sol:HelixboxBadge", abi.encodeCall(HelixboxBadge.initialize, (dao)));
        safeconsole.log("Proxy: ", proxy);
        safeconsole.log("Logic: ", Upgrades.getImplementationAddress(proxy));
    }
}
