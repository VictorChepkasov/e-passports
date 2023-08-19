import pytest
from brownie import accounts, network
from scripts.deploy.epFactoryDeploy import deployEpFactory

@pytest.fixture(scope='session')
def owner():
    if network.show_active() != 'development':
        return accounts.load('victor')
    else:
        return accounts[0]
    
@pytest.fixture(scope='session')
def secondParty():
    if network.show_active() != 'development':
        return accounts.load('victor2')
    else:
        return accounts[1]

@pytest.fixture(scope='session')
def thirdParty():
    if network.show_active() != 'development':
        return accounts.load('third_party')
    else:
        return accounts[2]

@pytest.fixture
def epFactory(owner):
    return deployEpFactory(owner)