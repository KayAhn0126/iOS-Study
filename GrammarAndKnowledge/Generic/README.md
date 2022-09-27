# Generic
[공부했던 블로그](https://babbab2.tistory.com/136)

- 범용 타입
- 코드를 유연하게 작성 할 때 사용

## 🍎 제네릭 함수
```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
   let tempA = a
   a = b
   b = tempA
}
```
- Int형은 문제 없지만 Double, String형을 사용해 swap하고 싶다면?
- 함수 오버로딩을 생각하지만 이것을 제네릭을 사용하면 아래와 같이 표현할 수 있다.
```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
   let tempA = a
   a = b
   b = tempA
}
```
- 꺽쇠 < >를 이용해 T를 선언하면 그 뒤로 "해당 T를 타입으로 사용한다" 라는 뜻.
- T는 새로운 형식이 아니라 실제 함수가 호출될 때 해당 매개변수의 타입으로 대체되는 Placeholder.

## 🍎 제네릭 타입
- 제네릭은 함수에만 가능한것이 아니라 구조체, 클래스, 열거형 타입에도 선언 가능.
- 아래는 Stack을 제네릭으로 만드는 코드.
```swift
struct Stack<T> {
    let items: [T] = []
 
    mutating func push(_ item: T) { ... }
    mutating func pop() -> T { ... }
}
```
### 타입제약
- 제네릭 함수와 타입을 사용할 때 특정 클래스의 하위 클래스나, 특정 프로토콜을 준수하는 타입만 받을 수 있게 제약 가능
    #### 프로토콜 제약
    ```swift    
    func isSameValues<T>(_ a: T, _ b: T) -> Bool {
        return a == b               // Binary operator '==' cannot be applied to two 'T' operands
    }
    ```
    - == 연산자는 Equatable이란 프로토콜을 준수할 때만 사용할 수 있으므로 에러가 난다.
    - 따라서 아래와 같이 제네릭타입 T에 Equatable 프로토콜을 준수하도록 하면 된다.
    ```swift
    func isSameValues<T: Equatable>(_ a: T, _ b: T) -> Bool {
        return a == b               
    }
    ```
    - 이제 T는 Equatable프로토콜을 준수하는 파라미터만 받는다.
    
    #### 클래스 제약
    - 클래스 제약 경우는 프토토콜 제약과 같지만 프로토콜 자리에 클래스 이름이 오는것.
    - 아래의 코드를 보자
    ```swift
    class Bird { }
    class Human { }
    class Teacher: Human { }
 
    func printName<T: Human>(_ a: T) { }
    ```
    - 이렇게 T: Human을 쓰면 Human클래스와 Human클래스를 상속 받은 Teacher 클래스의 인스턴스는 함수에 접근 가능하지만 Bird클래스의 인스턴스는 실행할 수 없다.

