# Applying a new attribute to the label

## 🍎 새로운 속성 적용 전,후 비교 이미지
| 속성 적용 전 | 속성 적용 후 |
| :-: | :-: |
| ![](https://i.imgur.com/crfU90Y.png) | ![](https://i.imgur.com/xSF8e2W.png) |
- 자세히 보면 사용자(User)부분이 This is my cat! 보다 조금 더 두꺼운것을 볼수있다.

## 🍎 NSMutableAttributeString을 사용해 label의 구간에 따라 스타일 적용하기
- 여기서 사용되는 contentDescriptionLabel은 위 이미지의 빨간 타원 내 UILabel 객체이다.
```swift
let fontSize = UIFont.boldSystemFont(ofSize: 9)
let attributedStr = NSMutableAttributedString(string: contentDescriptionLabel.text ?? "")
let range = NSRange(location: 0, length: userLabel.text?.count ?? 0)
attributedStr.addAttribute(.font, value: fontSize, range: range)
contentDescriptionLabel.attributedText = attributedStr
```
