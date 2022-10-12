# Self vs self

## 🍎 Self와 self에 대해 알아보자.
- Self
    - Self는 타입을 의미
    - self 프로퍼티의 타입은 Self
- self
    - 인스턴스 자체 접근 시 사용되는 참조값
    - self는 참조타입
        - value type에서의 self는 stack영역에 존재하는 instance를 가리키는 형태
        - reference type에서의 self는 heap 영역에 존재하는 instance를 가리키는 형태

## 🍎 Self.self
- Self는 type 그 자체를 의미: **타입을 정의할 때 사용**
- Self.self는 type object를 의미: **타입을 넘길때 사용**
```swift
static var defaultFileName: String {
    return NSStringFromClass(Self.self).components(separatedBy: ".").last! // 넘길때 Self.self 사용
}
static func instantiateViewController(_ bundle: Bundle? = nil) -> Self // 타입 정의할때 Self 사용
```

- NSStringFromClass 메서드의 원형을 살펴보자
```swift
func NSStringFromClass(_ aClass: AnyClass) -> String
```
- 즉, 위의 코드(defaultFileName 타입 연산 프로퍼티)에서 Self.self가 타입을 넘길때 사용된 것을 알수있다.

## 🍎 Class에서의 Self 의미
```swift
class TestClass {
    static func sayHi() { print("HI")}
    
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func someFunc() -> Self {
        return self
    }
}

var testObject = TestClass.init("Kay")
print(testObject.someFunc().name) // Kay
print(type(of: testObject.someFunc())) // TestClass
// 여기까지는 Class의 인스턴스

var testTypeObject: TestClass.Type = TestClass.self
testTypeObject.sayHi()  // "HI"
print(type(of: testTypeObject.self)) // TestClass.Type
// 여기까지는 Class.Type의 오브젝트
```
- someFunc()는 인스턴스 메서드
    - 여기서 Self는 TestClass, return self는 TestClass로 찍어낸 객체.
- TestClass.Type은 TestClass라는 타입 그 자체.
- TestClass.self는 위에서 이야기 했듯이 type을 오브젝트화 한것!

## 🍎 Citation
- [김종권의 iOS](https://ios-development.tistory.com/600)
