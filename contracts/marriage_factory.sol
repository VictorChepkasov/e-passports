//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriage.sol";

contract MarriageFactory {
    uint totalMarriage;
    address epFactoryAddress;
    Marriage[] public marriages;
    mapping(address => mapping(address => Marriage)) public addressMarriage;

    constructor(address _epFactoryAddress) {
        epFactoryAddress = _epFactoryAddress;
    }

    function createMarriage(address partner,
        uint id,
        string memory creatorFullName,
        string memory partnerFullName
    ) external {
        totalMarriage++;
        Marriage marriage = new Marriage(partner, epFactoryAddress, id, creatorFullName, partnerFullName);
        marriages.push(marriage);
        addressMarriage[msg.sender][partner] = marriage;
    }

    function getMarriageInfo(uint id) public view returns(Marriage.MarriageInfo memory) {
        return marriages[id].getMarriageInfo();
    }

    function getAllMarriages() public view returns(Marriage[] memory) {
        return marriages;
    }
}