from brownie import EPFactory

# def main():
    # getPassport(0)

def getPassport(passportId):
    info = EPFactory[-1].getEPassport(passportId)
    print(f'Passport №{passportId}: {info}')
    return info

def getPassportsInfo(_from, startElement, endElement):
    passportsInfo = EPFactory[-1].getEPassportsInfo(startElement, endElement, {
        'from': _from,
        'priority_fee': '10 wei'
    })
    print(f'Info about passports {startElement}-{endElement}: \n {info}')
    return passportsInfo

def createPassport(_from, firstName, lastName, patronymic, photo, placeOfRegistration, gender, dateOfBirth):
    EPFactory.createEPassport(firstName, lastName, patronymic, photo,placeOfRegistration, gender, dateOfBirth, {
        'from': _from,
        'priority_fee': '10 wei'
    })
    print('Passport created!')

def addWallet(_from, passportId, walletAddress):
    getPassport(passportId).addWallet(walletAddress, {
        'from': _from,
        'priority_fee': '10 wei'
    })
    print(f'{walletAddress} add to wallets passport №{passportId}')

def setDied(_from, passportId):
    getPassport(passportId).setDied({
        'from': _from,
        'priority_fee': '10 wei'
    })

def updateName(_from, passportId, firstName, lastName):
    getPassport(passportId).updateName(firstName, lastName, {
        'from': _from,
        'priority_fee': '10 wei'
    })
    print('Name updated!')

def updatePhoto(_from, passportId, photo):
    getPassport(passportId).updatePhoto(photo, {
        'from': _from,
        'priority_fee': '10 wei'
    })
    print('Photo updated!')