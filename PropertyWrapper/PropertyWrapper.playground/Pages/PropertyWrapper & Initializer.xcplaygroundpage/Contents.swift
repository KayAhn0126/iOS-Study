import UIKit

@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    
    var wrappedValue: Int {
        get { return money }
        set { money = max(newValue, 1000) }
    }
    
    init() {                                     // 파라미터를 이용한 생성자를 만들었으니 기본 생성자도 구현 해줘야 한다.
        
    }
    
    init(wrappedValue: Int) {                     // 초기값을 넣기위한 생성자 구현
        money = max(wrappedValue, 1000)
    }
}

struct BankAccount {
    @ThousandOrMore var currentMoney: Int = 5000 // ThousandOrMore 구조체의 init(wrappedValue: Int) 이니셜라이저를 사용해 생성.
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
