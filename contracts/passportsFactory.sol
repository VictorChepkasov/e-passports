//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriageFactory.sol";
import "./ePassport.sol";

contract EPFactory {
    uint totalPassports;
    EPassport[] public ePassports;
    mapping(address => EPassport) public epMapping;
    EPassport.EPassportInfo[] ePassportsInfo;

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
        dateOfBirth, totalPassports);
        ePassports.push(ePassport);
        epMapping[msg.sender] = ePassport;
    }

    function callUpdatePassportInfo(
        uint id,
        string memory firstName,
        string memory lastName,
        string memory photo
    ) external {
        ePassports[id].updatePassportInfo(firstName, lastName, photo);
    }

    function callAddWallet(uint id, address wallet) external {
        ePassports[id].addWallet(wallet);
    }

    function callDied(uint id) external {
        ePassports[id].setDied();
    }

    function callGetEPassport(uint id) external view returns(EPassport.EPassportInfo memory) {
        return ePassports[id].getPassportInfo();
    }

    function getAllEPassports() external view returns(EPassport.EPassportInfo[] memory) {
        EPassport.EPassportInfo[] memory allEPassports = ePassportsInfo;
        
        for (uint i = 0; i < ePassports.length; i++) {
            EPassport.EPassportInfo memory epInfo = ePassports[i].getPassportInfo();
            allEPassports[i] = epInfo; 
        }

        return allEPassports;
    }
}