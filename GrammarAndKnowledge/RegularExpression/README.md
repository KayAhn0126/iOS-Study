# Regular Expression
- [정규식 연습 사이트](https://regex101.com

## 🍎 정규식에는 크게 2가지 타입이 있다.
- **NSPredicate**
    - 메모리 내 필터링이나 검색을 통한 패치 -> Collection안의 내용을 검색 혹은 필터하는 용도
    - NSPredicate는 코드가 간결하다.
- **NSRegularExpression**
    - 유니코드 문자열에 적용되는 정규식의 표현 -> 정규식
- 흔히 말하는 정규 표현식은 NSRegularExpression.
- **아직 NSPredicate와 NSRegularExpression을 각각 언제 사용해야하는지 확실하지 않음**

## 🍎 NSRegularExpression 문법 알아보기
- ^ : 시작.
- $ : 종료.
- {0,} : 0개 이상.
- [] : 괄호안에 있는 문자 중 임의의 한 문자.
    - 예제
    ```swift
    let pattern = "^[A-Za-z0-9]{0,}$"
    ```
    - 즉, 0개 이상의 대문자 or 소문자 or 숫자로 이루어져 있는 문자열.

## 🍎 NSRegularExpression 객체 만들어보기
- NSRegularExpression(pattern: pattern)으로 객체를 생성.
- [pattern을 이용해 객체를 만드는 NSRegularExpression 생성자](https://developer.apple.com/documentation/foundation/nsregularexpression/1410900-init)내 Declaration을 보면,
    ```swift
    init(
    pattern: String,
    options: NSRegularExpression.Options = []
    ) throws
    ```
    - 에러를 반환할 수 있는 생성자이므로, try를 사용해 에러 핸들링을 해주어야 한다.
- 아래 예제는 NSRegularExpression 객체를 만들어 firstMatch 메서드를 실행하는 코드.
```swift
let pattern = "^[A-Za-z0-9~!@#$%^&*]{0,}$"
let regex = try? NSRegularExpression(pattern: pattern)
if let _ = regex?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) {
        // 있는경우            
}
```
- 여기서 regex 상수와 상수에 대입할 값을 보면 try가 아닌 try?를 사용하고 있다.
```swift
let regex = try? NSRegularExpression(pattern: pattern)
```
- **왜 try가 아닌 try?를 왜 사용할까?**
    - try를 사용하려면 do-catch문이 필요하다. 여기서는 간단하게 알아보기 위해 try? 사용.
    - try 복습
        - try -> do-catch 필요 / 에러가 발생하지 않으면 일반 값
        - try? -> do-catch 필요 x / 에러가 발생하지 않으면 옵셔널, 발생하면 nil
        - try! -> do-catch 필요 x / 에러가 발생하지 않으면 일반값, 발생하면 crash


## 🍎 Citation
- [Easy REGEX in Swift](https://www.youtube.com/watch?v=_3-uWtTO_Sc)
- [NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression/1410900-init)
