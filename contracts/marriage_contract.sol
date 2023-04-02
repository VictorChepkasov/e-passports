//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
        string creator_full_name; // имя, фамилия и отчество
        string partner_full_name;
        uint id;
        uint date_of_conclusion; //дата заключения договора
        uint date_of_creator_consent;
        uint date_of_partner_consent;
        bool creator_consent;
        bool partner_consent;
        bool valid; //находятся ли люди в браке?
    }
    
    MarriageInfo marriage;

    event CreateMarriage(address creator, address partner, uint indexed id);

    modifier creatorConsent() {
        require(marriage.creator_consent == true, "creator disagrees!");
        _;
    }

    modifier partnerConsent() {
        require(marriage.partner_consent == true, "Partner disagrees!");
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

    constructor(address partner,
        uint id,
        string memory creator_full_name,
        string memory partner_full_name
    ) {
        marriage.creator = msg.sender;
        marriage.partner = partner;
        marriage.creator_full_name = creator_full_name;
        marriage.partner_full_name = partner_full_name;
        marriage.id = id;
        // по умолчанию брак не действителен, после согласия двух сторон, он будет действителен
        marriage.valid = false; 
    }

    function updatePartnerName(string memory partner_full_name) public onlyMarriage onlyPartner {
        marriage.partner_full_name = partner_full_name;
    }
    
    function updateCreatorName(string memory creator_full_name) public onlyMarriage onlyCreator {
        marriage.creator_full_name = creator_full_name;
    }

    function setMarriageInfo() public partnerConsent creatorConsent {
        marriage.valid = true;
        marriage.date_of_conclusion = block.timestamp;

        emit CreateMarriage(marriage.creator, marriage.partner, marriage.id);
    }

    function setCreatorConsent() public onlyCreator {
        marriage.creator_consent = true;
        marriage.date_of_creator_consent = block.timestamp;

        if (marriage.partner_consent == true) {
            setMarriageInfo();
        }
    }

    function setPartnerConsent() public onlyPartner {
        marriage.partner_consent = true;
        marriage.date_of_partner_consent = block.timestamp;

        if (marriage.creator_consent == true) {
            setMarriageInfo();
        }
    }

    function getMarriageInfo() public view returns(MarriageInfo memory) {
        return marriage;
    }
}