from brownie import MarriageFactory, EPFactory, accounts

def main():
    deployMarriageFactory()

def deployMarriageFactory():
    account = accounts.load('victor')
    print(f'Accounts: {account}')
    deployed = MarriageFactory.deploy(EPFactory[-1], {'from': account, "priority_fee": "1 wei"})

    print(f'Deployed seccesfull: {deployed}')

    return deployed