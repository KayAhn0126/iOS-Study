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

![](https://i.imgur.com/VKrScH3.png)
- 위의 사진을 보고 아래와 같이 이야기 할 수 있다.
    - john이라는 변수는 새로 생성된 Person 인스턴스에 대해 강한 참조를 하고있다.
    - unit4A라는 변수는 새로 생성된 Apartment인스턴스에 대해 강한 참조를 하고있다.

```swift
john!.apartment = unit4A
unit4A!.tenant = john
```
- john에게 unit4A라는 아파트를, 아파트에게는 john이라는 거주자를 할당(연결)한다.
- 이 과정을 마치고 나면 아래와 같은 그림을 가지고 있을것이다.

![](https://i.imgur.com/Wkwl5Uq.png)

- 현재 상황이 강한 참조 순환이다.
    - Person 인스턴스는 Apartment 인스턴스에 대해 강한 참조를 가지고있고, Apartment 인스턴스는 Person 인스턴스에 대해 강한 참조를 가지고 있다. 그러므로 
## 🍎 클로져에서 값을 캡쳐하기

## 🍎 Citation

