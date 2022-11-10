# 고차함수
- String을 기준.

## 🍎 map
- Array, Dictionary, Set, Optional에 사용 가능
- 타입은 변하지 않고 값만 원하는 형태로 맵핑한다.
```swift
var map_str = ["Hello", "World!"]
var map_result = map_str.map( { $0.uppercased() } )
print(map_result)            // map을 사용한 결과 -> ["HELLO", "WORLD!"]
print(type(of: map_result))  // 결과의 타입 -> Array<String>
print(map_str)              // 원본이 바뀌었는지 확인 -> ["Hello", "World!"] -> 그대로.


var map_int = [1,2,3,4,5]
var map_int_result = map_int.map( { String($0) } )
print(map_int_result)           // map을 사용한 결과 -> ["1", "2", "3", "4", "5"]
print(type(of: map_int_result)) // 결과의 타입 -> Array<String>
print(map_int)                 // 원본이 바뀌었는지 확인 -> [1,2,3,4,5] -> 그대로.


var map_str_character = ["a","b","c","d","e"]
var map_str_character_result = map_str_character.map({ Int($0) })
print(map_str_character_result)           // map을 사용한 결과 -> [nil, nil, nil, nil, nil]
// 위에서 components와 compactMap을 사용한것을 보자! -> 숫자로 바꿔지지 않으면 nil 반환
print(type(of: map_str_character_result)) // 결과의 타입 -> Array<Optional<Int>>
print(map_str_character)                 // 원본이 바뀌었는지 확인 -> "a", "b", "c", "d", "e"] -> 그대로.
```

## 🍎 filter
- 필터 or 추출
- 문자열을 처리하면 새로운 문자열로, 문자열 배열을 처리하면 새로운 문자열 배열로 담아 반환
```swift
var filter_str = "Hello World!"
var filter_result = filter_str.filter { $0.asciiValue! >= 97 }
print(filter_result)            // 문자열에 filter를 사용한 결과 -> elloorld
print(type(of: filter_result))  // 결과의 타입 -> String 타입
print(filter_str)               // 원본이 바뀌었는지 확인 -> "Hello World!" -> 그대로.

var filter_str_arr = ["A", "B", "C", "D", "E"]
var filter_str_arr_result = filter_str_arr.filter( { $0 == "B"} )
print(filter_str_arr_result)             // 문자열 배열에 filter를 사용한 결과 -> ["B"]
print(type(of: filter_str_arr_result))   // 결과의 타입 -> Array<String>
print(filter_str_arr)                   // 원본이 바뀌었는지 확인 -> ["A", "B", "C", "D", "E"] -> 그대로.
```

## 🍎 split
- split이란 말 그대로 separator를 기준으로 나누는것.
- **swift 표준 라이브러리에 들어있어 Foundation을 import하지 않아도 된다.**
- **Array\<Substring>으로 반환**
```swift
var split_str = "Hello World!"
var split_result = split_str.split(separator: " ")
// 위와 같이 split만 사용하면 split_result은 Array<Substring> 타입이다.
print(split_result) // ["Hello", "World!"] -> 헷갈리지 말자 Array<String> 같지만 Array<Substring>이다.
print(type(of: split_result)) // Array<Substring>


// 아무래도 Substring 형태로 나오면 불편하다..
// 마지막에 map을 사용해서 Array<String> 타입으로 만들어주자!
// String 타입으로 바꿔주자!
var split_arr2 = split_str.split(separator: " ").map({ String($0) })
print(split_arr2) // ["Hello", "World!"] -> Array<String> 타입.
print(type(of: split_arr2)) // Array<String>
```
## 🍎 components
- **split과 비슷하게 separatedBy: 매개변수를 받아 문자 기준으로 쪼갠 결과를 Array\<String> 으로 반환 해준다.**
- components는 Foundation 프레임워크에 속해 있기 때문에 import Foundation 필수.
```swift
var component_str = "Hello World!"
var component_result = component_str.components(separatedBy: " ")
// " "로 나눈 결과를 Array<String> 타입에 담아 반환.
print(component_result)             // components를 실행한 결과 -> ["Hello", "World!"]
print(type(of: component_result))   // 결과의 타입 -> Array<String>
print(component_str)                // "Hello World!"
```

### 📖 componets + compactMap
```swift
var equation = "1+2-3*4/5"
var equation_with_compactMap_result = equation.components(separatedBy: ["+","-","*","/"]).compactMap { Int($0) }

// equation_with_compactMap_result = equation.components(separatedBy: ["+","-","*","/"])의 결과는
// ["1","2","3","4","5"] 이다.

// compactMap을 사용해 ["+","-","*","/"]로 나눈 결과에서 옵셔널을 제거하고 Int타입으로 반환
print(type(of: equation_with_compactMap_result))                // Array<Int>
print(equation_with_compactMap_result)                         // [1, 2, 3, 4, 5]
print(equation_with_compactMap_result[0] + equation_with_compactMap_result[1]) // 3

// 만약 compactMap이 아니라 map을 썼다면?
var equation_with_map_result = equation.components(separatedBy: ["+","-","*","/"]).map { Int($0) }
print(type(of: equation_with_map_result))                      // Array<Optional<Int>>
print(equation_with_map_result) // [Optional(1), Optional(2), Optional(3), Optional(4), Optional(5)]
// map을 사용하면 숫자로 바꿀수 없는 경우 nil이 나온다! -> 문자열을 숫자로 바꿔줄때는 compactMap을 사용!
```

## 🍎 flatMap / compactMap
- 1차원 배열에서 nil제거 옵셔널 바인딩 -> compactMap (flatMap도 하는 역할은 같음. 하지만 deprecated.)
```swift
let array1 = [1, nil, 3, nil, 5, 6, 7]
let flatMapTest1 = array1.flatMap{ $0 }
let compactMapTest1 = array1.compactMap { $0 }

print("flatMapTest1 :", flatMapTest1)
print("compactMapTest1 :", compactMapTest1)

// <출력>
// flatMapTest1 : [1, 3, 5, 6, 7]
// compactMapTest1 : [1, 3, 5, 6, 7]
```
- 2차원 배열을 1차원 배열로 flatten 하게 만들고 싶으면 flatMap 사용.(compactMap은 그렇게 하지 못함)
```swift
let array2: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]
let flatMapTest2 = array2.flatMap { $0 }
let compactMapTest2 = array2.compactMap { $0 }

print("flatMapTest2 :",flatMapTest2)
print("compactMapTest2 :",compactMapTest2)

// <출력>
// flatMapTest2 : [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil, nil]
// compactMapTest2 : [[Optional(1), Optional(2), Optional(3)], [nil, Optional(5)], [Optional(6), nil], [nil, nil]]
```
- flatMap과 compactMap을 같이 사용하는 경우
```swift
let array2: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]
let flatMapTest2 = array2.flatMap { $0 }.compactMap{ $0 }

// <출력>
// flatMapTest2 : [1, 2, 3, 5, 6]
```

## 🍎 reduce
- 주어진 클로져를 사용해 연속된 요소들을 합친 결과를 반환하는 메서드
```swift
func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Self.Element) throws -> Result
) rethrows -> Result
```
- 매개변수 initialResult와 nextPartialResult에 대해.
    - initialResult : 값이 누적될 초기값. initialResult 매개변수는 첫 클로져가 실행될때 nextPartialResult로 넘겨진다.
    - nextPartialResult : 누적값을 계속 결합시킬 클로져.
- 아래와 같이 사용한다.
```swift
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
})
// numberSum == 10
```
- 이렇게도 사용할 수 있다!
```swift
var reduce_int = [1,2,3,4,5]
var reduce_int_result = reduce_int.reduce(0, +)
print(reduce_int_result)           // reduce를 사용한 결과 -> 15
```
- **Reduce(_:_:)메서드가 호출되면, 아래와 같은 스텝들이 발생한다.**

1. The nextPartialResult closure is called with initialResult—0 in this case—and the first element of numbers, returning the sum: 1.

2. The closure is called again repeatedly with the previous call’s return value and each element of the sequence.

3. When the sequence is exhausted, the last value returned from the closure is returned to the caller.

- If the sequence has no elements, nextPartialResult is never executed and initialResult is the result of the call to reduce(_:_:).

## 🍎 배열의 요소수 만큼 안전하게 순회하기
- enumerated(), indices, count를 이용해 인덱스와 값 출력하기
- 주어진 배열
    ```swift
    let nums: [Int] = [1, 2, 3, 4]
    ```
### 📖 for - in과 같이 사용하는 예제
- for in + enumerated()
    ```swift
    for (index, num) in nums.enumerated() {
        print("(index: \(index) num: \(num))")
    }
    // (index: 0 num: 1) 
    // (index: 1 num: 2) 
    // (index: 2 num: 3) 
    // (index: 3 num: 4)
    ```
- for in + indices
    ```swift
    for index in nums.indices {
        print("(index: \(index) num: \(nums[index]))")
    }
    // 결과는 위와 같다.
    ```
- for in + count
    ```swift
    for index in 0..<nums.count {
        print("(index: \(index) num: \(nums[index]))")
    }
    // 결과는 위와 같다.
    ```
### 📖 for - Each와 같이 사용하는 예제
- for - Each + enumerated()
    ```swift
    nums.enumerated().forEach {
        print("(index: \($0) num: \($1))")
        // (index: 0 num: 1) 
        // (index: 1 num: 2) 
        // (index: 2 num: 3) 
        // (index: 3 num: 4)
    }
    ```
- for - Each + indices
    ```swift
    nums.indices.forEach {
        print("(index: \($0) num: \(nums[$0]))")
    }
    // 결과는 위와 같다.
    ```
## 🍎 for - in과 for - Each 차이점.
- 애플 공식문서에서는 for - in과 for - Each를 사용할 때 다른점 2가지를 보여주고 있다.
- continue / break
    - for - in으로 구현된 반복문에서만 사용가능. 왜? continue or break는 반복문에서만 사용 가능.
    - 그럼 for - Each는??
    - 애플 공식문서에 따르면 "Calls the given closure on each element in the sequence in the same order as a for-in loop."라고 한다. 즉, 주어진 클로져를 각각의 요소마다 부르는것.
- return
    - for - in으로 구현된 반복문에서 return은 해당 반복문을 빠져나온다(종료)
    - 하지만 클로져 내에서 return은 현재 클로져만 종료시킨다. -> 즉, 다음 클로져는 그대로 실행.

## 🍎 Citation
- [Apple reduce 공식문서](https://developer.apple.com/documentation/swift/array/reduce(_:_:))
- [split과 components 차이](https://0urtrees.tistory.com/95#:~:text=%2D%20split%EC%9D%80%20%EC%8A%A4%EC%9C%84%ED%94%84%ED%8A%B8%20%ED%91%9C%EC%A4%80%20%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC,%5BSubString%5D%EC%9D%84%20%EB%B0%98%ED%99%98%ED%95%A9%EB%8B%88%EB%8B%A4.)
- [flatMap / compactMap](https://jinshine.github.io/2018/12/14/Swift/22.%EA%B3%A0%EC%B0%A8%ED%95%A8%EC%88%98(2)%20-%20map,%20flatMap,%20compactMap/)
- [enumerated / indices](https://babbab2.tistory.com/95)
- [Apple forEach 공식문서](https://developer.apple.com/documentation/swift/array/foreach(_:))
