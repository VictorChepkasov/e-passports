//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EPassport {
    //куда вставить цифровые подписи?
    //31556926 - год в формате unix timestamp
    //совршеннолетие в 18
   struct EPassportInfo {
        address wallet;
        string firstName;
        string lastName;
        string patronymic; //отчество
        string photo;
        string placeOfRegistration; //адрес проживания
        uint id; //id - уникальный идентификатор паспорта
        uint gender; //0 - male, 1 - female
        uint dateOfBirth; 
        uint dateOfDeath; //если не умер, то 0
        uint dateOfIssue; //дата выдачи паспорта
        bool married; 
        bool died;
        address[] wallets;
    }

    EPassportInfo public ePassport;
    event CreatePassoport(uint indexed id, address wallet, string firstName);
    event Died(uint indexed id, address wallet, uint diedTime);

    modifier onlyOwner() {
        require(ePassport.wallet == msg.sender, "Only Owner!");
        _;
    }

    modifier onlyAdult() {
        require((block.timestamp - ePassport.dateOfBirth) / 31556926 >= 18, "You're not adult!");
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
        ePassport.wallet =  wallet;
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

        emit CreatePassoport(ePassport.id, ePassport.wallet, ePassport.firstName);
    }

    function updatePassportInfo(
        string memory firstName,
        string memory lastName,
        string memory photo
    ) public stayinALive() onlyOwner() {
        ePassport.firstName = firstName;
        ePassport.lastName = lastName;
        ePassport.photo = photo;
    }

    function updateMarried(bool married) external {
        ePassport.married = married;
    }

    function setDied() public {
        ePassport.died = true;
        emit Died(ePassport.id, ePassport.wallet, block.timestamp);
    }

    function addWallet(address wallet) public onlyOwner() stayinALive() {
        ePassport.wallets.push(wallet);
    }

    function getPassportInfo() public view returns(EPassportInfo memory) {
        return ePassport;
    }
}