// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {DeployBox} from "script/DeployBox.s.sol";
import {UpgradeBox} from "script/UpgradeBox.s.sol";
import {BoxV1} from "src/BoxV1.sol";
import {BoxV2} from "src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    address proxy;
    UpgradeBox upgrader;

    function setUp() public {
        DeployBox deployer = new DeployBox();
        upgrader = new UpgradeBox();

        proxy = deployer.deployBox();
    }

    function testUpgrade() public {
        string memory expectedInitialName = "Box Version 2";
        BoxV2 newVersion = new BoxV2();
        bytes memory data = abi.encodeWithSignature(
            "initialize(string)",
            "Box Version 2"
        );
        upgrader.upgradeBox(proxy, address(newVersion), data);

        uint256 expectedValue = 2;
        uint256 version = BoxV2(proxy).getVersion();
        assert(expectedValue == version);

        BoxV2(proxy).setNumber(10);
        uint256 getNumber = BoxV2(proxy).getNumber();
        uint256 expectedNumber = 10;
        assert(expectedNumber == getNumber);

        string memory getName = BoxV2(proxy).getInitialName();
    }

    function testExpectRevertNoHaveFunction() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(5);
    }
}
