//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EPassport {
    //куда вставить цифровые подписи?
    //31556926 - год в формате unix timestamp
    //совршеннолетие в 18
    struct EPassportInfo {
        address wallet;
        string first_name;
        string last_name;
        string patronymic; //отчество
        string photo;
        string place_of_registration; //адрес проживания
        uint id; //id - уникальный идентификатор паспорта
        uint gender; //0 - male, 1 - female
        uint date_of_birth; 
        uint date_of_death; //если не умер, то 0
        uint date_of_issue; //дата выдачи паспорта
        bool married; 
        bool died;
        address[] wallets;
    }

    EPassportInfo private e_passport;
    event CreatePassoport(uint indexed id, address wallet, string first_name);
    event Died(uint indexed id, address wallet, uint diedTime);

    modifier onlyOwner() {
        require(e_passport.wallet == msg.sender, "Only Owner!");
        _;
    }

    modifier onlyAdult() {
        require((block.timestamp - e_passport.date_of_birth) / 31556926 >= 18, "You're not adult!");
        _;
    }

    modifier onlyMarried() { 
        require(e_passport.married, "You're not marriend");
        _;
    }

    // Ah, ha, ha, ha, stayin' alive, stayin' alive
    modifier stayinALive() {
        require(!e_passport.died, "He has already died");
        _;
    }

    constructor(string memory first_name,
        string memory last_name,
        string memory patronymic,
        string memory photo,
        string memory place_of_registration,
        uint gender,
        uint date_of_birth,
        uint id
    ) {
        e_passport.wallet = msg.sender;
        e_passport.first_name = first_name;
        e_passport.last_name = last_name;
        e_passport.patronymic = patronymic;
        e_passport.photo = photo;
        e_passport.place_of_registration = place_of_registration;
        e_passport.gender = gender;
        e_passport.date_of_birth = date_of_birth;
        e_passport.date_of_issue = block.timestamp;
        e_passport.died = false;
        e_passport.id = id;
        e_passport.married = false;
        e_passport.wallets.push(msg.sender);

        emit CreatePassoport(e_passport.id, e_passport.wallet, e_passport.first_name);
    }

    function updatePassportInfo(string memory first_name,
        string memory last_name,
        string memory photo
    ) public stayinALive() onlyOwner() {
        e_passport.first_name = first_name;
        e_passport.last_name = last_name;
        e_passport.photo = photo;
    }

    function died() public {
        e_passport.died = true;
        emit Died(e_passport.id, e_passport.wallet, block.timestamp);
    }

    function addWallet(address wallet) public onlyOwner() stayinALive() {
        e_passport.wallets.push(wallet);
    }

    function getPassportInfo() public view returns(EPassportInfo memory) {
        return e_passport;
    }
}