# CALayer

## 🍎 CALayer는 어디에서 나온것이며 무엇인가?
- UIView는 CALayer 타입의 프로퍼티 layer를 가지고 있다.
- CALayer의 CA는 'Core Animation'의 약자.
- 그럼, Core Animation은 무엇인가? -> 아래의 표를 보고 GPU부터 위로 올라오면서 이해하기.

## 🍎 앱에서 그래픽 연산을 처리하기 위해 어떤 방식으로 작동하는지 알아야한다.
![](https://i.imgur.com/EKzm04l.png)
- **OpenGL**
    - 개발자는 iOS 초기에 OpenGL을 통해 GPU에 빠르게 엑세스함으로써 부드러운 화면 구성이 가능했다.
    - 하지만, 단순한 작업에도 코드의 양이 매우 방대해져 대안이 필요.
    - OpenGL 보다 적은 코드로 그래픽을 구현할 수 있는 Core Graphics 개발.
- **Core Graphics**
    - CGColor, CGRect 등등, CG로 시작하는 Class들은 여기서 파생.
    - 이 Core Graphics마저 OpenGL보다는 코드의 양도 적고 사용하기 간편했지만 더욱 사용하기 편한 Framework 필요.
- **Core Animation**
    - Core Animation에는 아직도 그래픽 처리를 위한 고급 기능이 많다.
    - 애플은 개발자들이 더 간편하게 사용할 수 있도록 간단화 시킨것이 UIKit
- **UIKit**
    - UIView, UIViewController등등 UI로 시작하는 Class들은 여기서 파생
    - 우리가 UIKit에 속한 UIView를 이용해 쉽게 화면을 구성할 수 있었던 것.

## 🍎 UIView가 화면을 그리는 행위는 Core Animation에게 위임한다.
- UIView는 레이아웃, 터치 이벤트 등 많은 작업을 처리.
- 하지만 뷰 위에 컨텐츠나 애니메이션을 그리는 행위는 직접하지 않고 Core Animation에게 위임.
- 그것이 바로 **layer**.

## 🍎 언제 UIView를 사용해야 하나?
- UIView에서 built-in으로 제공되는 터치 이벤트, 또는 다른 작업들을 CALayer를 통해 사용하려면 직접 구현해서 사용해야 한다. 즉, 꼭 CALayer로 직접 구현해야 하는 상황이 아니라면, 유저 상호작용 기능이 구현되어있는 UIView를 이용.

## 🍎 언제 CALayer를 사용해야 하나?
- CALayer를 찾아보다 [UIView와 CALayer의 차이점](https://stackoverflow.com/questions/7826306/what-are-the-differences-between-a-uiview-and-a-calayer)라는 글을 보았다.
- 여러 화면들을 그릴때 CALayer를 직접 사용하는것과 일반적으로 사용하는 UIView들을 이용해 그리는것을 비교했을때, 비교할 수 있을만한 성능의 차이는 없다고 한다.
- 그럼에도 몇몇 사용자들이 CALayer를 사용하는 이유는 Mac으로의 이식성을 고려했기 때문이라고 한다.
- UIView -> iOS
- NSView -> MacOS
- UIView와 NSView의 윗단에 있는 CALayer -> iOS,MacOS


## 🍎 UIView와 CALayer의 차이점.
- UIView
    - UIKit에서 제공하는 클래스
    - CALayer보다 한단계 높은 레벨의 인터페이스
    - **메인스레드에서 CPU를 사용해 UI 그림**
    - CALayer를 감싼 Wrapper로 CALayer에서 제공하지 않는 탭, 터치, 핀치 등, 유저 인터렉션을 제공 (UIResponder)상속.
    - 단순한 애니메이션 또는 퍼포먼스에 대한 요구가 크지 않는 상황에 사용.
- CALayer
    - Core Animation에서 제공하는 클래스
    - UIView보다 한단계 낮은 레벨의 인터페이스
    - **별도의 스레드에서 GPU를 사용해 UI를 직접 그림**
    - UIView와 달리 별도의 Responder가 없어, 유저 인터렉션 기능은 직접 구현 및 설정 필요.
    - UIView에서 제공하지 않는 기능을 커스터마이징해서 사용 가능.
    - 복잡한 애니메이션, 퍼포먼스가 필요할 때 UIView 대신 사용 가능.
    - MacOS로 이식 가능성.

## 🍎 Citation
- [CALayer 공식 문서](https://developer.apple.com/documentation/quartzcore/calayer)
- [개발자 소들이](https://babbab2.tistory.com/53)
- [송태환](https://velog.io/@songtaehwan/iOS-Views-vs-Layers)
