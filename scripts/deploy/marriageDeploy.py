from brownie import MarriageFactory, accounts

def main():
    marriageDeploy()

def marriageDeploy():
    account = accounts.load('victor')
    print(f'Accounts: {account}')
    deployed = MarriageFactory[-1].createMarriage('0x5dE5F9e27BE687bF21f0795fA2D0359972739aB6',
                                                  'Victor',
                                                  'NonVictor',
                                                    {'from': account, "priority_fee": "1 wei"})

    print(f'Deployed(created) marriage: {deployed}')