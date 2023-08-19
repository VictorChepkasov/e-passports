from brownie import EPFactory

def main():
    deployEpFactory()

def deployEpFactory(_from):
    print(f'Accounts: {_from}')
    deployed = EPFactory.deploy({'from': _from, "priority_fee": "1 wei"})
    print(f'Deployed seccesfull: {deployed}')
    return deployed