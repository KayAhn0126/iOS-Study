# Framework란?

## 🍎 Framework 개념
| Framework | Library |
| :-: | :-: |
| 특정 프로그램을 개발하기 위한 여러 요소들과 메뉴얼인 룰을 제공하는 프로그램 | 소프트웨어를 개발하기 쉽게 어떤 기능을 제공하는 도구들 |
| 자동차의 frame | 자동차의 wheel, tire, etc. |

## 🍎 Cocoa Touch Framework 개념
- 코코아 터치 프레임워크는 아이폰이나 아이패드 애플워치 등 애플의 모바일 기기에서 구동되는 앱을 개발할 때 사용하는 통합 프레임워크.
- 코코아터치 프레임워크는 애플 모바일 기기에서 필요한 기능이나 동작 구조, 유저 인터페이스를 구성하는 기본적인 객체들을 모두 담고 있는 유일한 프레임워크.
- 이 프레임워크를 이용하지 않으면 iOS용 앱을 만들 수 없다. 우리가 Xcode에서 iOS 애플리케이션을 만들 때 사용하는 각종 컨트롤이나 뷰 컨트롤러, 기타 화면 요소들에서부터 앱의 기본 구조에 이르기까지 거의 대부분의 것이 코코아 터치 프레임워크에 의해 제공되는 것들이다.
- **Cocoa Touch Framework는 어디서 나왔을까?**

## 🍎 Cocoa Framework
- 맥북 macOS용 애플리케이션을 만들 때 사용하는 프레임 워크인 Cocoa Framework가 있다. 이 프레임 워크가 Cocoa Touch Framework의 상당 부분에 관여하고 있다.
- 코코아 프레임워크 중에서 사용자 인터페이스를 담당하는 AppKit 프레임워크를 걷어내고, 모바일 기기에 적합한 UIKit 프레임워크를 대신 추가해 만든것이 Cocoa Touch Framework

| Cocoa Framework(macOS) | Cocoa Touch Framework(iOS, iPadOS, watchOS) |
|:----------------------:|:-------------------------------------------:|
|  Foundation Framework  |            Foundation Framework             |
|    AppKit Framework    |               UIKit Framework               |

## 🍎 Foundation Framework
- Foundation Framework는 기본 자료형을 포함한 자료구조, 객체 지향 처리와 연산, 그리고 각종 구조체나 타이머, 네트워크 통신 등 모바일 애플리케이션으로서의 특징적 기능에 직접 연관되지 않은 대부분의 기본적인 애플리케이션 기능을 처리한다.
- 이 프레임워크에 속한 객체들은 이름이 모두 NS라는 키워드로 시작한다. 최근에 와서는 스위프트용으로 사용되는 일부 객체의 이름에서 NS 키워드를 걷어내고 있다. 예) NSIndexPath -> IndexPath

## 🍎 UIKit Framework
- 화면이나 유저 인터페이스, 앱의 동작 등 모바일 앱으로서의 기능 구현을 주로 담당하는 프레임워크.
    - 화면에 표현되는 각종 콘텐츠나 컨트롤 객체를 보유
    - 화면의 구조를 만들고 관리
    - 화면과 사용자의 상호반응 및 모바일의 화면 변경에 따른 이슈 처리
    - 우리가 사용하는 앱의 기능구현은 UIKit 프레임워크가 큰 부분을 차지


## 🍎 Citation
- 꼼꼼한 재은 씨의 스위프트 실전편
