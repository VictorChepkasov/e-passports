from brownie import accounts, EPFactory, MarriageFactory

account = accounts.load('victor')
print(f'Accounts: {account}')

def main():
    # deployFactory()
    # deployEp()
    # getPassportInfo(0)
    # deployMarriageFactory()
    # marriageDeploy()
    getMarriageInfo(0)
    # getPassportInfo(0)


def deployFactory():
    deployed = EPFactory.deploy({'from': account, "priority_fee": "1 wei"})
    print(f'deploy ep-factory: {deployed}')
    return deployed

def deployEp():
    deployed = EPFactory[-1].createEPassport(
        account, 
        'first_name',
        'last_name',
        'patronymic',
        'photo',
        'place_of_registration',
        0,
        2070509,
        {'from': account, "priority_fee": "1 wei"})

    print(f'Created e-passport: {deployed}')

def getPassportInfo(passportId):
    info = EPFactory[-1].callGetEPassport(passportId)
    print(f'Info about passport №{passportId}: {info}')
    return info

def deployMarriageFactory():
    deployed = MarriageFactory.deploy(EPFactory[-1], {'from': account, "priority_fee": "1 wei"})
    print(f'Deployed Marriage Factory seccesfull: {deployed}')

    return deployed

def marriageDeploy():
    print(f'Accounts: {account}')
    deployed = MarriageFactory[-1].createMarriage( 
                                                  '0x5dE5F9e27BE687bF21f0795fA2D0359972739aB6',
                                                  'Victor',
                                                  'NonVictor',
                                                    {'from': account, "priority_fee": "1 wei"})

    print(f'Created marriage: {deployed}')

def getMarriageInfo(i):
    info = MarriageFactory[-1].getMarriageInfo(i)
    print(f'Marriage info: {info}')