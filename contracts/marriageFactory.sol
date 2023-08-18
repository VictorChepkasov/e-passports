//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriage.sol";

contract MarriageFactory {
    uint public totalMarriage;
    address public epFactoryAddress;
    mapping(uint => Marriage) public marriages;
    mapping(address => mapping(address => Marriage)) public addressMarriage;

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
        Marriage marriage = new Marriage(msg.sender, partner, epFactoryAddress, totalMarriage, creatorFullName, partnerFullName);
        marriages[totalMarriage] = marriage;
        addressMarriage[msg.sender][partner] = marriage;
    }

    function getMarriageInfo(uint id) public view returns(Marriage.MarriageInfo memory) {
        return marriages[id].getMarriageInfo();
    }

    function getMarriagesInfo(uint startElement, uint endElement) public view returns(Marriage.MarriageInfo[] memory) {
        require(startElement < endElement, "Incorrect range!");
        require(endElement <= totalMarriage, "Incorrect end element index!");
        Marriage.MarriageInfo[] memory getMerriages;
        for (uint i = startElement; i < endElement; i++) {
            getMerriages[i] = marriages[i].getMarriageInfo(); 
        }
        return getMerriages;
    }
}