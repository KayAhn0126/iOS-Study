# clipsToBounds vs masksToBounds 비교

## 🍎 clipsToBounds
- 스토리보드에서 UIView 관련 작업을 할때 오른쪽 Drawing section에 clipsToBounds 프로퍼티를 많이 봤었다.
- 공식문서에서 clipsToBounds를 찾아보면..
    - A Boolean value that determines whether subviews are confined to the bounds of the view.
    - 'view의 경계에 맞추어 subview들을 superview의 bounds에 가두어 그릴것인지' 에 대한 값을 설정하는 프로퍼티이다.
    - 조금 더 쉽게 이야기하면 '슈퍼뷰를 넘어 그리는 영역을 자를것인지', '아닌지'에 대한 값을 설정하는 프로퍼티.
- clipsToBounds 프로퍼티를..
    - true로 놓으면, super view 이외 영역의 subview(s)은 그리지 않는다.
    - false로 놓으면, super view의 영역 상관없이 모든 subview(s)를 그린다.

## 🍎 masksToBounds
- 위의 clipsToBounds는 UIView의 프로퍼티였다면, masksToBounds는 하는 역할은 같지만 다른점은..
- CALayer의 프로퍼티이다.
- 따라서 아래와 같이 layer를 통해 접근해야한다.
```swift
superView.layer.masksToBounds = true
```
## 🍎 clipsToBounds와 masksToBounds 정리 표
![](https://i.imgur.com/P0RVRKO.png)

## 🍎 Citation
- [개발자 소들이](https://babbab2.tistory.com/47)
