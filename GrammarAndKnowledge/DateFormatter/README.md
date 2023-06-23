# Date Formatter

## 🍎 현재 Date 가져오기
```swift
let currentDate = Date() // 2022-10-02 15:36:33 +0000 형식
```

## 🍎 변환 메서드
```swift
open func date(from string: String) -> Date? // 주어진 문자열을 Date 객체로 만드는 메서드, 실패시 nil 반환

open func string(from date: Date) -> String // Date 객체를 문자열로 만들어준다. 이 메서드는 보통 이미 만들어져 있는 Date 객체를 특정 format으로 변환 후 출력하고 싶을때 사용한다.
```


## 🍎 만약 문자열 타입으로 주어진 날짜를 내가 원하는 포맷으로 바꾸고 싶다면?
- 큰 그림으로 본다면 아래와 같은 프로세스를 따른다.
    - 주어진 문자열을 데이터 객체로 만들기
    - 원하는 포맷으로 변경
    - 데이터 객체를 문자열로 바꿔서 출력하기
- 먼저 주어진 문자열로 데이터 객체 만들기
```swift
let dateInString = "2022-10-02"
// 데이터 객체를 만드려면, dateFormat이 일치해야 만들 수 있다. dateFormatter를 생성하고 위의 문자열과 같은 포맷으로 만들어준다.
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
// Date 객체 생성
let dateInDate = dateFormatter.date(from: dateInString)!
// 내가 원하는 포맷으로 변경
dateFormatter.dateFormat = "yyyy년 M월 d일"
// 문자열로 변경
let convertToString = dateFormatter1.string(from: dateInDate)
print(convertToString) // 2022년 10월 2일
```
## 🍎 날짜 비교하기
- 두개의 날짜를 비교하는 방법이다.
- 이해하기 쉽게 미국 유학을 시작한 날짜와 한국으로 돌아온 날짜를 비교했다.
```swift
let firstDate = "2010-01-18"
let lastDate = "2020-05-17"
```
- Date 객체 비교를 위해 두 문자열을 각각 Date 객체로 만들어준다.
```swift
let df = DateFormatter()
df.dateFormat = "yyyy-MM-dd"

let dateFirst = df.date(from: firstDate)!
let dateLast = df.date(from: lastDate)!
```
- Date 객체를 비교하는 함수를 만든다.
```swift
// date1이 date2보다 이전 날짜면 true를 반환하는 함수
func compareTwoDates(_ date1: Date, _ date2: Date) -> Bool {
    // orderedAscending -> 왼쪽이 오른쪽보다 작을 때.
    //     즉, 왼쪽 날짜가 오른쪽 날짜보다 전 일때.
    // orderedDescending -> 왼쪽이 오른쪽보다 클 때.
    //     즉, 왼쪽 날짜가 오른쪽 날짜보다 후 일때.
    if date1.compare(date2) == .orderedAscending {
        return true
    }
    return false
}
```

|              년 ~ 요일               |            오전/오후 ~ 초            |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/AzSjsRD.jpg) | ![](https://i.imgur.com/RSfkdUi.png) |

[좋은노래님의 DateFormatter 정리](https://formestory.tistory.com/6)를 참고해 공부 후 작성
