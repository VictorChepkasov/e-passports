from brownie import EPFactory, accounts

def main():
    getPassportsInfo(0)

def getPassportsInfo(passportId):
    info = EPFactory[-1].callGetEPassport(passportId)
    print(f'Info about passport №{passportId}: {info}')
    return info