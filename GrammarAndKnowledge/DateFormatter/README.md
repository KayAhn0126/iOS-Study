# Date Formatter
- DateFormatter 클래스 사용해 변환하기
- 상황에 맞게 대응하기
    - 주어진 타입이 String 타입 -> Date타입으로 변환 후 format 변경
    - 주어진 타입이 이미 Date 타입 -> 바로 format 변경

## 🍎 현재 Date 가져오기
```swift
let currentDate = Date() // 2022-10-02 15:36:33 +0000 형식
```

## 🍎 자주 사용할 변환 메서드
```swift
open func string(from date: Date) -> String

open func date(from string: String) -> Date? // 실패시 nil 반환
```

## 🍎 String 타입에서 Date 타입으로
- 먼저 주어진 문자열이 어떤 형식을 가지고 있는지 확인.
```swift
// 기존 문자열을 Date? 타입으로 변경하기
let dateInString = "2022-10-02-14:38" // "yyyy-MM-dd-HH:mm" 형태이다 
                                      // 위의 형태를 "2022년 10월 2일 오후 2시 38분" 으로 바꾸는 과정 -> "yyyy년 MM월 d일 a hh시 mm분" 형태이다.
                                      // 오전/오후를 나타내고 싶으면 Locale을 한국으로 설정 default는 AM/PM
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
let convertToDate = dateFormatter.date(from: dateInString) // Date 타입으로 변환

// Date?타입으로 변경된 상수를 원하는 format으로 변경하기
let anotherDateFormatter = DateFormatter()
anotherDateFormatter.dateFormat = "yyyy년 MM월 d일 a hh시 mm분"
anotherDateFormatter.locale = Locale(identifier: "ko_KR") // AM/PM -> 오전/오후
let convertToString = anotherDateFormatter.string(from: convertToDate!)
```

|              년 ~ 요일               |            오전/오후 ~ 초            |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/AzSjsRD.jpg) | ![](https://i.imgur.com/RSfkdUi.png) |

[좋은노래님의 DateFormatter 정리](https://formestory.tistory.com/6)를 참고해 공부 후 작성
