# Property Wrapper

## 🍎 Property Wrapper란 무엇인가?
- 프로퍼티를 감싸서 해당 프로퍼티에..
    - 범위 제한
    - 특정 로직을 프로퍼티 자체에 연결
- 위와 같이 **특정 기능**을 프로퍼티에 부여하는것
```swift
@Published, @State 이런것들을 Property Wrapper라고 한다.
```
- Combine에서 일반 프로퍼티를 퍼블리셔로 만들어 주는 @Published의 정의를 보자
![](https://i.imgur.com/aTV0MUb.png)

<!-- 
## 🍎 Property Wrapper를 사용할 수 있는 환경
- local stored variable에서만 사용 가능
 -->
 
## 🍎 직접 Property Wrapper를 만들어 사용 해보자
- class, struct, enum를 통해 Property Wrapper를 만들수 있다.
    - class / struct / enum 모두 프로퍼티를 가질수 있어서 가능.
### 전체적인 스토리
- 은행에 계좌를 개설할 때 적어도 1000원을 신규 계좌에 넣어야 한다.
- 계좌를 개설할 때 1000원 미만의 값이 들어오면 1000원으로 맞춰주는 역할을 하는 property wrapper를 만들어보자.

### @propertyWrapper로 감싼 ThousandOrMore 구조체 생성
```swift
@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    
    var wrappedValue: Int {
        get { return money }
        set { money = max(newValue, 1000) }
    }
}
```

### 은행 계좌 인스턴스를 생성할 BankAccount 구조체 생성
```swift
struct BankAccount {
    @ThousandOrMore var currentMoney: Int
}
```

### 계좌를 만들고 값을 넣어보자
```swift
var AccountForKay = BankAccount()
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "1000"

AccountForKay.currentMoney = 3000 // wrapperdValue.set으로 설정
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "3000"

AccountForKay.currentMoney = 500 // wrapperdValue.set으로 설정
print(AccountForKay.currentMoney) // wrappedValue.get으로 가져온다.
// Prints "1000"
```

## 🍎 만약 currentMoney에 초기값을 넣어주려면 어떻게 해야할까?
- 현재는 BankAccount를 생성하고 값을 넣어주는 형태이다.
- BankAccount 인스턴스를 생성할 때 돈을 넣어줄수는 없을까?
- 아래와 같이 생성자를 만들어 주면 된다!
```swift
@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    
    var wrappedValue: Int {
        get { return money }
        set { money = max(newValue, 1000) }
    }
    
    init(wrappedValue: Int) {
        money = max(wrappedValue, 1000)
    }
}
```
- 파라미터가 있는 생성자를 구현했으니 기본 생성자도 구현해주자!
```swift
@propertyWrapper
struct ThousandOrMore {
    private var money = 1000
    
    var wrappedValue: Int {
        get { return money }
        set { money = max(newValue, 1000) }
    }
    
    init() {
        
    }
    
    init(wrappedValue: Int) {
        money = max(wrappedValue, 1000)
    }
}
```

## 🍎 projectedValue
- ThousandOrMore 구조체 안에 projectedValue를 선언해 BankAccount의 currentMoney에 새로운 값을 저장하기 전, 조정이 되었는지 확인할 수 있다.
- 예제 코드를 보자.

```swift
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
```
