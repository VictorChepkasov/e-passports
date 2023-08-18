//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriageFactory.sol";
import "./ePassport.sol";

contract EPFactory {
    uint public totalPassports;
    mapping(uint => EPassport) public ePassports;
    mapping(address => EPassport) public epMapping;

    function createEPassport(
        address wallet,
        string memory firstName,
        string memory lastName,
        string memory patronymic,
        string memory photo,
        string memory placeOfRegistration,
        uint gender,
        uint dateOfBirth
    ) external {
        totalPassports++;
        EPassport ePassport = new EPassport(
            wallet,
            firstName,
            lastName,
            patronymic,
            photo,
            placeOfRegistration,
            gender,
            dateOfBirth,
            totalPassports
        );
        ePassports[totalPassports] = ePassport;
    }

    function getEPassport(uint id) external view returns(EPassport) {
        return ePassports[id]; 
    }

    function getEPassportsInfo(uint startElement, uint endElement) external view returns(EPassport.EPassportInfo[] memory) {
        require(startElement < endElement, "Incorrect range!");
        require(endElement <= totalPassports, "Incorrect end element index!");
        EPassport.EPassportInfo[] memory getPassports;
        for (uint i = startElement; i < endElement; i++) {
            getPassports[i] = ePassports[i].getPassportInfo(); 
        }
        return getPassports;
    }
}