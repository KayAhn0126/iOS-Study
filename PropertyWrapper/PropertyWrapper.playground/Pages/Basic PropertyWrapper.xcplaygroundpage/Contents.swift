import UIKit

@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    
    var wrappedValue: Int {
        get { return money }
        set { money = max(newValue, 1000) }
    }
}

struct BankAccount {
    @ThousandOrMore var currentMoney: Int
}

var AccountForKay = BankAccount()
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "1000"

AccountForKay.currentMoney = 3000 // wrapperdValue.set으로 설정
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "3000"

AccountForKay.currentMoney = 500 // wrapperdValue.set으로 설정
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "1000"
