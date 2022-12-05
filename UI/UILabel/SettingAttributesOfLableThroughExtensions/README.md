# extension을 이용해 attribute 세팅하기

## 🍎 NSAttributedString / NSMutableAttributedString 
- NSAttributedString
    - 문자열에 스타일을 설정할 수 있는 클래스
    - NSMutableAttributedString에 넣기위한 속성들을 가지고 있는 클래스
    - read-only
- NSMutableAttributedString
    - NSAttributedString의 특정구간에 스타일을 설정할 수 있는 클래스
    - modifiable

## 🍎 read-only? modifiable?
- [NSAttributedString 공식 문서](https://developer.apple.com/documentation/foundation/nsattributedstring) 내 overview의 첫 문단 마지막줄을 보면 아래와 같이 적혀있다.
- **"NSAttributedString and NSMutableAttributedString, declare the programmatic interface for read-only attributed strings and modifiable attributed strings, respectively."**
- "각각 NSAttributedString은 read-only, NSMutableAttributedString은 modifiable" 이라는 말이 어떤 뜻인지 와닿지 않았다.
- 그래서 NSAttributedString의 모든 메서드를 하나하나 봤고 NSAttributeString 클래스는 무엇을 직접적으로 바꾸는것이 아닌 NSMutableAttributedString을 통해 문자열에 속성을 바꿔 줄 때 필요한 NSAttributedString.Key 구조체나 NSAttributedString.TextEffectStyle 구조체 처럼 '속성'들을 관리하는 클래스라고 이해했다.
- NSAttributedString 클래스의 메서드 중에서는 NSAttributedString 객체의 속성을 직접적으로 바꾸는 메서드는 없었다.
- 아래의 예시를 보자.
```swift
// 글자를 orange 색상으로 하이라이트 적용하는 메서드
func orangeHighlight(_ value: String) -> NSMutableAttributedString {
    let attributes: [NSAttributedString.Key : Any] = [
        .font: normalFont,
        .foregroundColor: UIColor.white,
        .backgroundColor: UIColor.orange
    ]
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
}
```
- NSAttributedString.Key 구조체를 키로 가지는 딕셔너리를 선언하고 NSAttributedString.Key 구조체 내 타입 프로퍼티인 .font, .foregroundColor, backgroundColor를 사용해 속성을 지정 해주었다.
- 이것이 NSAttributedString의 역할이다.
- 마지막 코드의 self는 메서드 호출부의 NSMutableAttributedString()를 통해 생성된 객체를 뜻한다.
- 즉, 호출부에서 생성된 NSMutableAttributedString 객체에 수정하려는 값들을 append 해준것.
- 글자에 밑줄 적용하는 예제를 보자.
```swift
// 글자에 밑줄 적용하는 메서드
func underlined(_ value:String) -> NSMutableAttributedString {
    let attributes: [NSAttributedString.Key : Any] = [
        .font: normalFont,
        .underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
}
```
- 이곳에서도 마찬가지로 NSAttributedString.Key 구조체를 키로 가지는 딕셔너리를 선언하고 NSAttributedString.Key 구조체 내 타입 프로퍼티인 .font와 .underlineStyle을 사용해 속성을 지정 해주었다. 이 코드에서 NSAttributedString의 역할을 더 확실히 알 수 있는데, 
```swift
.underlineStyle : NSUnderlineStyle.single.rawValue
```
- NSUnderlineStyle도 NSAttributedString내 구조체라는 점이다.
- 즉, NSAttributedString은 NSMutableAttributedString 객체를 도와 문자열의 속성들을 가지고있는 클래스라고 생각한다. 이런 의미에서 read-only라고 한건지는 모르겠지만 엄청 틀린말도 아니다. 왜? NSAttributedString은 직접적으로 무언가를 하는 행동이 없기 때문에. 반면, NSMutableAttributedString은 속성들을 받고 대입까지 행동하기 때문에 modifiable이라고 할 수 있겠다.

## 🍎 전체 코드를 보고 위의 메서드가 어떻게 사용되었는지 보자
### 📖 메서드를 구현한 익스텐션
```swift
import Foundation
import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat {
        return 14
    }
    var boldFont: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
```

### 📖 메서드 사용
```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "Hello World!"
        myLabel.attributedText = NSMutableAttributedString()
            .regular(string: "H", fontSize: 20)
            .bold(string: "ello", fontSize: 15)
            .orangeHighlight("W")
            .blackHighlight("orld!")
            .underlined("orld!")
    }
}
```
- 결과를 보자!
- myLabel의 attributedText 프로퍼티에 NSMutableAttributedString으로 생성하고 여러가지 속성을 추가한 값이 들어가고있다.
![](https://i.imgur.com/bd1hnig.png)
- 그럼 myLabel의 attributedText 프로퍼티는 NSMutableAttributedString 타입일까?
- 아니다! myLabel의 attributedText는 NSAttributedString타입이고 바로 위의 코드는 NSMutableAttributedString 타입의 객체를 넣어주고 있다. 어떻게 이게 가능할까?
- **NSMutableAttributedString타입은 NSAttributedString을 상속 받고있어 부모 클래스로의 업캐스팅 필요없이 안전하게 사용할 수 있다.**

## 🍎 UILabel의 attributedText 프로퍼티
- 이 프로퍼티는 기본이 nil이다.
- 만약 이 프로퍼티에 값을 주게된다면 text 프로퍼티의 값도 바뀌게 된다.
- 즉, attributedText는 attribute(속성) + text(문자)이 같이 들어있는 styled text라고 생각하면 된다.
- attributedText에는 NSAttributedString을 타입으로 가지는 인스턴스가 들어와야 한다.
    - NSAttributedString 또는 NSMutableAttributedString 타입 둘다 올 수 있다.
    - 위에서 NSAttributedString 클래스는 문자열의 속성을 구성할 수 있게끔 '문자열 속성'을 관리하는 클래스라고 알고있는데 어떻게 attributedText 프로퍼티에 NSAttributedString 타입도 가능한것일까?
    - 다시, [NSAttributedString 공식 문서](https://developer.apple.com/documentation/foundation/nsattributedstring)내 **Extracting a Substring** 카테고리를 보면 아래와 같은 메서드를 찾을 수 있다.
    ```swift
    func attributedSubstring(from: NSRange) -> NSAttributedString
    ```
    - NSAttributedString 클래스는 '문자열 속성'을 관리하는 클래스 역할 뿐만 아니라 기존 NSAttributedString 객체에서 range에 따라 subSting후 새로운 NSAttributedString을 반환하는 메서드도 포함이 되어있다.
    ```swift
    myLabel.attributedText = existedAttributedString.attributedSubstring(from: NSRange())
    ```
    - 즉, 항상 NSMutableAttributedString 타입의 객체가 필요한 것이 아니라 상황에 따라 기존에 있던 NSAttributedString에서 잘라서 사용할 수 있다는 이야기.
    

## 🍎 NSMutableAttributedString클래스의 메서드 종류
```swift
extension NSMutableAttributedString {
    // open var mutableString: NSMutableString { get }
    open func addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange)
    open func addAttributes(_ attrs: [NSAttributedString.Key : Any] = [:], range: NSRange)
    open func removeAttribute(_ name: NSAttributedString.Key, range: NSRange) 
    open func replaceCharacters(in range: NSRange, with attrString: NSAttributedString)
    open func insert(_ attrString: NSAttributedString, at loc: Int)
    open func append(_ attrString: NSAttributedString)
    open func deleteCharacters(in range: NSRange)
    open func setAttributedString(_ attrString: NSAttributedString)
    open func beginEditing()
    open func endEditing()
}
```
- label이나 button에 실질적으로 값을 바꿔주는 NSMutableAttributedString 클래스의 메서드는 NSAttributedString 또는 NSAttributedString.Key를 매개변수로 받고 있다.

## 🍎 특정 문자열을 입력하면 해당 문자열만 bold로 바꾸는 메서드를 extension으로 빼기
- NSAttributedString과 NSMutableAttributedString에 대한 설명을 하면서 NSMutableAttributedString 타입을 반환하는 메서드를 묶은 extension을 봤다.
- 이번에 볼것은 반환형이 있는 메서드가 아닌 Void 타입의 메서드이다.
- 먼저 코드를 보자.
```swift

// 구현부
extension UILabel {
    func bold(targetString: String) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}

// 호출부
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "Hello World!"
        myLabel.bold("Hello")
    }
}
```
- extension으로 뺀 bold 메서드, 현재는 특정 문자열을 매개변수로 입력하면 해당 문자열만 bold로 바꾸는 메서드이지만, 매개변수에 아무것도 주어지지 않는다면 전체를 bold로 만드는 메서드를 만들어봤다.
```swift
import Foundation
import UIKit

extension UILabel { 
    func bold(_ targetString: String? = nil) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let retrievedTargetString = targetString ?? fullText
        let range: NSRange = (fullText as NSString).range(of: retrievedTargetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}
```
- 이렇게 만들어주면 매개변수에 아무것도 전달하지 않을 경우 전체 텍스트를 bold체로 바꿔준다.

## 🍎 Citation
- [NSAttributedString 공식 문서](https://developer.apple.com/documentation/foundation/nsattributedstring)
- [예제 코드 출처](https://ios-development.tistory.com/359)
- [UILabel의 attributedText 프로퍼티](https://developer.apple.com/documentation/uikit/uilabel/1620542-attributedtext)
