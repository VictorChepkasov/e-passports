from brownie import EPFactory, accounts

def main():
    deployEpFactory()

def deployEpFactory():
    account = accounts.load('victor')
    print(f'Accounts: {account}')
    deployed = EPFactory.deploy({'from': account, "priority_fee": "1 wei"})

    print(f'Deployed seccesfull: {deployed}')

    return deployed