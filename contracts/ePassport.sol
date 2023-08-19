//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IEPassport.sol";

contract EPassport is IEPassport {
    EPassportInfo public ePassport;

    event CreatePassoport(uint indexed id, address wallet, string firstName);
    event Died(uint indexed id, address wallet, uint diedTime);

    modifier onlyOwner() {
        require(ePassport.owner == msg.sender, "Only Owner!");
        _;
    }

    modifier onlyAdult() {
        require(
            (block.timestamp - ePassport.dateOfBirth) / 31556926 >= 18,
            "You're not adult!"
        );
        _;
    }

    modifier onlyMarried() { 
        require(ePassport.married, "You're not marriend");
        _;
    }

    // Ah, ha, ha, ha, stayin' alive, stayin' alive
    modifier stayinALive() {
        require(!ePassport.died, "He has already died");
        _;
    }

    constructor(
        address wallet,
        string memory firstName,
        string memory lastName,
        string memory patronymic,
        string memory photo,
        string memory placeOfRegistration,
        uint gender,
        uint dateOfBirth,
        uint id
    ) {
        ePassport.owner = wallet;
        ePassport.firstName = firstName;
        ePassport.lastName = lastName;
        ePassport.patronymic = patronymic;
        ePassport.photo = photo;
        ePassport.placeOfRegistration = placeOfRegistration;
        ePassport.gender = gender;
        ePassport.dateOfBirth = dateOfBirth;
        ePassport.dateOfIssue = block.timestamp;
        ePassport.died = false;
        ePassport.id = id;
        ePassport.married = false;
        ePassport.wallets.push(wallet);

        emit CreatePassoport(ePassport.id, ePassport.owner, ePassport.firstName);
    }

    function getPassportInfo() external view returns(EPassportInfo memory) {
        return ePassport;
    }

    function setDied() public {
        ePassport.died = true;
        emit Died(ePassport.id, ePassport.owner, block.timestamp);
    }

    function addWallet(address wallet) public onlyOwner() stayinALive() {
        ePassport.wallets.push(wallet);
    }

    function updateName(
        string memory firstName,
        string memory lastName
    ) external stayinALive() onlyOwner() {
        ePassport.firstName = firstName;
        ePassport.lastName = lastName;
    }

    function updatePhoto(string memory photo) external stayinALive() onlyOwner() {
        ePassport.photo = photo;
    }
}