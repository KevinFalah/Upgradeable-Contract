// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV1} from "src/BoxV1.sol";
import {BoxV2} from "src/BoxV2.sol";

contract UpgradeBox is Script {
    function run() public returns (address) {
        vm.startBroadcast();
        address proxyAddress = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(proxyAddress, address(newBox), "");
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newVersion, bytes memory data) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress);
        proxy.upgradeToAndCall(newVersion, data);
        vm.stopBroadcast();

        return address(proxy);
    }
}