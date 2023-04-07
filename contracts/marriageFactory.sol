//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriage.sol";

contract MarriageFactory {
    uint totalMarriage;
    address epFactoryAddress;
    Marriage[] public marriages;
    mapping(address => mapping(address => Marriage)) public addressMarriage;
    Marriage.MarriageInfo[] marriagesInfo;

    constructor(address _epFactoryAddress) {
        epFactoryAddress = _epFactoryAddress;
    }

    function createMarriage(
        address partner,
        string memory creatorFullName,
        string memory partnerFullName
    ) external {
        require(msg.sender != partner, "You can't marry yourself!");
        totalMarriage++;
        Marriage marriage = new Marriage(partner, epFactoryAddress, totalMarriage, creatorFullName, partnerFullName);
        marriages.push(marriage);
        addressMarriage[msg.sender][partner] = marriage;
    }

    function getMarriageInfo(uint id) public view returns(Marriage.MarriageInfo memory) {
        return marriages[id].getMarriageInfo();
    }

    function getAllMarriages() public view returns(Marriage.MarriageInfo[] memory) {
        Marriage.MarriageInfo[] memory allEPassports = marriagesInfo;
        
        for (uint i = 0; i < marriages.length; i++) {
            Marriage.MarriageInfo memory marriageInfo = marriages[i].getMarriageInfo();
            allEPassports[i] = marriageInfo; 
        }

        return allEPassports;
    }
}