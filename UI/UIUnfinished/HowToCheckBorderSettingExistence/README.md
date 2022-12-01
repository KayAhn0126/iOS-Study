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

### 📖 물어보고 테스트해본 후 내린 일시적인 결론
- 테스트를 위해 먼저 빈 View Controller를 하나 만들고 그 위에 UIControl을 상속하는 대표적인 클래스인 UIButton 인스턴스를 생성하고 UIView 인스턴스도 하나 생성한 후 두 인스턴스의 속성을 비교했다.
- UIView 인스턴스는 테두리를 구성하는 프로퍼티가 없고 UIButton으로 생성한 인스턴스에도 프로퍼티가 없었다. 혹시 몰라서 UIBarButtonItem 인스턴스를 만들었고 그 안에는 border 설정을 도와주는 프로퍼티가 있었다.왜 똑같은 역할을 하는 버튼인데 UIButton에는 없고 UIBarButtonItem에는 있을까? 이 부분도 한번 찾아봐야 할것 같다..
- 지금까지의 결론
    - **일단 View로 끝나는 클래스에는 border를 설정하는 프로퍼티가 없었다.**
    - **일반 버튼에는 border를 설정할 수 있는 프로퍼티가 없다.**
    - **BarButtonItem에는 border를 설정할 수 있는 프로퍼티가 있다.**
    - **나중에 조금 더 깊이 알게 되면 수정하기**

## 🍎 Citation
- [스택오버플로우에 물어본 질문](https://stackoverflow.com/questions/74603403/i-have-question-about-differences-between-uitextview-and-uitextfield)
