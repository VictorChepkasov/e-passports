import pytest
from conftest import *
from brownie import chain, network
from scripts.ePassportScripts import createPassport, getPassport

def test_getPassportInfo(owner, epFactory):
    createPassport(owner, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 0, chain.time())
    passportInfo = list(getPassport(1).getPassportInfo({
        'from': owner,
        'priority_fee': '10 wei'
    }))
    print(f'Passport info: {passportInfo}')
    passportInfo[8] //= 3600
    passportInfo[10] //= 3600
    if network.show_active() != 'development':
        ownerAddress = '0xB9a459a00855B0b82337E692D078d7292609701C'
    else:
        ownerAddress = accounts[0]
    validInfo = [ownerAddress, 'victor', 'Chickchirick', 'Chickchirickovich', './photo', 'Russia, Baikal', 1, 0, chain.time() // 3600, 0, chain.time() // 3600, False, False, (ownerAddress, )]
    assert passportInfo == validInfo

