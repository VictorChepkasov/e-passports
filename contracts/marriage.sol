//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./passportsFactory.sol";

/* 
Очень простой (и не сильно проработанный) пример того, как можно совершенствовать контракт,
    добавляя разные модули.
Можно создать модули для взаимодействия между владельцем документа и налоговой,
    разными финансовыми системами и больницами.
В идеале некоторые данные должны подтягиваться из паспорта(допустим, имя, фамилия и отчество)
*/

contract Marriage {
    struct MarriageInfo {
        address creator;
        address partner;
        string creatorFullName; // имя, фамилия и отчество
        string partnerFullName;
        uint id;
        uint dateOfConclusion; //дата заключения договора
        uint dateOfCreatorConsent;
        uint dateOfPartnerConsent;
        bool creatorConsent;
        bool partnerConsent;
        bool valid; //находятся ли люди в браке?
    }
    
    MarriageInfo public marriage;
    EPFactory epFactoryAddress;
    event CreateMarriage(address creator, address partner, uint indexed id);
    
    modifier creatorConsent() {
        require(marriage.creatorConsent == true, "creator disagrees!");
        _;
    }

    modifier partnerConsent() {
        require(marriage.partnerConsent == true, "Partner disagrees!");
        _;
    }

    modifier onlyCreator() {
        require(msg.sender == marriage.creator, "Only Creator!");
        _;
    }

    modifier onlyPartner() {
        require(msg.sender == marriage.partner, "Only Partner!");
        _;
    }

    modifier onlyMarriage() {
        require(marriage.valid == true, "Only marriage!");
        _;
    }

    constructor(
        address creator, 
        address partner, 
        address _epFactoryAddress,
        uint id,
        string memory creatorFullName,
        string memory partnerFullName
    ) {
        marriage.creator = creator;
        marriage.partner = partner;
        marriage.creatorFullName = creatorFullName;
        marriage.partnerFullName = partnerFullName;
        marriage.id = id;
        // по умолчанию брак не действителен, после согласия двух сторон, он будет действителен
        marriage.valid = false; 

        epFactoryAddress = EPFactory(_epFactoryAddress);
    }

    function updatePartnerName(string memory partnerFullName) public onlyMarriage onlyPartner {
        marriage.partnerFullName = partnerFullName;
    }
    
    function updateCreatorName(string memory creatorFullName) public onlyMarriage onlyCreator {
        marriage.creatorFullName = creatorFullName;
    }

    function setMarriageInfo() public partnerConsent creatorConsent {
        marriage.valid = true;
        marriage.dateOfConclusion = block.timestamp;

        epFactoryAddress.epMapping(marriage.creator).updateMarried(true);

        emit CreateMarriage(marriage.creator, marriage.partner, marriage.id);
    }

    function setCreatorConsent() public onlyCreator {
        marriage.creatorConsent = true;
        marriage.dateOfCreatorConsent = block.timestamp;

        if (marriage.partnerConsent == true) {
            setMarriageInfo();
        }
    }

    function setPartnerConsent() public onlyPartner {
        marriage.partnerConsent = true;
        marriage.dateOfPartnerConsent = block.timestamp;

        if (marriage.creatorConsent == true) {
            setMarriageInfo();
        }
    }

    function getMarriageInfo() public view returns(MarriageInfo memory) {
        return marriage;
    }
}