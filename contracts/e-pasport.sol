// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <=0.8.19;

contract EPassport {
    // куда вставить цифровые подписи?

    struct EPassportInfo {
        string first_name;
        string last_name;
        string patronymic; //отчество
        string photo;
        string place_of_registration; // адрес проживания

        uint id; //id - цникальный идентификатор паспорта
        uint gender; // 0 - male, 1 - female
        uint date_of_birth; 
        uint date_of_death; // если не умер, то 0
        uint date_of_issue; // дата выдачи паспорта

        bool married; 
        bool died;
        bool adult;
    }

    constructor (string memory first_name,
        string memory last_name,
        string memory patronymic,
        string memory photo,
        uint gender,
        uint date_of_birth
        ) {
        EPassportInfo memory e_passport;

        e_passport.first_name = first_name;
        e_passport.last_name = last_name;
        e_passport.patronymic = patronymic;
        e_passport.photo = photo;
        e_passport.gender = gender;
        e_passport.date_of_birth = date_of_birth;
        e_passport.date_of_issue = block.timestamp;
        e_passport.died = false;

        
    }

    // modifier onlyOwner() {
        // 
    // }
}