# UIResponder 기본 개념

## 🍎 정의
- 이벤트에 응답하고 처리하는 추상적 인터페이스
- UIKit앱 이벤트 처리의 중추 역할을 한다.
- UIResponder 클래스를 통해 생성된 인스턴스 말고도 UIApplication, UIViewController, UIView(UIWindow 포함)의 인스턴스 또한 responder라고 할 수 있다.
    - 방금 나열한 클래스들은 UIResponder의 서브 클래스
- 이벤트가 발생하면, UIKit이 발생한 이벤트들을 앱의 responder 객체에 전달한다.

## 🍎 responder 객체가 전달받는 이벤트
- **이벤트의 종류를 알아보자**
    - touch events
    - motion events
    - remote-control events
    - press events
- **특정 이벤트를 처리하기 위해서는 responder 객체는 이벤트에 맞는 메서드를 재정의 후 사용해야한다.**
- 예를 들어 터치 이벤트를 처리하기 위해선 아래와 같은 메서드를 재정의 후 사용하면 된다.
     - [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan)
     - [touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved)
     - [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended)
     - [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled)
- 터치 이벤트 같은 경우, responder는 UIKit이 제공하는 이벤트 정보를 사용해 **변경 사항을 추적하고 그에 따라 적절하게 앱의 인터페이스를 업데이트 한다.**
- UIKit의 응답자는 처리되지 않은 이벤트들을 앱의 다른 곳으로 전달하는것도 관리한다.
- 만약 응답자가 이벤트를 처리하지 않으면 responder chain에 의해서 "현재 처리 해야하는 이벤트"에서 "다음에 처리해야 하는 이벤트"로 미룬다.
- UIKit은 responder. chain을 동적으로 관리한다. 미리 정해져있는 규칙에 따라 어떤 객체가 다음 이벤트를 받을지 정해져있다. 예를 들어, 뷰는 이벤트를 상위 뷰로 전달하고 루트 뷰는 이벤트를 뷰 컨트롤러로 전달한다.

## 🍎 UIResponder의 inputView 프로퍼티
- responder는 UIEvent 객체를 처리도 할 수 있고 또, 사용자가 지정한 입력을 input view를 통해서 받을 수도 있다.
- 앱의 스크린 속 UITextField 또는 UITextView 객체를 클릭하면 view는 first responder가 되고, 객체 자체의 input view인 가상 키보드를 전시한다.
- 아래와 같이 커스텀 input views를 만들고 다른 응답자가 활성화 될때 전시하는 방법도 있다.
```swift
// 예시 코드
private func configureDatePicker() {
    self.datePicker.datePickerMode = .date    self.datePicker.preferredDatePickerStyle = .wheels
    self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
    self.datePicker.locale = Locale(identifier: "ko_KR")
    self.dateTextField.inputView = self.datePicker
}
```
## 🍎 responder 관련 두 개의 메서드
- becomeFirstResponder() -> Bool
    - UIKit에게 객체를 first responder로 만들어 줄수 있는지 묻고 만약 가능하면 true를 반환하고 불가능하면 false를 반환한다.
- resignFirstResponder() -> Bool
    - resign은 '사임하다'라는 뜻이다.
    - 즉, firstResponder에서 물러나겠다는 의미이다.

## 🍎 Citation
- [UIResponder 공식 문서](https://developer.apple.com/documentation/uikit/uiresponder)
- [UIResponder 클래스의 inputView 프로퍼티](https://developer.apple.com/documentation/uikit/uiresponder/1621092-inputview)
