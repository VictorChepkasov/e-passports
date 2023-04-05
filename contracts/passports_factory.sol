//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./marriage_factory.sol";
import "./e-passport.sol";

contract EPFactory {
    uint totalPassports;
    // uint totalPersons; - эта перменная была бы полезна для переписи населения
    EPassport[] public e_passports;
    mapping(address => EPassport) public ep_mapping;

    function createEPassport(string memory first_name,
        string memory last_name,
        string memory patronymic,
        string memory photo,
        string memory place_of_registration,
        uint gender,
        uint date_of_birth
    ) external {
        totalPassports++;
        EPassport e_passport = new EPassport(first_name,
        last_name,
        patronymic,
        photo,
        place_of_registration,
        gender,
        date_of_birth, totalPassports);
        e_passports.push(e_passport);
        ep_mapping[msg.sender] = e_passport;
    }

    function callUpdatePassportInfo(uint id,
        string memory first_name,
        string memory last_name,
        string memory photo
    ) external {
        e_passports[id].updatePassportInfo(first_name, last_name, photo);
    }

    function callAddWallet(uint id, address wallet) external {
        e_passports[id].addWallet(wallet);
    }

    function callDied(uint id) external {
        e_passports[id].died();
    }

    function callGetEPassport(uint id) external view returns(EPassport.EPassportInfo memory) {
        return e_passports[id].getPassportInfo();
    }

    function getAllEPassports() external view returns(EPassport[] memory) {
        return e_passports;
    }
}