# Applying a new attribute to the UIButton
## 🍎 새로운 속성 적용 전,후 비교 이미지

### 📖 속성 적용 전
![](https://i.imgur.com/9nc7vlf.png)

### 📖 새로운 속성 적용 후 
![](https://i.imgur.com/H5VcTfO.png)


## 🍎 전체적인 흐름.
- UIButton에는 setAttributedTitle이라는 메서드가 있다.
```swift
func setAttributedTitle(_ title: NSAttributedString?,
                        for state: UIControl.State)
```
- 즉, NSAttributedString 타입과 UIControl.State 타입의 값A을 매개변수로 넘겨주면 해당 버튼의 Title 속성을 방금 넘겨받은 속성으로 세팅한다.
- 버튼에 새로운 속성을 적용하는 코드를 보자.
```swift
private func setupAttribute() {
    // setting attributes for signUpButton
    let askQuestionText = "계정이 없으신가요?"
    let signUpText = "가입하기"
        
    let askQuestionTextFont = UIFont.systemFont(ofSize: 13)
    let signUpTextFont = UIFont.boldSystemFont(ofSize: 13)
        
    let askQuestionTextColor = UIColor.darkGray
    let signUpTextColor = UIColor(named: "facebookColor")!
        
    let attributes = generateButtonAttribute(self.signUpButton,
                                             texts: askQuestionText, signUpText,
                                             fonts: askQuestionTextFont, signUpTextFont,
                                             colors: askQuestionTextColor, signUpTextColor)
     self.signUpButton.setAttributedTitle(attributes, for: .normal)
}
```
- setAttributedTitle 메서드의 인자로 들어있는 attributes는 어떻게 만들어졌을까?
- 바로 위에 코드를 보면 **generateButtonAttribute(_: texts: fonts: colors:)** 라는 메서드를 통해 생성 되었음을 알 수 있다.
- **generateButtonAttribute(_: texts: fonts: colors:** 메서드의 구현부를 보자
- 모든 UIViewController에서 사용할 수 있도록 UIViewController를 extension.
![](https://i.imgur.com/aFLwGHO.png)
- UIViewController+Extension 내부 
```swift
extension UIViewController {
    func generateButtonAttribute(_ button: UIButton,
                                 texts: String...,
                                 fonts: UIFont...,
                                 colors: UIColor...) -> NSMutableAttributedString {
        // UIButton에 입력된 text를 가져온다.
        guard let wholeText = button.titleLabel?.text else { fatalError("버튼에 텍스트가 없음.")}
        // 폰트들
        let customFonts: [UIFont] = fonts
        
        // 설정하고자 하는 String의 NSRange
        let customTextsRanges = texts.indices.map { index in
            (wholeText as NSString).range(of: texts[index])
        }
        
        // 설정하고자 하는 색상들
        let customColors = colors
        
        // attribute 객체를 생성한다.
        let attributedString = NSMutableAttributedString(string: wholeText)
        
        // 텍스트에 맞는 설정을 추가한다.
        texts.indices.forEach { index in
            attributedString.addAttribute(.font,
                                           value: customFonts[index],
                                           range: customTextsRanges[index])
            attributedString.addAttribute(.foregroundColor,
                                           value: customColors[index],
                                           range: customTextsRanges[index])
        }
        return attributedString
    }
}
```
- 메서드의 매개변수는 다중 가변 매개변수(Multiple Variadic Parameters)를 적용해 하나의 파라미터로 여러개의 인자를 받고 메서드 내부에서는 배열로 사용할 수 있도록 했다.
- 반환 타입이 NSMutableAttributedString이다.


