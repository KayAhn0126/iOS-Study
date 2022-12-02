# UIDatePicker 기본정리
- 아래 내용은 [UIKit - Date Picker 사용하기, iOS 14 변경사항 정리](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/)의 코드를 가져와 일부 수정하며 테스트 한 내용을 정리한 것

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

## 🍎 UIDatePicker 객체 생성 후 기본적으로 설정해주어야 할것들
- datePicker의 배경색상은 .green으로 설정해 datePicker가 화면의 어느부분을 차지하는지 보여준다.
- 즉, 초록부분으로 칠해진 범위는 모두 datePicker라는 의미
- 앱을 실행시켜 날짜를 고르면 @objc handleDatePicker 메서드에서 정보를 console로 내보내고 있는데, 선택한 날짜/시간과  다른것을 알수 있다. 이것은 잘못된 부분이 아니라 기본적으로 표시되는 시간이 GMT Format을 따르고 있기 때문이다.
- NSDateFormatter를 통해 원하는 시간대로 바꿔줄 수 있다.

### 📖 datePickerMode
- time
    - 시간
- date
    - 날짜
- dateAndTime
    - 날짜와 시간
- countDownTimer
    - 타이머 기능을 제공

### 📖 preferredDatePickerStyle
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
- datePickerMode가 .countDownTimer일 경우, 0:00에서 시작한다.
- default is current date when picker created. Ignored in countdown timer mode. for that mode, picker starts at 0:00
```swift
datePicker.date = Date(timeIntervalSinceNow: -3600 * 24 * 3)
```
- 위 코드 적용 시 3일 전으로 세팅되는것을 볼 수 있다.

| 코드 미적용 | 코드 적용 |
| :-: | :-: |
| ![](https://i.imgur.com/Q6oMdvw.png) | ![](https://i.imgur.com/tdtgrI6.png) |

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
|  ![](https://i.imgur.com/ZelXHoS.png) | ![](https://i.imgur.com/ZglNrmM.png) |


## 🍎 Citation
- [Apple 공식 문서 UIDatePicker.Mode](https://developer.apple.com/documentation/uikit/uidatepicker/mode)
- [Apple 공식 문서 UIDatePickerStyle.automatic](https://developer.apple.com/documentation/uikit/uidatepickerstyle/automatic)
- [UIKit - Date Picker 사용하기, iOS 14 변경사항 정리](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/)
