# sendActions 메서드 이해하기

## 🍎 sendActions 메서드의 원형 살펴보기
```swift
/// send all actions associated with the given control events
open func sendActions(for controlEvents: UIControl.Event)
```
- UIControl.Event를 매개변수에 넘겨주면 메서드를 호출한 객체의 리스폰더에게 전달한다. 

## 🍎 왜 sendActions 메서드를 공부 하기전 코드 분석
![](https://i.imgur.com/Y76O7Vb.png)
- 위의 코드를 참고하면서 읽자.
### 📖 1번 코드 설명
```swift
self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
```
- dateTextField에서 editingChanged라는 이벤트가 발생하면 dateTextFieldDidchange(_:) 메서드를 실행한다.
### 📖 2번 코드는 dateTextField에서 editingChanged 이벤트가 발생하면 실행될 메서드
- 추가 설명 없음
### 📖 3번 코드 설명
```swift
self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
```
- datePicker에서 valueChanged라는 이벤트가 발생하면 datePickerValueDidChange 메서드를 실행한다
### 📖 4번 코드 설명
```swift
self.dateTextField.inputView = self.datePicker
```
- dateTextField를 클릭하면 날짜를 선택할 수 있도록 datePicker를 dateTextField.inputView 프로퍼티에 넣어준다.
### 📖 5번 코드 설명
```swift
self.dateTextField.sendActions(for: .editingChanged)
```
- dateTextField에 editingChanged라는 이벤트를 전달한다.
    - 마치 dateTextField에서 editingChanged라는 이벤트가 발생한 것 처럼 된다.

## 🍎 sendActions 메서드 사용 이유.
- 이유는 객체에 이벤트를 보내기 위함이다.
- datePicker는 날짜가 선택되면 (값이 변경되면) valueChanged라는 이벤트를 발생시킨다.
    - 현재는 dateTextField.inputView에 datePicker가 대입되어 있으므로 날짜가 바뀔때마다 생기는 이벤트는 valueChanged다.
    - 그럼 1번 코드에서 dateTextField에 연결된 editingChanged 이벤트는 언제 발생하나?
    - editingChanged 이벤트는 키보드로 무언가가 입력될 때 dateTextField에 발생 시킨다.
    - 즉, editingChanged 이벤트를 직접 보내주면 1번라인에 연결되어있는 dateTextFieldDidChange 메서드가 실행이 된다.
    - 이 작업을 datePickerValueDidChange 메서드의 마지막 줄에 넣어줘서 마치 dateTextField가 닫힌것처럼 보이도록 만들어 주기 위함이다.

## 🍎 순서를 통해 확실하게 기억하자
1. viewDidLoad()에서 configureDatePicker()실행
2. configureDatePicker() 메서드 내 datePicker의 addTarget이 메서드와 연결됨 + dateTextField.inputView에 datePicker 대입
3. 이제부터는 dateTextField를 클릭하면 날짜를 선택할 수 있음
4. 날짜가 선택되면 valueChanged 이벤트를 발생시킨다. 하지만 configureInputField()메서드 안을 보면 dateTextField는 editingChanged라는 이벤트를 만나면 dateTextFieldDidChange 메서드를 실행시키기 때문에 날짜가 바뀔때 마다 실행되는 datePickerValueDidChange() 메서드의 마지막에 sendActions(for: .editingChanged) 메서드를 실행시켜 dateTextField에 editingChanged 이벤트 전달.
