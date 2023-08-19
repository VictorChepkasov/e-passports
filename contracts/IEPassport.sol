//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEPassport {
    //куда вставить цифровые подписи?
    //31556926 - год в формате unix timestamp
    //совршеннолетие в 18
    struct EPassportInfo {
        address owner;
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
    function getPassportInfo() external view returns(EPassportInfo memory);
    function setDied() external;
    function addWallet(address wallet) external;
    function updateName(string memory firstName, string memory lastName) external;
    function updatePhoto(string memory photo) external;
}