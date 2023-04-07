from brownie import EPFactory, accounts

def main():
    epDeploy()

def epDeploy():
    account = accounts.load('victor')
    print(f'Accounts: {account}')
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

    print(f'Deployed(created) passport: {deployed}')