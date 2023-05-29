# UIView 클래스 내 layerClass 타입 프로퍼티에 관하여.

## 🍎 정의
- view의 Core Animation layer를 생성하기 위해 사용된 클래스를 반환한다.
- 이 메서드는 기본적으로 CALayer 클래스 객체를 반환하도록 되어있다.
- 필요시, 서브클래스들은 이 메서드를 오버라이드해서 다른 layer class를 반환하게 할수도 있다.
- 만약 당신의 뷰가 스크롤 가능한 큰 영역을 tiling해야 한다면, 아래와 같이 이 프로퍼티를 오버라이드해서 CATiledLayer를 반환하도록 하면된다.
```swift
override class var layerClass : AnyClass {
    return CATiledLayer.self
}
```
- 이 메서드는 해당 레이어 객체를 생성하기 위해 뷰 생성 초기에 딱 한번만 호출한다.

## 🍎 원문
- Return Value
    - The class used to create the view’s Core Animation layer.
- Discussion
    - This method returns the CALayer class object by default. Subclasses can override this method and return a different layer class as needed. For example, if your view uses tiling to display a large scrollable area, you might want to override this property and return the CATiledLayer class, as shown in Listing 1.
```swift
override class var layerClass : AnyClass {
   return CATiledLayer.self
}
```
- This method is called only once early in the creation of the view in order to create the corresponding layer object.
    
## 🍎 참고
- [공식 홈페이지](https://developer.apple.com/documentation/uikit/uiview/1622626-layerclass)
