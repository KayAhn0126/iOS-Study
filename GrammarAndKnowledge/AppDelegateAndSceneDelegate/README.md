# AppDelegate & SceneDelegate
- Xcode에 프로젝트를 생성하면 항상 있는 AppDelegate.swift와 SceneDelegate.swift에 대해 알아보자.

## 🍎 사진을 통한 비교
- iOS 12 이전
![](https://i.imgur.com/KHckIUy.png)
- iOS 13 이후
![](https://i.imgur.com/9y0VnT6.png)

## 🍎 바뀐점
### 📖 1. iOS12이전에는 하나의 앱에 하나의 window 객체...
- iOS13부터는 앱에서 여러개의 Scene(들)을 가질 수 있다.

### 📖 2. AppDelegate의 역할이였던 UILifecycle을 SceneDelegate가 맡는다.
- 대신 AppDelegate에는 Scene의 Lifecycle을 담당하는 Session Lifecyle이 추가됨.
- Scene Session이 생성, 삭제될 때, AppDelegate에 알리는 두 메서드가 추가됨.
- Scene Session은 앱에서 생성한 모든 scene의 정보 관리.

## 🍎 Scene이란?
- 각 Scene에는 여러개의 window들과 여러개의 view controller로 구성되어있다. Scene들은 같은 메모리를 공간과 진행 공간을 공유한다. 결과적으로, 하나의 앱에는 다수의 scene들이 있을 수 있고 각각의 scene delegate 객체는 동시에 작동 할 수 있다.
- UI의 상태를 알 수 있는 UILifecycle에 대한 역할은 SceneDelegate가 하게 되었다. 역할이 분리된 대신 AppDelegate에서 Scene Session을 통해서 scene에 대한 정보를 업데이트 받는다.

## 🍎 Scene Session이란?
- UISceneSession 객체는 scene 고유의 런타임 인스턴스를 관리.
- 사용자가 앱에 새로운 scene을 추가하거나 요청하면 시스템은 해당 scene을 추적하는 UISceneSession 타입의 객체 생성.
- UISceneSession 객체는 추적하는 scene에 대한 고유한 식별자와 세부사항이 들어있다.

## 🍎 iOS13부터 AppDelegate가 하는 일
- 예전에는 앱이 foreground에 들어가거나 background로 이동 할때 앱의 상태를 업데이트하는 등 앱의 주요 생명 주기 이벤트를 관리 했었지만 현재는..
    - 앱의 데이터 구조를 초기화
    - 앱의 Scene들에 대한 환경설정
    - 앱 밖에서 발생한 알림(배터리 부족, 다운로드 완료 등)에 대한 대응
    - 특정한 scenes, views, view controllers에 한정되지 않고, **앱 자체를 타겟하는 이벤트에 대응**
    - 애플 푸쉬 알림 서비스와 같이 실행시 요구되는 모든 서비스를 등록


## 🍎 Citation
- [lena의 블로그](https://lena-chamna.netlify.app/post/appdelegate_and_scenedelegate/)를 참고해서 나만의 방식으로 정리
