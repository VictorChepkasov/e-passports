//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriage.sol";

contract MarriageFactory {
    uint totalMarriage;
    Marriage[] public marriages;
    address epFactoryAddress;
    mapping(address => mapping(address => Marriage)) public addressMarriage;

    constructor(address _EPFAddress) {
        epFactoryAddress = _EPFAddress;
    }

    function createMarriage(address partner,
        uint id,
        string memory creator_full_name,
        string memory partner_full_name
    ) external {
        totalMarriage++;
        Marriage marriage = new Marriage(partner, epFactoryAddress, id, creator_full_name, partner_full_name);
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