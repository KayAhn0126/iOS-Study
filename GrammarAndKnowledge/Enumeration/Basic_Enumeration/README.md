# Basic_Enumeration

## 🍎 열거형 기본
- 열거형은 대문자, 케이스는 소문자로 시작!
- 열거형의 데이터 멤버들은 정의(Definition) 개념으로 작성되는 것이므로 타입으로 사용할 수 있을 뿐만 아니라 컴파일러가 미리 인지할 수도 있다.
- 즉, 열거형을 이용해 데이터 타입을 정의하고 사용하면 오타나 실수가 발생했을 때 즉시 컴파일러가 오류를 찾아주므로 잘못된 점을 바로 확인할 수 있다.
- 언제 열거형을 사용하면 좋을까?
    - 원치 않는 값이 잘못 입력되는 것을 막고 싶을 때
    - 입력박을 값을 미리 특정할 수 있을 떄
    

## 🍎 원시값이 없는 열거형
```swift
enum Direction {
    case north
    case south
    case east
    case west
}
```
- 실제로 사용할 때는 Direction 열거형이 하나의 자료형이 되는것!
```swift
// 사용법
var myDirection: Direction = .north
```

## 🍎 원시값이 있는 열거형
- 원시값 == rawValue
- Int, Double, Character, String 가능
- 열거형 이름 옆에 type을 **꼭 명시**

### 📖 Int
```swift
enum Direction: Int {
    case north     // 0
    case south     // 1
    case east      // 2
    case west      // 3
    case center    // 4
}
```
- Int라는 타입은 enum 선언시 명시해주면 가장 먼저 선언된 case부터 0을 시작으로 1씩 증가된 값이 들어감
- 아래와 같이 직접 지정도 가능
```swift
enum Direction: Int {
    case north = 0     // 0
    case south = 10    // 10
    case east          // 11
    case west = 90     // 90
    case center        // 91
}
```
### 📖 Double
- Int 타입이 아닌 다른 숫자 자료형으로 원시 타입을 설정하면 모든 case에 대해 값을 지정하거나 지정하지 말아야 한다.
```swift
// 정상 케이스 1
enum Direction: Double {
    case north
    case south
    case east
    case west
    case center
}

// 정상 케이스 2
enum Direction: Double {
    case north = 1.0
    case south = 2.0
    case east = 3.0
    case west = 4.0
    case center = 5.0
}

// 에러가 발생하는 케이스
enum Direction: Double {
    case north = 1.0
    case south = 2.0
    case east = 3.0
    case west = 4.0
    case center    // error!
}
```
- number 타입의 Raw Value는 만약 값이 없으면, 바로 이전 case의 Raw Value값에서 1이란 정수값을 더하는데 현재 원시타입은 실수이기 때문에 정수값 1을 더할수 없어서 에러 발생.
- 그래서, Int 타입이 아닌 다른 숫자 자료형으로 원시 타입을 설정하면 모든 case에 대해 값을 지정하거나 지정하지 말아야 한다.

### 📖 Character
```swift
enum Direction: Character {
    case north = "n"
    case south = "s"
    case east = "e"
    case west = "w"
    case center    // error!
}
```
- Double 타입과 마찬가지로 바로 이전 case의 Raw Value값에서 1이란 정수값을 더하는데 현재 원시타입은 문자이기 때문에 정수값 1을 더할수 없어서 에러 발생.

### 📖 String
```swift
enum Direction: String {
    case north // north
    case south // south
    case east // east
    case west // west
    case center // center
}
```
- 만약 Raw Value를 정하지 않으면 case이름과 동일한 Raw Value가 자동으로 만들어진다.
- 하나만 지정해주면 어떻게 될까?
```swift
enum Direction: String {
    case north // north
    case south = "south korea" // south korea
    case east // east
    case west // west
    case center // center
}
```

## 🍎 연관값(Associated Values)
```swift
enum AppleProduct: String {
    case iPhone = "3GS, 16GB, SpaceGray"
    case iPad = "4Air, 64GB, Starlight"
}
```
- 큰 카테고리로 나눈다면 위의 열거형처럼 나눌수 있지만 모든 아이폰이 3GS 모델에 16GB일 수 없고, 모든 iPad는 4Air 모델에 64GB일수 없다. 또 이것을 모델별, 용량별, 색상별로 나눈다면...?
- 이를 보완해서 사용할 수 있도록 연관값을 적용해보자.

### 📖 연관 값을 가지는 열거형 선언 방법
- case 옆에 **튜플** 형태로 원하는 타입을 명시
- Model, Storage, Color는 미리 선언한 열거형이라고 가정하자
```swift
// 가장 기본적인 형태
enum AppleProduct {
    case iPhone(Model, Storage, Color)
    case iPad(Model, Storage, Color)
}
```
- 위와 같이 연관 값을 넣어주면 아이폰에 상세 설정을 할 수 있다.
- 가능한 케이스와 안되는 케이스를 보자
```swift
// 불가능한 케이스 -> iPhone이라는 케이스를 재 선언
enum AppleProduct {
    case iPhone
    case iPhone(Model, Storage, Color) // Invalid redeclaration of 'iPhone'
}
```
- 선언부
![](https://i.imgur.com/0EYGqWq.png)
- 인스턴스로 만들어보자!
- ![](https://i.imgur.com/vBnj927.png)
- 어떤 케이스를 사용해서 인스턴스를 생성할 것인지 "iPhone 케이스의 사용이 모호하다" 라고 알려주고 있다.
- 기본 케이스에 매개변수를 붙인 케이스를 만들 경우 기존 기본 케이스를 삭제 해주자 -> 여기선, 아래와 같이 case iPhone을 삭제해주면 된다.
```swift
// 가능한 케이스
enum AppleProductEnum {
    case iPhone(iPhoneModel, Storage, Color)
    case iPhone(model: iPhoneModel, storage: Storage, color: Color)
    case iPad
}
```
- 선언부
![](https://i.imgur.com/oqL60hk.png)
- 인스턴스로 만들어 보자!
![](https://i.imgur.com/xGUsNuL.png)
- 매개변수가 있는 케이스가 있을때는 해당 기본 케이스를 삭제하자!
- 여기까지는 문제가 없다! **문제는 switch를 통해 케이스를 처리 할 때 생긴다.**

### 📖 위와 같이 하나의 케이스에 같은 연관 타입을 받는다면 매개변수명이 있는것만 인식한다.
- 먼저 코드를 보자
```swift
enum AppleProductEnum {
    case iPhone // iPhone이라는 같은 케이스 + 연관값이 있다면 삭제한다.
    case iPhone(iPhoneModel, Storage, Color) // 1
    case iPhone(model: iPhoneModel, storage: Storage, color: Color) // 2
    case iPad(iPadModel, Storage, Color)
}
```
- 1번은 iPhone이라는 케이스에 연관값으로 iPhoneModel, Storage, Color을 받고있다 (매개변수명 없음)
- 2번은 iPhone이라는 케이스에 연관값으로 iPhoneModel, Storage, Color을 받고있다 (매개변수명 있음)
- 위와 같이 매개변수명이 없는 연관 타입과 매개변수명이 있는 연관 타입 공존하면 매개변수명이 있는것만 인식한다.
- switch문에서는 연관 타입이 같다고 하더라도 매개변수명이 있는 케이스만 인식한다.(적어도 지금까지 공부한 내용으로는.) 그래서, 아래와 같이 하나만 남기고 모두 삭제하는 것이 좋다.
```swift
enum AppleProductEnum {
    case iPhone(model: iPhoneModel, storage: Storage, color: Color)
    case iPad(iPadModel, Storage, Color)
}
```
- 만약 간단한 케이스와 연관값이라면 매개변수를 삭제해도 상관없이 잘돌아간다.
```swift
enum AppleProductEnum {
    case iPhone(iPhoneModel, Storage, Color)
    case iPad(iPadModel, Storage, Color)
}
```
- 중요한것은 같은 연관 타입이라면 하나만 케이스는 하나로 **통일**하는 것이다!
- 나중에 더 확실히 알고나서 틀린점 고치기. 현재까지는 사용하는데 무리 없음.

## 🍎 분기 처리하기(첨부 프로젝트)
- 설명은 주석에 있다.
```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myIphoneDetail = AppleProductEnum.iPhone(model: .twelve_pro_max, storage: .two_fifty_six, color: .gold)
        checkPhone(myIphoneDetail: myIphoneDetail)
    }
    
    func checkPhone(myIphoneDetail: AppleProductEnum) {
        switch myIphoneDetail {
        case .iPhone(.thirteen_pro_max, .five_twelve, .skyblue) :
            print("minsson's iphone")
            break
        case .iPhone(.twelve_pro_max, .two_fifty_six, .gold):
            print("kay's iphone")
            break
        case .iPhone(_, .two_fifty_six, _):    // model과 color는 상관없고, 용량만 256이면 OK
            print("256!")
            break
        case .iPhone(_,_,.gold) :    // model과 storage는 상관없고 컬러만 골드면 OK 
            print("gold!")
            break
        case .iPhone:    // iPhone이면 다 OK
            print("iPhone")
            break
        default :
            print("default")
            break
        }
    }
}
```

## 🍎 if case let으로 보일러 플레이트 코드 제거하기
- 보일러 플레이트 코드는 변화없이 여러 군데에서 반복되는 코드를 말한다.
- 새로운 xcode 프로젝트를 열고 if case let을 사용하는 코드 작성.
- 떡볶이의 비율을 알려주는 코드를 기존 방식으로 처리하는 코드와 if case let으로 처리하는 코드 구현
- [구현부](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/Enumeration/Basic_Enumeration/EnumWithIfCaseLet/enumWithIfCaseLet/bunsikEnum.swift)
- [실행부](https://github.com/KayAhn0126/iOS-Study/blob/main/GrammarAndKnowledge/Enumeration/Basic_Enumeration/EnumWithIfCaseLet/enumWithIfCaseLet/ViewController.swift)
- 연관값을 사용하지 않으면 굳이 let 상수를 선언하고 사용할 필요는 없다.
    - 이 경우 if case 로 작성.

## 🍎 Citation
- [소들이 블로그](https://babbab2.tistory.com/116)
- [우짱 블로그](https://woozzang.tistory.com/177)
