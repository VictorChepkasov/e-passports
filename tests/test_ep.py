import pytest
from conftest import *
from brownie import chain, network
from scripts.ePassportScripts import (
    createPassport,
    getPassport,
    addWallet,
    updateName,
    updatePhoto
)

def test_getPassportInfo(owner, epFactory):
    createPassport(owner, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 0, chain.time())
    passportInfo = list(getPassport(1).getPassportInfo({
        'from': owner,
        'priority_fee': '10 wei'
    }))
    print(f'Passport info: {passportInfo}')
    passportInfo[8] //= 3600
    passportInfo[10] //= 3600
    validInfo = [owner.address, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 1, 0, chain.time() // 3600, 0, chain.time() // 3600, False, False, (owner.address, )]
    assert passportInfo == validInfo

def test_getPassportsInfo(owner, secondParty, thirdParty, epFactory):
    createPassport(owner, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 0, chain.time())
    #создаём паспорта
    createPassport(secondParty, 'Sashka', 'Hahkovich', 'Aleksandrovich', './photo/sasha', 'Russia, Moscow', 0, chain.time() - 86400*2)
    createPassport(thirdParty, 'Vera', 'Beliver', 'Evgenievna', './photo/vera', 'Russia, Saint Peterburg', 1, chain.time() - 604800)

    #обработка данных
    for i in range(1, 4):
        passportInfo = list(getPassport(i).getPassportInfo({
            'from': owner,
            'priority_fee': '10 wei'
        }))
        print(f'Passport №{i} info: {passportInfo}')
        passportInfo[8] //= 3600
        passportInfo[10] //= 3600
        match i:
            case 1:
                validInfo = [owner.address, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 1, 0, chain.time() // 3600, 0, chain.time() // 3600, False, False, (owner.address, )]
            case 2:
                validInfo = [secondParty.address, 'Sashka', 'Hahkovich', 'Aleksandrovich', './photo/sasha', 'Russia, Moscow', 2, 0, (chain.time() - 86400*2) // 3600, 0, chain.time() // 3600, False, False, (secondParty.address, )]
            case 3:
                validInfo = [thirdParty.address, 'Vera', 'Beliver', 'Evgenievna', './photo/vera', 'Russia, Saint Peterburg', 3, 1, (chain.time() - 604800) // 3600, 0, chain.time() // 3600, False, False, (thirdParty.address, )]
        assert passportInfo == validInfo

def test_addWallet(owner, secondParty, epFactory):
    createPassport(owner, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 0, chain.time())
    addWallet(owner, 1, secondParty.address)
    passportInfo = list(getPassport(1).getPassportInfo({
        'from': owner,
        'priority_fee': '10 wei'
    }))
    assert (owner.address, secondParty.address) == passportInfo[-1]

def test_updateNameOrPhoto(owner, epFactory):
    createPassport(owner, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 0, chain.time())
    oldInfo = list(getPassport(1).getPassportInfo({
        'from': owner,
        'priority_fee': '10 wei'
    }))
    print(f"Passport №1 info: {oldInfo}")
    updateName(owner, 1, 'VICTORA', 'SECRET')
    updatePhoto(owner, 1, './photoh/victoriaSecret')
    info = list(getPassport(1).getPassportInfo({
        'from': owner,
        'priority_fee': '10 wei'
    }))
    info[8] //= 3600
    info[10] //= 3600
    validInfo = [owner.address, 'VICTORA', 'SECRET', 'Chickchirickovich', './photoh/victoriaSecret', 'Russia, Baikal', 1, 0, chain.time() // 3600, 0, chain.time() // 3600, False, False, (owner.address, )]
    assert info == validInfo