# addTarget 메서드 정의 및 사용법

## 🍎 UIControl 클래스 내 addTarget 메서드 원형 살펴보기
```swift
open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
```

## 🍎 평소에 많이 사용하던 addTarget 메서드
- 버튼이 클릭 되었을때 실행될 메서드를 추가하기 위해서 아래와 같이 addTarget 메서드를 사용 해본적이 있다.
```swift
// 예제
@IBOutlet weak var myButton: UIButton!
myButton.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
```

## 🍎 UIButton 이외 클래스 인스턴스에서 addTarget 메서드 사용하기
- 지금까지는 UIButton 클래스를 통해 생성한 인스턴스에서만 사용되는 메서드인줄 알고있었다.
    - 후술할 내용이지만 addTarget메서드는 UIControl 클래스의 인스턴스 메서드.
    - UIDatePicker와 UITextField는 UIControl을 상속받는다.
- addTarget(_:, action:, for:) 메서드가 여러곳에서 유용하게 사용되는 경험을 바탕으로 공부 및 정리.
- 이번 Diary 프로젝트를 진행하면서 UIButton이 아닌 다른 타입의 인스턴스에 addTarget 메서드를 적용하는 코드가 있었다.
    - UIDatePicker 
    ```swift
    self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
    ```
    - UITextField
    ```swift
    self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    ```
- **addTarget을 사용하는 주체 객체에 따라 for: argument에 작성되는 UIControl.Event의 값이 다르다.**

## 🍎 UITextView 클래스를 통해 생성된 객체가 addTarget 메서드를 사용할 수 없는 이유
- 두 타입 이외에 UITextView도 있었는데 TextView는 UIControl 클래스를 상속 받고있지 않아 addTarget 메서드를 사용할 수 없다. 그래서 UITextViewDelegate를 채택하고, func textViewDidChange(_ textView: UITextView)를 준수해, 해당 메서드에서 TextView 객체에 변화가 생길 때 마다 할 일들을 구현했다.
- 간단하게 UITextView가 addTarget 메서드를 사용할 수 없는 이유를 정리했다.
    - UIDatePicker -> UIControl 상속
    - UITextField -> UIControl 상속
    - 여기서 UIButton도 -> UIControl을 상속한다는것을 알 수 있다.
    - **UITextView -> UIScrollView 상속**
    - **UIControl을 상속 받지 않으니 addTarget 메서드 사용 불가.**

## 🍎 발견한 점 & 궁금한 점
- 발견한 점
    ```swift
    @IBOutlet weak var myButton: UIButton!
    myButton.addTarget(self, action: #selector(doSomething(_:)), for: .touchUpInside)
    ```
    - addTarget내 첫번쨰 인자 self는 현재의 View Controller이다.
    - #selector는 현재 View Controller내 doSomething 메서드이다
    - for에는 해당 이벤트가 발생하면 action 메서드가 실행되도록 되어있다.
    - 지금까지는 위의 코드처럼 action 인자에 들어가는 메서드는 현재 클래스 내에서만 구현해서 사용했다.
    - 궁금증이 생겨 다른 클래스의 메서드는 사용할 수 없을까 해서 테스트를 해보았다.
    ```swift
    // 
    import UIKit

    class DiaryCollectionViewCell: UICollectionViewCell {
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
        @objc public func doThis(_ button: UIButton) {
            print("hello")
        }
    }

    class WriteDiaryViewController: UIViewController {
        ...
        @IBOutlet weak var myButton: UIButton!
        var diaryCollectionViewCell: DiaryCollectionViewCell
        
        func configure() {
            myButton.addTarget(diaryCollectionViewCell, action: #selector(diaryCollectionViewCell.doThis(_:)), for: .touchUpInside)
        }
    }
    ```
    - **이와 같이 다른 클래스의 인스턴스를 생성하고 사용할 수 있다.**
- 궁금한 점
    - 위와 같은 코드를 작성했을때 구현 당시는 편하고 작동하는데 문제는 없을 수 있지만 이로 인해 생길 사이드 이펙트는 아직 생각해보지 못했다.
    - 추후에 비슷한 상황이 생겨 궁금증이 풀리면 다시 작성하기.
