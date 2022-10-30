# Regular Expression
- [정규식 연습 사이트](https://regex101.com

## 🍎 정규식은 크게 2가지로 만들 수 있다.
- **NSPredicate**
    - 메모리 내 필터링이나 검색을 통한 패치 -> Collection안의 내용을 검색 혹은 필터하는 용도
    - NSPredicate는 코드가 간결하다.
- **NSRegularExpression**
    - 유니코드 문자열에 적용되는 정규식의 표현 -> 정규식
- 흔히 말하는 정규 표현식은 NSRegularExpression.
- **아직 NSPredicate와 NSRegularExpression을 각각 언제 사용해야하는지 확실하지 않음**

## 🍎 정규식 문법 알아보기
- ^ : 시작.
- $ : 종료.
- (?=.* 로 시작: 조건문
- {0,} : 0개 이상.
- [] : 괄호안에 있는 문자 중 임의의 한 문자.
    - 예제 1
    ```swift
    let pattern = "^[A-Za-z0-9]{0,}$"
    ```
    - 즉, 0개 이상의 대문자 or 소문자 or 숫자로 이루어져 있는 문자열.
    - 예제 2
    ```swift
    let pattern = (?=.*[A-Z].*[A-Z]) // 대문자가 2자 이상 있어야 한다.
    let pattern = (?=.*[a-z].*[a-z].*[a-z]) // 소문자가 3자 이상 있어야 한다.
    ```
## 🍎 바로 예제를 통해 알아보자
### 📖 예제 1
```swift
private func emailValidateThroughNSRegularExpression(_ email: String) -> Bool {
    let emailPattern = #"^[A-Z0-9a-z._%-+]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"#
    let regex = try? NSRegularExpression(pattern: emailPattern)
    let range = NSRange(location: 0, length: email.count)
    if regex?.firstMatch(in: email, range: range) != nil {
        return true
    } else {
        return false
    }
}
```
- NSRegularExpression을 사용해 문자열이 이메일 형태인지 확인하는 메서드.
- **상수 emailPattern 분석**
    - [A-Z0-9a-z._%-+] -> 영어 대,소문자와 숫자, 그리고 . - % - +
    - +@ -> 위의 조건 다음에 골뱅이가 와야하고
    - [A-Z0-9a-z.-] -> 골뱅이 다음에는 영어 대,소문자와 숫자 . - 가 와야한다.
    - +\. -> 위의 조건 다음에 .(dot)이 와야하고
    - [A-Za-z]{2,4} -> 영어 대,소문자가 2개 이상 4개 이하 있어야 한다.
```
// "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}$" <-- 기존 정규식
//                                     ^
//                                     |
//                                     |
//                     전체 정규식을 '#'으로 감싸면 화살표 부분을 아래와 같이 사용할 수 있다.
// #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"# <-- '#'으로 감싼 정규식
```
### 📖 예제 2
```swift
private func emailValidateThroughNSPredicate(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"#
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
```
- **위에 NSRegularExpression을 통해 이메일 형태가 맞는지 체크하는 정규식은 같다.**
- 하지만 예제2 메서드는 NSPredicate로 구현한 코드이다. -> **어떻게 쓰는지 구현 방식을 보자**.

### 📖 예제 3
- **대문자, 소문자, 특수문자, 숫자 각각 1개씩 꼭 들어가고 8자 이상인 문자열** -> true
```swift
func validateThroughNSPredicate2() -> Bool {
    let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!*%?&]).{8,}"
    let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
    return passwordValidation.evaluate(with: self)
}
```
- 상수 regularExpression 분석
    - (?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!*%?&]) -> 대문자 1개, 소문자 1개, 숫자 1개, 특수문자 1개 를 충족해야 한다.
    - .{8,} -> 길이는 최소 8이상이 되야한다.

### 📖 예제 4
- 대문자가 2개, 소문자가 3개, + . + 숫자가 4개 있어야 true가 되는 메서드
```swift
func customCheck() -> Bool {
    let regularExpression = "^[A-Z]{2}+@[a-z]{3}+\\.[0-9]{4}$"
    let validation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
    return validation.evaluate(with: self)
}
```
- {숫자} -> 딱 숫자만큼 자리수를 지정할 수 있다.

## 🍎 NSRegularExpression 객체 만드는 과정에서 생긴 궁금증.
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
