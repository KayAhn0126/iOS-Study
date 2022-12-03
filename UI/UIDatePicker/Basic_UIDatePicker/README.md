# UIDatePicker 기본정리

## 🍎 UIDatePicker 살펴보기
- UIDatePicker는 유저가 날짜나 시간을 선택할 수 있도록 도와주는 객체
- date picker를 추가하기 위해선 아래의 과정을 수행해야 한다.
    - date picker mode를 설정
    - 필요에 따라 minimum or maximum 날짜를 설정
    - action method를 date picker에 설정
    - date picker 의 오토레이아웃 설정
- date picker는 오직 시간과 날짜를 선택하는 용도로 쓰여지고 만약 특정 리스트의 아이템들 중 하나를 고르는 상황이라면 UIPickerView 객체를 사용하면 된다.

## 🍎 UIDatePicker 구성하기
- datePickerMode 프로퍼티는 코드로 작성 또는 Interface builder로 세팅 할 수 있고 date picker의 구성을 결정한다.
    - 구성을 결정 한다는 것은 datePickerMode 프로퍼티에 들어갈 수 있는 time, date, dateAndTime, (countDownTImer는 제외)만 설정 해주어도 유저의 지역, 날짜, 타임존 정보를 바탕으로 자동 설정을 해준다는 의미.
    ```swift
    private func setAttributes() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    ```
    - datePickerMode만 설정해 주어도 사용하는데 문제는 없지만, 필요에 따라 locale, calendar, time zone 정보를 설정해 사용할 수 있다.
    ```swift
    private func setAttributes() {
        datePicker.backgroundColor = .green
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "kr-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.minuteInterval = 15
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    ```
    - datePickerMode의 countDownTimer모드는 나중에 더 공부하기.

## 🍎 유저의 선택에 따라 실행되는 action 메서드 연결하기
- 아래의 코드 맨 마지막 라인은, datePicker에 value가 변경 될때 마다 실행되는 메서드를 추가해, 유저가 선택한 값이 변경 될때 마다 실행하고 싶은 코드를 넣어주었다.
```swift
private func setAttributes() {
    ...
    ...
    datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
}

@objc
private func handleDatePicker(_ sender: UIDatePicker) {
    print(sender.date)
}
```

## 🍎 UIDatePicker 테스트 코드
```swift
import UIKit

class ViewController: UIViewController {

    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        datePicker.backgroundColor = .green
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }

    private func setContraints() {
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: - Selectors
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
}
```

## 🍎 UIDatePicker에서 사용하는 프로퍼티에 대해서..
- 미리 알아두면 좋은 정보
    - Swift언어 이전에는 class 타입으로 구현 방식을 제공했었다(NS 접두어로 시작하는..)
    - Swift언어가 생겨난 이후에는 struct타입으로 구현된 방식이 제공되어 현재는 대부분 struct로 구현된 방식을 사용한 날짜 처리 코드가 구현된다고 한다.
    - class: NSdate, NSCalendar, NSDateComponents, NSTimeZone, NSLocale
    - struct: Date, Calendar, DateComponents, TimeZone, Locale
    - struct으로 구현된 Date, Calendar등의 타입은 모두 브릿징을 지원하기 떄문에 필요한 상황에 따라 as 연산자로 타입을 캐스팅 해서 사용이 가능.

## 🍎 UIDatePicker 객체 생성 후 기본적으로 설정해주어야 할것들
- datePicker의 배경색상은 .green으로 설정해 datePicker가 화면의 어느부분을 차지하는지 보여준다.
- 즉, 초록부분으로 칠해진 범위는 모두 datePicker라는 의미
- 앱을 실행시켜 날짜를 고르면 @objc handleDatePicker 메서드에서 정보를 console로 내보내고 있는데, 선택한 날짜/시간과  다른것을 알수 있다. 이것은 잘못된 부분이 아니라 기본적으로 표시되는 시간이 GMT Format을 따르고 있기 때문이다.
- NSDateFormatter를 통해 원하는 시간대로 바꿔줄 수 있다.

### 📖 datePickerMode
- 따로 설정을 안해주어도 되지만, 설정하기를 추천.
- 미 설정시, dateAndTime이 기본 적용.
- time
    - 시간
- date
    - 날짜
- dateAndTime
    - 날짜와 시간
- countDownTimer
    - 타이머 기능을 제공

### 📖 preferredDatePickerStyle
- 따로 설정을 안해주어도 되지만, 설정하기를 추천.
- 미 설정시, .automatic이 기본 적용된다.
- compact
    - 간단하게 label형태로 보여주고 클릭되면 캘린더를 보여주는 스타일
    - datePickerMode에 같이 사용했을 때

| .time | .date | .dateAndTime |
| :-: | :-: | :-: |
|![](https://i.imgur.com/qMFOMZi.png) | ![](https://i.imgur.com/dNWPJdD.png) | ![](https://i.imgur.com/7MfDfhB.png) |

- inline
    - 클릭되면 캘린더 형식으로 보여주는 compact스타일이 아닌 화면에 바로 캘린터를 띄우는 스타일
    - datePickerMode에 같이 사용했을 때

| .time | .date | .dateAndTime |
| :-: | :-: | :-: |
| ![](https://i.imgur.com/Jc7LOx4.png) | ![](https://i.imgur.com/9Zm6gb0.png) | ![](https://i.imgur.com/cvIZrw9.png) |

- wheels
    - 휠로 돌리면서 선택할 수 있는 스타일
    - datePickerMode에 같이 사용했을 때

| .time | .date | .dateAndTime |
| :-: | :-: | :-: |
| ![](https://i.imgur.com/QGt49Iv.png) | ![](https://i.imgur.com/0isbIKR.png) | ![](https://i.imgur.com/GVj24la.png) |

### 📖 Locale
- UIDatePicker에 사용될 국가를 입력한다.
- 아무것도 설정하지 않으면 아이폰 기본 설정을 따른다.
```swift
datePicker.locale = Locale(identifier: "ko-KR")
```

### 📖 minuteInterval
- 사용자가 스크롤을 돌려 시간을 설정할 때 나타나는 분 단위 간격을 조절하는 프로퍼티이다. 기본은 1분으로 되어있고 최대 30분으로 설정 할 수 있고 60의 약수 미만에서 입력하면 된다.
```swift
datePicker.minuteInterval = 15
```
![](https://i.imgur.com/J2I1HEM.png)


### 📖 date
- 최초에 선택 되어있는 날짜를 설정하는 프로퍼티, 기본은 현재 날짜이다.
- 특정 시간만큼 지난 시각을 가진 Date를 만들고 싶다면 Date(timeIntervalSinceReferenceDate:) 생성자로 설정할 수 있다.
- timeIntervalSinceReferenceDate에는 TimeInterval 값이 들어와야 하는데 TimeInterval은 Double과 typealias되어있다.
- TimeInterval은 초단위이고, 단독으로 사용하는 경우는 거의 없다. 주로 Date와 연계해서 사용한다.
```swift
let oneDayBefore = Date(timeIntervalSinceNow: -3600 * 24 * 3) 
datePicker.date = oneDayBefore
// 이런 식으로 사용 가능하다.
```
- 위 코드 적용 시 3일 전으로 세팅되는것을 볼 수 있다.

| 코드 미적용 | 코드 적용 |
| :-: | :-: |
| ![](https://i.imgur.com/Q6oMdvw.png) | ![](https://i.imgur.com/tdtgrI6.png) |

### 📖 calendar
- 생성할수 있는 3가지 방법
```swift
let customCalendar = Calendar(identifier: .gregorian)
// 직접 캘린더의 종류를 설정, enum 형태로 만들어져 있어 gregorian 외에도 다양한 종류의 캘린더를 확인할 수 있음
let systemCalendar = Calendar.current
// 사용자의 아이폰 설정 캘린더 정보를 가져와서 사용하지만, 날짜가 로드된 이후 사용자가 설정에서 변경하는 내용은 적용되지 않음
let autoUpdatingSystemCalendar = Calendar.autoupdatingCurrent
// 아이폰에서 설정되어 있는 달력을 기준으로 값을 리턴
```
- .current와 .autoupdatingCurrent의 차이가 무엇일까? 테스트하고 정리하기.

### 📖 minimumDate, maximumDate
- 사용자가 선택할 수 있는 날짜나 시간을 한정할 수 있게 도와주는 프로퍼티.
- .compact나 .inline모드에서는 선택할 수 있는 날짜가 연한 회색으로 비 활성화되고, .wheel모드에서는 선택해둔 범위를 넘어가는 스크롤을 하는 경우 가장 가까운 날짜 또는 시간으로 이동한다.
```swift
var components = DateComponents()
components.day = 10
let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
components.day = -10
let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
datePicker.maximumDate = maxDate
datePicker.minimumDate = minDate
```
![](https://i.imgur.com/xvby4n0.gif)

### 📖 locale
- [locale 프로퍼티에 대한 공식 문서](https://developer.apple.com/documentation/uikit/uidatepicker/1615995-locale)에 따르면 "기본으로 설정된 locale 값은 NSLocale의 'current'프로퍼티가 반환한 값 또는 date picker의 캘린더에 사용된 locale로 정한다"라는 설명이 있다. locale은 언어, 문화 날짜 표기 방법 등 정보들을 캡슐화 하고 있다.
- 가장 기본적인 locale 설정 방법은 아래의 코드와 같다.
```swift
datePicker.locale = Locale(identifier: "ko-KR")
// or
datePicker.locale = Locale(identifier: "en-EN")
```
|  KR  |  EN  |
|:----:|:----:|
| ![](https://i.imgur.com/ZelXHoS.png) | ![](https://i.imgur.com/ZglNrmM.png) |


## 🍎 Citation
- [Apple 공식 문서 UIDatePicker.Mode](https://developer.apple.com/documentation/uikit/uidatepicker/mode)
- [Apple 공식 문서 UIDatePickerStyle.automatic](https://developer.apple.com/documentation/uikit/uidatepickerstyle/automatic)
- [UIKit - Date Picker 사용하기, iOS 14 변경사항 정리](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/)
- [UIKit - Calendar 와 Date 기초 익히기](https://kasroid.github.io/posts/ios/20201026-uikit-handling-date/)
