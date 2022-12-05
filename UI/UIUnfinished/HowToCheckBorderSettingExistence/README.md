# borderStyle을 가지는 클래스의 기준은 무엇인가?

## 🍎 문제 정의
- 내용 Label 하단에 Text view를 넣어주었다. 하지만 아래와 같이 text view의 border가 보이지 않았다.
- 그래서 borderStyle을 설정하기 위해 storyboard내 attribute inspector를 봤는데 borderStyle를 설정하는 곳은 찾을수 없었고 왜 UITextField에 있는 borderStyle은 UITextView에는 없을까 찾아보기 시작했다.
![](https://i.imgur.com/CbnXnlX.png)
- 즉, UITextView와 UITextField는 둘 다 Text를 입력하는것은 공통적이고 다른점이라면 크게 아래 항목으로 설명할 수 있다.
    - UITextField는 단일 줄 텍스트를 처리하는데 용이하고 placeholder를 사용할 수 있다.
    - UITextView는 여러줄의 텍스트를 처리하는데 용이하고 placeholder를 사용할 수 없다.
- 이제 왜 UITextField에 있는 borderStyle은 UITextView에는 없을까 찾아보자.

## 🍎 UITextView와 UITextField의 공식문서를 보자

### 📖 각각의 클래스는 어떤 클래스를 상속했을까?
- UITextView
    - UIScrollView 상속
        - UIView 상속
- UITextField
    - UIControl 상속
        - UIView 상속
- 이렇게 보니 "정말 상속하는 클래스가 영향을 줄까?" 라는 생각이 들어 실제로 간단하게 테스트를 해보았다.
- UIView와 UIControl을 테스트 해보기로 했다.

### 📖 stackoverflow에 물어보고 테스트해본 후 내린 일시적인 결론
- 테스트를 위해 먼저 빈 View Controller를 하나 만들고 그 위에 UIControl을 상속하는 대표적인 클래스인 UIButton 인스턴스를 생성하고 UIView 인스턴스도 하나 생성한 후 두 인스턴스의 속성을 비교했다.
- UIView 인스턴스는 테두리를 구성하는 프로퍼티가 없고 UIButton으로 생성한 인스턴스에도 프로퍼티가 없었다. 혹시 몰라서 UIBarButtonItem 인스턴스를 만들었고 그 안에는 border 설정을 도와주는 프로퍼티가 있었다.왜 똑같은 역할을 하는 버튼인데 UIButton에는 없고 UIBarButtonItem에는 있을까? 이 부분도 한번 찾아봐야 할것 같다..
- 지금까지의 결론
    - **일단 View로 끝나는 클래스에는 border를 설정하는 프로퍼티가 없었다.**
    - **일반 버튼에는 border를 설정할 수 있는 프로퍼티가 없다.**
    - **BarButtonItem에는 border를 설정할 수 있는 프로퍼티가 있다.**

### 📖 22년 12월 05일 업데이트
- 클래스별 상속 관계에서 문제를 찾다가 상속 관계와는 상관이 없다고 결론을 내렸다.
- 아래와 같이 눈에 띄는 상관관계를 찾지 못한 이유.
    - UIButton → UIControl → UIView (X)
    - UITextView → UIScrollView → UIView (X)
    - UITextField → UIControl → UIView (O)
    - UIBarButtonItem → UIBarItem → NSObject(O)
- UIButton, UITextView, UITextField 모두 UIView를 상속 받고 있으므로 UIView 클래스의 layer: CALayer에 접근할 수 있다. 근데 왜 UITextField에만 border의 style을 꾸며줄수 있을까?
- 이제는 UITextField와 UIBarButtonItem이 Border를 꾸며주는 프로퍼티를 어떤 형태로 가지고 있는지 확인 해보았다.
- UITextField에는 BorderStyle enum을 타입으로 가지는 borderStyle라는 프로퍼티가 있다.
```swift
open var borderStyle: UITextField.BorderStyle
```
- UIBarButtonItem에는 Style enum을 타입으로 가지는 style이라는 프로퍼티가 있다.
```swift
open var style: UIBarButtonItem.Style
```
- 둘 모두 enum 타입으로 관리하고 있다.
- 지금 판단으로는 border를 꾸며주는 작업이 자주 일어나는 클래스에 애플이 사용하기 쉽게 프로퍼티로 만든 것으로 생각된다.
- 생각을 조금 더 자세히 이야기 하면, UIButton, UITextView도 border의 스타일을 설정할 수 있지만, 이들 클래스 보다 UITextField, UIBarButtonItem로 생성된 객체들이 border의 스타일을 설정할 일이 더 많이 때문에 애플이 프로퍼티로 만들었다고 생각한다.

## 🍎 Citation
- [스택오버플로우에 물어본 질문](https://stackoverflow.com/questions/74603403/i-have-question-about-differences-between-uitextview-and-uitextfield)
- [UITextField 공식 문서](https://developer.apple.com/documentation/uikit/uitextfield)
- [UITextView 공식 문서](https://developer.apple.com/documentation/uikit/uitextview)
- [UIButton 공식 문서](https://developer.apple.com/documentation/uikit/uibutton)
- [UIBarButtonItem 공식 문서](https://developer.apple.com/documentation/uikit/uibarbuttonitem)
