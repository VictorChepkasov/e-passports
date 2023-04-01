from brownie import Factory, accounts

def main():
    getPassportsInfo(0)

def getPassportsInfo(passportId):
    info = Factory[-1].callGetEPassport(passportId)
    print(f'Info about passport №{passportId}: {info}')
    return info