from brownie import EPFactory, accounts

def main():
    # getPassportInfo(0)
    getAllPassportsInfo()

def getPassportInfo(passportId):
    info = EPFactory[-1].callGetEPassport(passportId)
    print(f'Info about passport №{passportId}: {info}')
    return info

def getAllPassportsInfo():
    info = EPFactory[-1].getAllEPassports()
    print(f'Info about passports: \n {info}')
    return info