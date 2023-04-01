from brownie import Factory, accounts

def main():
    ep_deploy()

def ep_deploy():
    account = accounts.load('victor')
    deployed = Factory[-1].createEPassport('first_name',
                                           'last_name',
                                           'patronymic',
                                           'photo',
                                           'place_of_registration',
                                           0,
                                           2070509,
                                           {'from': account, "priority_fee": "1 wei"})

    print(f'Deployed(created) passport: {deployed}')