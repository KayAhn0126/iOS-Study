# Passing Reference

## 🍎 객체에 대한 참조를 인자로 넘겨주는것에 대한 정리
- 왜? 이것에 대해 정리하는가?
- main reason
    - inout 키워드에 대한 정리 및 실제 인자로 넘겨진 객체를 참조하는지 확인하기 위해서.
- sub reason
    - 알고리즘 문제(효율적인 해킹)을 풀다가 발견한 아래의 내용을 테스트하기 위해서.
    - 전역 변수(배열)을 함수 안에서 호출하는 것과 실인자의 공간을 공유하는 인자 전달 방식인 참조방식을 사용했을때 어느것이 더 효율적인지 테스트.

## 🍎 inout 키워드를 알아보기 앞서...
- address와 reference의 차이점을 알아보자.
- address는 객체가 실제로 할당 되어있는 메모리 주소.
- reference는 실제 객체를 참조한다는 의미.
    - 즉, 함수의 매개 변수를 참조 타입으로 선언하고, **매개 변수가 호출하는 쪽의 실제 인자를 참조하여 실인자와 공간(메모리)를 공유하는 인자 전달 방식**이다.

## 🍎 객체의 메모리 주소는 어떻게 얻을까?
- [Documentation/Swift/Swift Standard Library/C Interoperability](https://developer.apple.com/documentation/swift/c-interoperability)
- 일반적으로는 아래와 같이 간단하게 Swift Standard Library에서 제공하는 함수 중 withUnsafePointer 함수로 접근할 수 있다.
    - 이것도 나중에 다루지만 withUnsafePointer는 타입이 정해져 있는 변수의 주소를 가져온다.
- withUnsafePointer는 우리가 사용하기 쉽게 스위프트에서 제공하는 함수다.
    - 초록색 사각형은 우리가 자주 사용하는 print 함수가 분류되어 있는 곳.
    - 빨간색 사각형에 방금 설명한 withUnsafePointer가 있다.
![](https://hackmd.io/_uploads/r1SJvI1wn.png)
- 좀 더 자세히 알아보기 위해 위의 네가지 함수에 매개변수로 들어가는 타입에는 어떤것들이 있는지 알아보자!
- [Documentation/Swift/Swift Standard Library/Manual Memory Management/Calling Functions With Pointer Parameters](https://developer.apple.com/documentation/swift/calling-functions-with-pointer-parameters) 아티클을 보자.
- UnsafePointer
- UnsafeRawPointer
- UnsafeMutablePointer
- UnsafeMytableRawPointer
- **위의 네가지 타입에 대해서 알아보자!**
- 먼저 간단하게 이야기 하면,
    - 가장 많이 사용되는 UnsafePointer\<T> 같은 경우
        - 지정된 타입 이외에는 매개변수로 받을수 없다.
            - 단, Int타입이라면, [Int]도 받을 수 있다.
        - 값을 변경할 수 없다.
    - Pointer 앞에 Raw가 붙은 경우,
        - 예) UnsafeRawPointer
        - 타입 상관없이 매개변수로 받을 수 있다.
        - 값을 변경할 수 없다.
    - Mutable이 붙은 경우,
        - 값을 변경할 수 있다.
        - 예) UnsafeMutablePointer\<Int>
        - 바로 위의 예제인 UnsafeMutablePointer\<Int>를 보면 아래의 뜻과 같다.
            - 지정된 타입만 매개변수로 받을 수 있다.
            - 매개변수로 넘어온 포인터를 통해서 메모리에 할당된 값을 변경할 수 있다.
- safety level을 이미지로 보면 아래와 같다.
![](https://hackmd.io/_uploads/HkDRRrgP3.png)
- 아래로 내려갈 수록 받는 타입의 범용성이 커져 이런 저런 타입을 사용할 수 있지만, 내려갈 수록 물리적인 Hardware에 가까워져 CPU를 더 많이 사용한다.

### 📖 깔끔하게 정리된 표로 알아보자!
- Kodeco에 이렇게 깔끔하게 정리된표가 있었는데 너무 늦게 알아버렸다.
![](https://hackmd.io/_uploads/Hku9yI7Ph.png)
- [이미지 출처](https://www.kodeco.com/7181017-unsafe-swift-using-pointers-and-interacting-with-c)

### 📖 타입이 정해져 있는 포인터를 매개변수로 받는 함수
```swift
func takesAPointer(_ p: UnsafePointer<Float>) {
    print(p)
    print(p.pointee)
}

var x: Float = 0.0
takesAPointer(&x)
var xArr: [Float] = [1.0, 2.0, 3.0]
takesAPointer(&xArr)
takesAPointer(&xArr[1])
```
- 현재 takesAPointer 함수는 Float 타입의 변수 또는 배열만 받을 수 있다.
- 만약 Int 타입의 변수나 배열의 주소를 알기 위해 아래와 같이 함수의 매개변수에 Int타입의 객체를 포인터로 넘긴다면..
![](https://hackmd.io/_uploads/rJf7ftTLn.png)
- 타입이 맞지 않아 발생하는 에러를 볼 수 있다.
- 이럴때는 UnsafeRawPointer를 인자로 받는 함수를 선언하고 사용하면 된다.
    - UnsafePointer\<Type>과 동일한 피연산자를 전달할 수 있지만 모든 타입을 사용할 수 있습니다.
    - UnsafeRawPointer 구조체는 UnsafePointer 보다 한단계 더 낮은 레벨이다.(포용 범위가 더 넓음)

### 📖 타입이 정해져 있지 않은 포인터를 매개변수로 받는 함수
- 타입이 정해져 있지 않은 매개변수를 UnsafeRawPointer 타입으로 받으면 받아온 포인터를 통해 해당 객체의 주소를 쉽게 알아낼 수 있지만, UnsafePointer에 비해 불편한점도 있다.
```swift
func takesARawPointer(_ p: UnsafeRawPointer)  {
    print(p)
}

var testFloat: Float = 3.5, testInt: Int = 5
takesARawPointer(&testFloat)
takesARawPointer(&testInt)
takesARawPointer([1.0, 2.0, 3.0] as [Float])

var intArray = [1, 2, 3]
takesARawPointer(intArray)
takesARawPointer("How are you today?")
```
- 위의 코드는 매개변수로 들어온 포인터를 통해 해당 객체의 주소를 print하고 있다.
- 이때 해당 객체의 주소에 접근해서 pointee(값)을 출력하면 아래와 같은 상황이 발생한다.
```swift
func takesARawPointer(_ p: UnsafeRawPointer)  {
    print(p)
    print(p.load(as: Float.self))
}

var testFloat: Float = 3.5, testInt: Int = 5
takesARawPointer(&testFloat)
takesARawPointer(&testInt)
takesARawPointer([1.0, 2.0, 3.0] as [Float])

var intArray = [1, 2, 3]
takesARawPointer(intArray)
takesARawPointer("How are you today?")
```
- 위의 코드를 실행 했을때 출력되는 결과
```bash
0x0000000100008050
3.5
0x0000000100008058
7e-45
0x0000600000c00bf0
1.0
0x00006000017002a0
1e-45
0x0000600001700360
2.0958534e-19
0x0000000100008068
```
