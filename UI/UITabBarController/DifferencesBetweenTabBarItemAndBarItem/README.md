# TabBarItem과 BarItem은 무엇이 다를까?

## 🍎 공부 정리 내용
![](https://i.imgur.com/LHf8Knv.jpg)
- Tab하는 아이템을 세팅하는 부분이 Tab Bar Item과 Bar Item으로 나뉘어져 있어 어차피 두 섹션 모두 아이템을 구성하는 프로퍼티인데 도대체 왜 나눠져 있을까 찾아봤다.
- 먼저 꼼꼼한 재은씨책에서는 답을 찾을 수 없었고, UIBarItem과 UITabBarItem의 공식문서를 봤다.
- 먼저 [UIBarItem 공식문서](https://developer.apple.com/documentation/uikit/uibaritem)에서 프로퍼티 섹션을 보면 위 이미지에서 BarItem 섹션에 있는 프로퍼티들을 볼 수 있다. 즉, 위 이미지 내 BarItem 섹션은 UIBarItem 클래스를 통해 생성된 객체의 속성을 설정하는 프로퍼티이다.
- 이제 [UITabBarItem 공식문서](https://developer.apple.com/documentation/uikit/uitabbaritem)를 보자.
```swift
@MainActor class UITabBarItem : UIBarItem
```
- UIBarItem 클래스를 상속 받고 있었다. 상속하면 부모 클래스의 멤버를 물려 받아 사용 할 수 있다. 즉, 위 이미지에서 두개의 섹션으로 나뉜것은 UITabBarItem 클래스로 생성한 객체이고, UIBarItem을 상속 받았으니 해당 프로퍼티도 제공했던 것이다.

## 🍎 반성할 점
- 문제가 발생하면 먼저 공식문서를 보자!
- 꼼꼼하게 기록하는 습관을 들이자!

## 🍎 Citation
- [UIBarItem 공식문서](https://developer.apple.com/documentation/uikit/uibaritem)
- [UITabBarItem 공식문서](https://developer.apple.com/documentation/uikit/uitabbaritem)
