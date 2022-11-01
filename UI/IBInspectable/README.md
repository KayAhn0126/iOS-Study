# @IBInspectable & @IBDesignable
## 🍎 @IBInspectable
- 'IBInspectable'에서 IB는 IBOutlet과 IBAction의 약자와 같은 Interface Builder이다.
- 버튼을 둥글게 만들기 위해서는 버튼의 CALayer내 cornerRadius 프로퍼티에 접근해서 값을 바꿔줘야 한다.
- IBInspectable을 아래와 같이 사용하면 storyboard의 Inspecter에서 값을 설정해줄수 있다.
```swift
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
```
- IBInspectable이 적용된 모습
![](https://i.imgur.com/vJIm03F.png)


## 🍎 @IBDesignable
- @IBInspectable만 지정하면 시뮬레이터로 실행하는 '**런타임**'에만 속성이 적용된것을 볼 수 있다. 
- 하지만 @IBDesignable을 적용하면 스토리보드에서 ''**실시간**'으로 속성이 적용되는것을 볼 수 있다.
- **@IBDesignable은 extension에서 사용할수 없다.**
    - [you can't apply @IBDesignable on an extension like below](https://stackoverflow.com/questions/49022950/ibinspectable-not-updating-in-storyboard-but-works-on-simulator)
    ```swift
    @IBDesignable //won't work on an extension
    extension UIView {
        //...
    }
    ```
    - 아래와 같이 UIView를 상속받은 클래스에서는 사용 가능하다.
    ```swift
    @IBDesignable
    class MyPrettyDesignableView: UIView {
        //...
    }
    ```
