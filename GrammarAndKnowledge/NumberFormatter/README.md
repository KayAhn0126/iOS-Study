# Number Formatter

- Number Formatter를 사용해 변환하기

## 🍎 숫자에서 문자로

```swift
let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal // 10진수 표현
let testNumber = 12345678
let result = numberFormatter.string(for: testNumber)
print(result) // 12,345,678
```





## 🍎 numberStyle enum 구성
```swift
public enum Style : UInt, @unchecked Sendable {
        case none = 0
    
        case decimal = 1
    
        case currency = 2
    
        case percent = 3
    
        case scientific = 4
    
        case spellOut = 5
    
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
