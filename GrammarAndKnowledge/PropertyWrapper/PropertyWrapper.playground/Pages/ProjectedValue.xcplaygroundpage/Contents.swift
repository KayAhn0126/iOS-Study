import Foundation

// projectedValue 프로퍼티로 값이 변화했는지 확인하는 코드
@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    private(set) var projectedValue: Bool // <- 꼭 이렇게 선언해야 한다.
    
    var wrappedValue: Int {
        get { return money }
        set {
            if newValue < 1000 {
                money = 1000
                projectedValue = true
            } else {
                money = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.money = 1000
        self.projectedValue = false
    }
}

struct BankAccount {
    @ThousandOrMore var currentMoney: Int
}

var someAccount = BankAccount()
someAccount.currentMoney = 0
print(someAccount.$currentMoney) // true
print(someAccount.currentMoney) // 1000
