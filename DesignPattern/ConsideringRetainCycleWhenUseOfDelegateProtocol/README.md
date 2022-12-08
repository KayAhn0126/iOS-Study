# Considering Retain Cycle When Use Of Delegate Protocol
- 델리게이트 프로토콜을 사용해 데이터를 전달할 때 Retain Cycle이 발생할 수 있다는 점에서 시작.

## 🍎 Delegate Protocol을 사용해 VC간 결합도는 낮췄지만...
- Catstagram 프로젝트에서 [Delegate Protocol을 만들어 VC간 결합도를 낮추는 코드](https://github.com/KayAhn0126/iOS-Study/tree/main/DesignPattern/DelegateProtocolwithLowCoupling)를 구현했었다.
- 이전에 구현했던 Delegate protocol을 타입으로 하는 프로퍼티는 아래 이미지의 빨간 타원안에 코드처럼 강한 참조로 구현이 되어있었다.
![](https://i.imgur.com/FK2AKis.jpg)
- 당시에 메모리 릭 관련으로 테스트를 해보았을때, 메모리 릭 발생하지 않았던 이유는 단순히 FeedDataManager 인스턴스를 생성하는 ViewController에서 FeedDataManager 인스턴스는 viewDidLoad()에서 생성되었고 해제되었기 때문이라고 생각한다.
![](https://i.imgur.com/dCgWmJM.png)
- 하지만, 만약 FeedDataManager 인스턴스가 짧게 생성되었다가 해제되는 사이클을 가진게 아니라 일반 인스턴스의 프로퍼티처럼 메모리상에 오래 유지가 되었다면 Retain Cycle이 발생했을지도 모른다.
- Retain Cycle을 피하기 위해 Delegate Protocol을 타입으로 가지는 프로퍼티는 왜 weak로 선언이 되어야하며, 그에 맞게 프로토콜을 구현하는법까지 공부해봤다.

## 🍎 결합도를 낮췄으니 retain cycle을 방지하는 코드 작성하기
- 먼저 retain cycle을 방지하기 위한 코드를 보자.
- 프로토콜 부분

| 전 | 후 |
| :-: | :-: |
|  ![](https://i.imgur.com/zlDBjGW.png) | ![](https://i.imgur.com/47ZZx07.png) |

- 약한 참조의 프로퍼티 만들기

| 전 | 후 |
| :-: | :-: |
| ![](https://i.imgur.com/QFcCIS1.png) | ![](https://i.imgur.com/SYXGVMk.png) |

- 왜 DataTransferDelegate 프로토콜에 AnyObject 프로토콜을 채택했을까?
- AnyObject를 사용하지 않고 weak 키워드를 통해 약한참조 프로퍼티를 만들면 안되는 것일까?
- AnyObject를 사용하지 않고 weak 키워드를 사용했을 때
![](https://i.imgur.com/BrzOXIm.png)
- weak 키워드는 클래스가 아닌 바운드에는 사용할 수 없다고 나온다.
    - weak or unowned 키워드는 참조하는 대상에 RC를 올리지 않는 목적으로 사용된다.
    - 약하게 참조한다는 의미는 클래스에서만 사용가능하기 때문에 AnyObject 프로토콜을 채택한 것.

## 🍎 AnyObject는 어떤 프로토콜인가?
- 먼저 '**프로토콜은 클래스, 구조체, 열거형에서 사용될 수 있다**' 라는것을 기억하자.
- AnyObject 프로토콜은 무엇인가? -> 정의부를 가서 찾아보자!
![](https://i.imgur.com/6rTFHaf.png)
- the protocol to which all class types implicitly conform
- 해석하면, 모든 클래스 타입들이 암시적으로 준수 해야하는 프로토콜이라는 말.
- 결국, AnyObject 프로토콜을 준수한다는건, 그 대상이 클래스여야 한다는 말.
- 즉, 클래스만 채택 / 준수 하도록 강요하는 프로토콜이다.
- 왜? AnyObject를 사용해서 프로토콜을 구현했을까?
- 바로 weak 키워드 때문이다!
- Delegate Protocol을 타입으로 가지는 프로퍼티 앞에 weak 키워드를 붙여 해당 프로퍼티가 참조하는 VC 인스턴스의 카운트를 증가시키지 않게해 Retain Cycle을 예방 하는것이다.

## 🍎 꼭 AnyObject여야 할까?
- "**class만 채택 할 수 있는 프로토콜은 이렇게도 만들수 있는것 아닌가?**" 라고 생각해봐서 class로 한번 바꿔봤다.
![](https://i.imgur.com/jc0g6tq.png)
- class 키워드를 사용해 클래스만 따르게 하는 프로토콜은 더 이상 사용되지 않는다고 한다. 대신 AnyObject를 사용하라고 한다.
- 혹시 내가 틀릴수도 있다는 생각에 다른 사람들의 의견은 어떤지 찾아보았다.

![](https://i.imgur.com/nV8wHI0.png)
- 스택오버플로에서 찾은 답변이다. 답변은 originally Slava_Pestov라는 스위프트 개발자로부터 나왔다고 한다. 간단하게 요약 해놓은걸 번역 해봤다.
    - AnyObject를 사용해야한다.
    - AnyObject와 class는 동일하고 다른점은 없다.
    - class는 언젠가 사용되지 않을것이다.

## 🍎 Citation
- [스위프트 포럼](https://forums.swift.org/t/class-only-protocols-class-vs-anyobject/11507)
- [stackoverflow](https://stackoverflow.com/questions/30176814/whats-the-difference-between-a-protocol-extended-from-anyobject-and-a-class-onl/32895975#32895975)



