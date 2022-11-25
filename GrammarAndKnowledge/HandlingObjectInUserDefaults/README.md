# userDefaults에서 구조체 인스턴스 사용하기
- 기본적으로 구조체 인스턴스 사용 불가 원인과 사용하는 방법 정리

## 🍎 읽어보기
- 앱을 실행하는 동안 생성된 모든 데이터는 기본적으로 메모리에 저장된다. 메모리에 저장되는 데이터는 쉽게 읽고 쓸 수 있는 반면 앱을 종료하는 순간 모두 지워지기 때문에, 보존해야할 데이터는 특수한 방식으로 저장해두어야 한다.
- 코코아 터치 프레임워크에서 선택 가능한 데이터 저장 방식은 크게 세가지. 
- 프로퍼티 리스트, 관계형/목록형 데이터, 비정형 데이터 순서
    - 프로퍼티 리스트
        - 기본 property list (xcode에서 plist라고 불리는 것)
        - UserDefaults
        - Custom property list
    - 코어 데이터 또는 SQLite
        - Core Data
        - SQLite
    - 아카이빙
        - Archiving

## 🍎 언제, 어떤 데이터 저장 방식을 사용해야 할까?
- 비교적 간단한 데이터 -> 프로퍼티 리스트
- 테이블 뷰, 컬렉션 뷰로 표현해야할 데이터 -> 코어 데이터 또는 SQLite
- 위 두 가지에 해당하지 않는다면, 아카이빙

## 🍎 프로퍼티 리스트란 무엇일까?
- 위에 나열한 것 처럼 기본 property list, userDefaults, Custom property list 모두 '프로퍼티 리스트'라는 하나의 카테고리 안에 들어있다.
- **즉, userDefault도 프로퍼티 리스트라는 이야기.**
- **프로퍼티 리스트는 객체-직렬화를 위한 XML형식의 파일이다.**
    - 객체 직렬화 -> 객체의 내용을 바이트 단위로 변환하여 파일에 기록하거나 네트워크를 통해 전달이 가능하도록 하는 것.
        - var x: String = "Hello"
        - var y: NSString = "Hello"
        - var z: CFString = "Hello"
        - 즉, 값을 바이트 단위로 변환하여 가지고 있는것. -> 문자열이고 5글자 라는걸 프로퍼티 리스트에 저장할래!
        - 위의 세 타입 모두 <string\>로 추상화 가능 왜? 셋 다 문자열을 표현할 수 있으니까!
    - 객체 역 직렬화 -> 바이트 단위로 변환하여 가지고 있던 데이터를 사용하고자 하는 타입으로 변환하는것
        - 프로퍼티 리스트에 있는 <string\>타입은 문자열이니까 Any?로 반환받고 내가 사용하고 싶은대로 사용할래! 어차피 문자열이니 String, NSString, CFString중 하나로 다운캐스팅해서 사용할게!
- 대부분 .plist라는 확장자를 가지기 떄문에 plist파일이라고 부른다.
- 비교적 단순한 데이터를 **XML 포맷에 맞추어 키-벨류 형식으로 저장**하는 것.
- 딕셔너리 방식이기 때문에 프로퍼티 리스트에서는 서로 다른 키를 사용해 여러가지 데이터를 저장할 수 있다.
    - 즉, **중복된 키를 사용하면 기존의 데이터가 새로운 데이터로 덮어 씌어지므로 주의**해야한다.
- 프로퍼티 리스트에서 하나의 키에 저장할 수 있는 데이터는 하나이지만, 그 데이터를 배열이나 딕셔너리 타입으로 정의 할 경우, 실질적으로 하나 이상의 데이터를 저장할 수 있다.
    - 프로퍼티 리스트는 데이터의 타입을 추상화 하여 저장한다. 일체의 개별적인 특성을 배제하고 공통성을 띄는것으로 저장한다는 뜻.
    - String, NSString, CFString은 '문자열'이라는 공통성을 띄므로 '문자열'이라는 공통의 타입으로 추상화한다.
        - **실제로는 XML 형태인 <string\> 이렇게 저장된다.**
        - **데이터 타입을 추상화하는 것이지, 데이터 자체를 추상화하는 것은 아니다.**
    - 꼼꼼한 재은씨 3권 p655 그림 참조하기.
    - 후술할 내용이지만, 프로퍼티 리스트에 저장할 수 있는 데이터 타입은 크게 두 가지이다.
        - 원시타입
            - (String, Int, Float, Double, Bool등) -> 스위프트에서 제공
        - 레퍼런스 타입 
            - (NSString, NSNumber, NSData등) -> 파운데이션 프레임워크에서 제공
            - (CFString, CFNumber, CFDate, CFData) -> 코어 파운데이션 프레임워크에서 제공
        - 원시 타입이건 레퍼런스 타입이건 String, NSstring, CFString은 공통적으로 '문자열'이라는 공통적인 속성을 가지고 있으므로 프로퍼티 리스트에 저장할때는 <string\> 타입으로 저장된다.
    - **위의 원시타입, 레퍼런스 타입에 적혀있는 데이터 타입들을 프로퍼티 객체 타입이라고 하는데, 원칙적으로 프로퍼티 객체 타입이 아니면 프로퍼티 리스트에 저장할 수 없다.왜????**
        - 데이터의 유실 없이 프로퍼티 리스트에 저장할 수 있는 형태(XML)로 데이터를 변환하는 메커니즘이 없기 때문이다.
            - 반대로 말하면 위의 원시, 레퍼런스 타입은 기본적으로 데이터 유실없이 프로퍼티 리스트에 저장 가능!
        - 이 때문에 배열이나 딕셔너리 등 집합 자료형 하위에 저장되는 데이터도 모두 프로퍼티 객체 타입이여야 한다.
        - 예를 들어 아래와 같은 상황이 있을 수 있겠다.
        ```swift
        [[String: Customer]] // String은 프로퍼티 객체. Customer 구조체는 프로퍼티 객체 타입이 아님.
        ```
        - 그럼 프로퍼티 객체 타입인 String, Int Float, NSString, NSNumber, NSData, CFString, CFNumber, CFDate, CFData 이외에는 프로퍼티 리스트에 저장할 수 없을까?
        - 데이터 유실이 발생하지 않게 데이터 변환 메커니즘을 직접 구현 해줄 경우 위의 프로퍼티 객체 타입이 아니라도 프로퍼티 리스트에 저장 가능하다.
        - **변환 메커니즘은 NSCoder 프로토콜을 통해 제공된다.** 저장하고자 하는 데이터 객체가 이 프로토콜을 구현하게 하면 된다.

## 🍎 일반적으로 userDefaults를 이용해 데이터를 저장하는 방식
- ToDoList 프로젝트 중 [[String: Any]] 타입으로 저장하는 코드
```swift
let data = self.tasks.map {
    [
        "title": $0.title, "done": $0.done
    ]
}
let userDefaults = UserDefaults.standard
userDefaults.set(data, forKey: "tasks")
```
- 고차함수 map은 요소를 형태에 맞게 바꿔주고 새로운 배열에 담아 반환하므로 아래와 같은 형식이 될것이다.
```swift
[["title": "homework", "done": true], ["title": "work-out", "done": false], ["title": "laundry", "done": true]]
```
- 위와 같은 방식으로 배열안에 딕셔너리(요소를 2개 가지는)로 저장해도 하나의 데이터이기 때문에 저장이 가능하다.

## 🍎 위의 방식은 사용하기 너무 복잡하다 
- 위의 코드로 어찌저찌 저장 했다 해도 데이터를 불러와 사용하려면 아래와 같이 코드를 작성해야한다.
```swift
let userDefaults = UserDefaults.standard
guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
self.tasks = data.compactMap {
    guard let title = $0["title"] as? String else { return nil }
    guard let done = $0["done"] as? Bool else { return nil }
    return Task(title: title, done: done)
}
```
```swift
func object(forKey defaultName: String) -> Any? // object() 메서드 정의
```
- userDefaults에 저장된 데이터를 사용하려면 Any? 타입으로 반환 받은것을 다운캐스팅해 compactMap으로 nil 체크 및 다시 다운 캐스팅하고 구조체로 만들어 새로운 배열에 담아 반환하고 있다.

## 🍎 프로퍼티 객체 타입이 아닌 데이터를 userDefaults에 넣으면 어떻게 될까?
- "데이터 유실 때문에 프로퍼티 객체 타입이 아니면 프로퍼티 리스트에 저장할 수 없지만 데이터 유실이 발생하지 않게 데이터 변환 메커니즘을 직접 구현하는 경우 프로퍼티 객체 타입이 아니라도 프로퍼티 리스트에 저장 가능하다" 라고 했었다.
- 근데 만약 그 메커니즘 없이 일반 프로퍼티 객체 타입처럼 객체를 저장하려하면 어떻게 될까?
```swift
let data = self.tasks.map {
    return Task(title: $0.title, done: $0.done)
}
let userDefaults = UserDefaults.standard
userDefaults.set(data, forKey: "tasks")
```
- 위의 코드를 실행하면 아래와 같은 결과를 낸다.
![](https://i.imgur.com/expa60o.png)
- "**Attempt to insert non-property list object**" 라는 에러를 발생시키고 앱이 강제로 종료된다.
- 프로퍼티 객체 타입이 아닌 데이터를 프로퍼티 리스트에 저장하려 했으니 당연히 발생하는 결과이다.

## 🍎 PropertyListEncoder / PropertyListDecoder 사용해 문제 해결하기
- 먼저 정상적으로 작동이 되는 코드를 보자.
```swift
// Task 구조체
struct Task: Codable {
    var title: String
    var done: Bool
}

// 구조체 인스턴스를 userDefaults에 저장하기
let data = self.tasks.map {
    return Task(title: $0.title, done: $0.done)
}
let userDefaults = UserDefaults.standard
userDefaults.set(try? PropertyListEncoder().encode(data), forKey: "tasks")


// 데이터에서 저장해두었던 구조체 인스턴스 불러오기
let userDefaults = UserDefaults.standard
if let data = userDefaults.value(forKey: "tasks") as? Data {
    let realData = try? PropertyListDecoder().decode([Task].self, from: data)
    self.tasks = realData!
}
```
- PropertyListEncoder의 역할은 무엇일까? 어떻게 프로퍼티 객체 타입이 아닌 구조체 인스턴스 타입의 데이터를 프로퍼티 리스트인 userDefaults에 저장하게 해줄까?
- 먼저 프로퍼티 리스트의 설명에서..
    - **"프로퍼티 리스트는 데이터의 타입을 추상화 하여 저장한다. 일체의 개별적인 특성을 배제하고 공통성을 띄는것으로 저장한다는 뜻"**
    - 만약 프로퍼티 객체 타입인 String or NSString or CFString 타입의 데이터를 userDefaults에 저장한다면 <string\> 타입으로 추상화해서 저장하고 데이터를 꺼내 쓸때는 Any? 타입으로 반환된 것을 원래의 타입대로 다운 캐스팅해서 사용했다.
- 구조체 인스턴스가 프로퍼티 객체 타입처럼 userDefaults에 저장될수 없었던 이유는...
    - 프로퍼티 객체 타입들은 공통적으로 가지고 있는 성질이 문자, 숫자, 배열, 딕셔너리처럼 추상화가 가능했었다.
    - 하지만 구조체 같은 경우, 다른 구조체와 같은 성질을 가지고 있을 수도 있고 아닐수도 있으니 하나를 기준으로 추상화 자체가 어렵다.
- 이제, PropertyListEncoder 클래스의 인스턴스 메서드 encode(value: data)를 사용하면 구조체 인스턴스를 Data 타입으로 추상화 한다.
    ```swift
    userDefaults.set(try? PropertyListEncoder().encode(data), forKey: "tasks")
    ```
    - 이때, 해당 구조체는 Codable 프로토콜을 채택하고 있어야 한다. (현재는 Encodable만 필요하지만 userDefaults에서 decode()메서드 사용시 매개변수는 Decodable 프로토콜을 준수하는 제네릭이기 때문에 Decodable도 같이 써줘야한다. -> 두 프로토콜을 & 연산자로 typealias하고있는 Codable로 렛츠고!)
- 데이터를 호출하는 부분은 userDefaults에서 해당 키와 매칭되는 값을 가져오고 Data 타입으로 다운 캐스팅을 해줘야 한다. (Any? -> Data)
- 매칭되는 값이 Any?로 반환되지만 Data타입으로 다운캐스팅에 성공했다면 이제 Data에서 구조체 타입으로 decode 역 직렬화 한다.
- 에러 없이 구조체 형태로 반환이 되었다면 이제 사용하면 된다!

## 🍎 Citation
- 꼼꼼한 재은씨 (실기편) p650, 653-6, 674-680, 715
- [UserDefaults와 PropertyListEncoder, PropertyListDecoder](https://swifty-cody.tistory.com/40?category=1076580)
- [Attempt to insert non-property list object when trying to save a custom object in Swift 3](https://stackoverflow.com/questions/41355427/attempt-to-insert-non-property-list-object-when-trying-to-save-a-custom-object-i)
- [UserDefaults 로 객체를 저장을 해보자](https://velog.io/@nnnyeong/iOS-UserDefaults-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)
