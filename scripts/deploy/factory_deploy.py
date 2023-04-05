from brownie import EPFactory, accounts

def main():
    deploy_factory()

def deploy_factory():
    account = accounts.load('victor')
    deployed = EPFactory.deploy({'from': account, "priority_fee": "1 wei"})

    print(f'Deployed seccesfull: {deployed}')

    return deployed