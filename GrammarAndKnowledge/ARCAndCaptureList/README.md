# ARC와 캡쳐리스트

[애플 공식 문서](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html) 기반 공부 후 정리

## 🍎 ARC
- ARC는 Swift의 메모리 관리 방법
    - class의 인스턴스를 생성하면 ARC는 인스턴스의 정보를 저장하기 위해 메모리를 할당한다.
    - 이에는 인스턴스의 타입, 저장 프로퍼티의 값이 담긴다. 
    - 인스턴스가 더 이상 필요하지 않다면 ARC는 인스턴스가 잡고있던 메모리를 해제시켜 다른 용도로 사용할 수 있게 한다.
    - 사용중인 인스턴스의 메모리를 해제시키면 인스턴스의 프로퍼티들과 인스턴스 메서드를 더이상 사용할 수 없고 만약 인스턴스에 접근한다면 앱은 크래시난다.
    - 인스턴스가 사용중 일때 해제 되는것을 방지하기 위해, ARC는 인스턴스를 참조하는 프로퍼티, 상수, 변수를 카운트한다.
    - 인스턴스를 참초하는 카운트가 하나라도 있다면 메모리에서 해제하지 않는다.

## 🍎 클래스 인스턴스 사이 강한 참조 순환
- 두 개의 클래스 인스턴스가 서로를 참조 하고 있어서 서로가 서로를 유지하는 상황.

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```

- Person 객체는 name(String), apartment(Apartment?) 프로퍼티를 가지고 있다.
    - 모든 사람이 아파트를 가지고 있는것은 아니기 때문에 옵셔널
- Apartment 객체 또한 unit(String), tenant(Person?) 프로퍼티를 가지고 있다.
    - 모든 아파트에 거주자가 있는것은 아니기 때문에 옵셔널
- 두 클래스 모두 소멸자가 구현되어있어 객체를 소멸 시킬때 예상대로 소멸 했는지 알 수 있다.

```swift
var john: Person?
var unit4A: Apartment?
```
- 현재는 두 객체 모두 nil 상태

```swift
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
```
- john에 Person 인스턴스를 할당
    - 이때 Person 인스턴스의 RC는 1이다. 왜?
    - 변수 john이 Person 인스턴스를 강한 참조하고 있기 때문에.
- unit4A에 Apartment 인스턴스를 할당
    - 이때 Apartment 인스턴스의 RC는 1이다. 왜?
    - 변수 unit4A가 Apartment 인스턴스를 강한 참조하고 있기 때문에.
- **위에서 이야기 한 것 처럼,**
    - **인스턴스가 사용중 일때 해제 되는것을 방지하기 위해, ARC는 인스턴스를 참조하는 프로퍼티, 상수, 변수를 카운트한다.**
- 이 과정을 마치고 나면 아래와 같은 그림을 가지고 있을것이다.

![](https://i.imgur.com/iTzMibo.png)


- 위의 사진을 보고 아래와 같이 이야기 할 수 있다.
    - john이라는 변수는 새로 생성된 Person 인스턴스에 대해 강한 참조를 하고있다.
    - unit4A라는 변수는 새로 생성된 Apartment인스턴스에 대해 강한 참조를 하고있다.

```swift
john!.apartment = unit4A
unit4A!.tenant = john
```
- john에게 unit4A라는 아파트를, 아파트에게는 john이라는 거주자를 할당(연결)한다.
- 이 과정을 마치고 나면 아래와 같은 그림을 가지고 있을것이다.

![](https://i.imgur.com/iNEsFJy.png)


- 현재 상황이 강한 참조 순환이다.
    - Person 인스턴스는 Apartment 인스턴스에 대해 강한 참조를 가지고있고, Apartment 인스턴스는 Person 인스턴스에 대해 강한 참조를 가지고 있다. 그러므로 각각의 인스턴스에 대해 john변수와 unit4A가 가지고 있는 강한 참조를 끊어 내더라도, RC는 0으로 떨어지지 않고, 인스턴스는 ARC에 의해 해제되지 않는다.

```swift=
john = nil
unit4A = nil
```
- 위의 코드처럼 두 변수(john과 unit4A)에 nil을 대입 하더라도 아래와 같은 그림처럼 두 인스턴스 사이의 강한 순환 참조가 메모리에서 해제되는것을 막고있고, 이것은 메모리 릭 으로 이어진다.

![](https://i.imgur.com/idbZdpx.png)


## 🍎 약한 참조 / 미소유 참조를 이용한 강한 순환 참조 문제 해결
- weak reference 언제 사용하나?
    - 다른 인스턴스의 라이프타임이 더 짧을 때 사용.
- unowned reference 언제 사용하나?
    - 다른 인스턴스의 라이프타임이 같거나 더 길때 사용.

### 📖 weak reference (약한 참조)
- 인스턴스에 대해 약한 참조를 하고있는 경우에도 인스턴스를 메모리에서 해제시킬 수 있다. 그러므로 참조하고 있는 인스턴스가 메모리에서 해제된다면 ARC가 nil로 세팅.
- **weak reference가 runtime에 nil로 변경 될 수 있기 때문에 변수 + 옵셔널로 선언한다.**
- ARC가 weak reference를 nil로 변경해도 프로퍼티 옵져버는 호출 되지 않는다.
- **약한 참조를 적용해 강한 참조 순환 문제 해결하기**
    - 사람은 아파트를 가지고 있을수 있다. 하지만 꼭 해당 아파트에 살 필요는 없으므로 Apartment의 tenant 프로퍼티의 라이프 사이클이 더 짧음을 알 수 있다.
```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```
- 아래의 코드는 이전처럼 두 변수를 각각의 인스턴스를 참조하도록 하고, 인스턴스끼리 참조하도록 구현.
```swift
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```
- 아래는 이 과정을 거치고 난 후 상태를 그림으로 표현
![](https://i.imgur.com/CFqwJEe.png)

- Person 인스턴스는 아직도 Apartment 인스턴스에 대해 강한 참조를 하고 있지만, Apartment 인스턴스는 Person 인스턴스에 대해 약한 참조를 하고있다. 이 뜻은 Person 인스턴스를 강한 참조하고 있는 john 변수를 nil로 셋팅했을때, Person 인스턴스의 Reference Count가 0이 됨에 따라 아래와 같이 Person 인스턴스가 메모리에서 해제된다.

```swift
john = nil // Prints "John Appleseed is being deinitialized"
```
- john이 더이상 Person 인스턴스를 참조하지 않음.

![](https://i.imgur.com/jrhcGYe.png)

```swift
unit4A = nil // Prints "Apartment 4A is being deinitialized"
```
- unit4A 변수가 더이상 Apartment 인스턴스를 참조하지 않음.

![](https://i.imgur.com/d02GSq4.png)


### 📖 unowned reference (미소유 참조)
- 약한 참조(weak reference)와 다르게 미소유 참조(unowned reference)는 참조하고 있는 인스턴스보다 더 긴 라이프사이클을 가질때 사용. -> 아래의 코드를 보고 이해해보자.

```swift
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
```

## 🍎 잠깐 정리!
- Person과 Apartment 코드에서 왜 Apartment의 tenant 프로퍼티가 weak var로 선언되었지?
    - 극단적인 예로 Person 인스턴스는 아파트를 가지고 있을 수 있지만 꼭 그 아파트에 살 필요는 없다.
    - 즉, tenant가 nil이 될 확률이 더 높다는 이야기.
    - apartment와 tenant 둘중 어떤것에도 weak를 붙여도 코드는 문제없이 돌아가지만 설정상 라이프 사이클이 짧은것에 붙임.
- Customer과 CreditCard 코드에서 왜 CreditCard class의 customer 클래스가 unowned일까?
    - unowned 키워드는 인스턴스의 라이프 사이클이 같거나 더 긴쪽에 붙인다.
    - 고객은 신용카드를 가지고 있을수도 있고 아닐수도 있지만, 신용카드는 항상 주인(고객)이 필요하다.
    - 즉 Customer의 라이프 사이클이 더 길기 때문에 customer 프로퍼티에 붙여 강한 참조 순환 문제 해결.



## 🍎 클로져에서 값을 캡쳐하기

## 🍎 Citation
[애플 공식 문서](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html)

