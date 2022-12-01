# UIDatePicker 기본정리
- 설명에서 사용된 코드는 [UIKit - Date Picker 사용하기, iOS 14 변경사항 정리](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/)에서 가져왔습니다.

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







## 🍎 Citation
- [Apple 공식 문서 UIDatePicker.Mode](https://developer.apple.com/documentation/uikit/uidatepicker/mode)
- [Apple 공식 문서 UIDatePickerStyle.automatic](https://developer.apple.com/documentation/uikit/uidatepickerstyle/automatic)
- [UIKit - Date Picker 사용하기, iOS 14 변경사항 정리](https://kasroid.github.io/posts/ios/20201030-uikit-date-picker/)
