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
- [포인터 파라미터를 가지는 함수 호출](https://developer.apple.com/documentation/swift/calling-functions-with-pointer-parameters) 아티클을 보자.
### 📖 현 시점에서 필요한것은 UnsafePointer이지만 UnsafeRawPointer에 대해서도 같이 알아보자
- 공통점
    - UnsafePointer와 UnsafeRawPointer 모두 raw untyped memory를 사용하기 위한 unsafe pointer API이다.
    - low-level C나 system API과 상호작용할 때 사용한다.
- 차이점
    - type safety
    - memory access
- type safety에서 차이
    - UnsafePointer:
        - typed pointer로 특정 타입을 가르키는 포인터이다.
        - type이 있는 객체가 raw memory와 관련된 작업을 할때 사용된다.
    - UnsafeRawPointer:
        - untyped pointer로 특정 타입을 가지지 않은 날 것의 raw memory를 가리키는 포인터이다.
        - byte 레벨에서 메모리를 조작할 수 있다.
        - type을 꼭 명시하지 않아도 된다.
        - UnsafeRawPointer를 사용하는 경우 메모리에 액세스 하기 전에 포인터를 적절한 유형으로 명시적 캐스팅을 해야한다.
- memory access에서 차이
    - UnsafePointer
        - 확실하게 메모리에 접근할 수 있음을 보장한다.
        - 주어진 타입만 접근할 수 있다.
        - 만약 UnsafePointer\<Int>라면 Int 타입의 변수, 배열만 접근이 가능하다.
    - UnsafeRawPointer
        - 메모리에 접근하는것을 보장하지 않는다.
        - 메모리에 제대로 접근하는지 체크해야한다.
        - 정상적인 바이트 alignment나 바른 타입으로 해석하는지 확인해야한다.
- 정리하면...
    - UnsafePointer
        - typed pointer
        - provides type safety
        - memory access guarantees
    - UnsafeRawPointer
        - untyped pointer
        - does not provide type checking, memory access guarantees.
    - 위의 두가지 구조체는 상황에 따라서 사용한다.
    - UnsafeRawPointer가 **더 범용적**이다. **하지만 더 안전한것은 UnsafePointer이다.**
![](https://hackmd.io/_uploads/H14AHMALn.png)

### 📖 상수 포인터를 매개변수로 전달하기
- UnsafePointer\<Type>을 인자를 받는다고 선언한 함수는 아래와 같은 타입들도 받을 수 있다.
    - UnsafePointer\<Type>
    - UnsafeMutablePointer\<Type>
    - AutoreleasingUnsafeMutablePointer\<Type>
    - 위 타입들은 필요에 따라 암시적으로 UnsafePointer\<Type>으로 캐스팅된다.
- Type이 Int8 또는 UInt8이라면 문자열 값이다.
    - 이 부분은 확실하게 잘 모르겠다. (**공부 필요**)
    - string은 자동으로 0으로 끝나는 UTF8 버퍼로 변환되고, 그 버퍼를 가리키는 포인터가 함수로 전달된다.
- 변경이 가능한 변수, 프로퍼티, 또는 Type의 서브스크립트 참조 또한 inout 키워드와 앰퍼샌드를 통해 사용할 수 있다.
- [Type] 값 또한 배열의 첫번째 위치를 가르키는 포인터를 전달할 수 있다.

### 📖 상수 포인터를 받는 함수 예제
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
