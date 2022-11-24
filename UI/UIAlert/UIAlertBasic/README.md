# Alert 정리

## 🍎 Alert창 만들기 순서

### 📖 1. Alert창 만들기
```swift
let alert = UIAlertController(title: "Your Title", message: "Your Message", preferredStyle: UIAlertController.Style.alert)
```
**preferredStyle 스타일 종류**
| alert | actionSheet |
|:-:|:-:|
| ![](https://i.imgur.com/nCKJBbk.png)| ![](https://i.imgur.com/hGsiZVb.png)|

- **alert** - 화면 중앙에 나타남 **(2개 이하 선택지)**
- **actionSheet** - 화면 하단에 나타남 **(3개 이상 선택지)**

### 📖 2. 필요에 따라 버튼 만들기
- 버튼이 눌렸을때 어떤 일을 수행해야 한다면 후행 클로져 내부 구현
```swift
let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
    // 내부 구현
}
```
- 버튼만 구현하고 싶다면
```swift
let cancelButton= UIAlertAction(title: "Cancel", style: .destructive, handler : nil)
```

### 📖 3. Alert창에 버튼 추가하기
- 추가하는 순서대로 들어간다.**(L->R)**
- HIG에서는 항상 취소버튼이 **왼쪽.**
- 하나의 UIAlertControll내 UIAlertActionStyle이 cancel인 액션버튼이 두개 이상 들어갈 수 없다. (**에러발생**)

```swift
alert.addAction(cancelButton)
alert.addAction(okButton)
```

### 📖 4. Alert창 띄우기
```swift
present(alert, animated: false, completion: nil)
```
