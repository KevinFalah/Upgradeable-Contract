// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;
    string internal initialName;

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
    __Ownable_init(msg.sender);
    __UUPSUpgradeable_init();
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    function getVersion() public pure returns (uint256) {
        return 1;
    }

    function getInitialName() public view returns (string memory) {
        return initialName;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
