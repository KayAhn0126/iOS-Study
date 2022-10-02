# Number Formatter

- Number Formatter를 사용해 변환하기

## 🍎 숫자에서 문자로
- **일반 숫자를 세자리마다 "," 추가해서 나타내고 싶을때**
```swift
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal // 10진수 표현
let testNumber = 12345678
let result = numberFormatter.string(for: testNumber)
print(result) // Optional(12,345,678)
```

- **소수를 세자리마다 "," 추가해서 나타내고 싶을때**
```swift
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal

let result = numberFormatter.string(for: 12345678.12345678)
print(result) // Optional(12,345,678.123)
```

> 소수점을 .decimal로 표현하면 소수점 최대 3자리 까지 표현. -> 경우에 따라 문제가 될수 있음.
> 아래와 같이 maximumFractionDigits 프로퍼티를 사용해 소수점 최대 자리수를 지정 해주자.

- **소수를 세자리마다 "," 추가해서 나타내고 싶을때 + maximumFractionDigits 사용**
```swift
let numberFormatter = NumberFormatter()

numberFormatter.numberStyle = .decimal 
numberFormatter.maximumFractionDigits = 8

let testNumber = 12345678.12345678
let result = numberFormatter.string(for: testNumber)
print(result) // Optional(12,345,678.12345678)
```

- **소수를 세자리마다 "," 추가해서 나타내고 싶을때 + maximumFractionDigits 반올림 케이스**

```swift
let numberFormatter = NumberFormatter()

numberFormatter.numberStyle = .decimal
numberFormatter.maximumFractionDigits = 7

let testNumber = 12345678.12345678
let result = numberFormatter.string(for: testNumber)
print(result) // Optional(12,345,678.1234568) -> 7자리 까지 끊고 마지막 자리 반올림
```

- **roundingMode 프로퍼티 사용으로 소수점 처리**
```swift
let numberFormatter = NumberFormatter()
numberFormatter.roundingMode = .ceiling
let result = numberFormatter.string(for: 1234567.123456)
print(result) // Optional("1234568") -> 소수 부분이 1 이상이면 소수를 모두 버리고 정수 + 1
let result2 = numberFormatter.string(for: 1234567.0)
print(result2) // Optional("1234567") -> 소수 부분이 0이기 때문에 정수 그대로 출력
```
## 🍎 간단 정리
- **numberStyle**은 어떻게 표현할 것인지 정하는 프로퍼티
- **maximumFractionDigits**는 소수점 강제. 만약 원래숫자가 더 길다면 마지막 자리에서 반올림.
- **roundingMode** 프로퍼티는 어떻게 소수점을 처리할 것인지 정하는 프로퍼티
- 상위 세개의 프로퍼티의 조합의 가지수가 워낙 많아 실행할 때마다 테스트 진행하기. (좀 더 정확한 특징을 찾으면 업데이트 예정)


## 🍎 numberStyle enum 구성
```swift
public enum Style : UInt, @unchecked Sendable {
    case none = 0
    
    case decimal = 1
    
    case currency = 2     // $12,345
    
    case percent = 3     // 99%
    
    case scientific = 4
    
    case spellOut = 5     // one thousand three hundreds
    
    @available(iOS 9.0, *)
    case ordinal = 6

    @available(iOS 9.0, *)
    case currencyISOCode = 8

    @available(iOS 9.0, *)
    case currencyPlural = 9

    @available(iOS 9.0, *)
    case currencyAccounting = 10
}
```

## 🍎 maximumFractionDigits 프로퍼티
- [공식문서](https://developer.apple.com/documentation/foundation/nsnumberformatter/1415364-maximumfractiondigits)
- The maximum number of digits after the decimal separator 라고 설명.
- 공식 문서의 예제
```swift
var numberFormatter = NumberFormatter()

numberFormatter.maximumFractionDigits = 0 // default
numberFormatter.string(from: 123.456) // 123

numberFormatter.maximumFractionDigits = 3
numberFormatter.string(from: 123.456789) // 123.457
```

## 🍎 roundingMode enum 구성
```swift
public enum RoundingMode : UInt, @unchecked Sendable {
    case ceiling = 0

    case floor = 1

    case down = 2

    case up = 3

    case halfEven = 4

    case halfDown = 5

    case halfUp = 6
}
```
