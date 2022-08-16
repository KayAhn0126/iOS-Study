# ScrollView / StackView (README)

# 📖 스택뷰에 뷰를 넣는 과정에서 배운점
## 🍎 vertical scroll과 horizontal scroll 설정시 해야할 것
- vertical scroll을 사용하고 싶다면 폭(width)는 화면의 폭과 같게 꽉 차게 설정해준다. 높이(height)는 priority 250으로 낮게 잡아준다.
- horizontal scroll을 사용하고 싶다면 높이는 화면의 크기와 같게, 폭의 priority는 250으로 낮게 잡아준다.
- priority 250으로 잡아주는 이유는 기본 높이는 설정이 되어있고 계속 추가되어서 늘어나게 된다면 자동으로 늘어날 수 있도록 하기 위함.

## 🍎 addSubview vs addArrangedSubview

var subviews: [UIView] → UIView의 프로퍼티

var arrangedSubviews: [UIView] →UIStackView의 프로퍼티

## 🍎 stack view에 view를 추가할 땐!

stackview에 view를 추가할땐 addArrangedSubview나 insertArrangedSubview을 사용하자!

## 🍎 addSubview와 addArrangedSubview는 무엇이 다를까?

addArrangedSubview()

- view를 view Hierarchy에 추가하고 UIStackView의 프로퍼티인 arrangedSubviews 배열에도 추가.

addSubview()

- view Hierarchy에는 추가하지만 arrangedSubviews 배열이 아닌 subviews 배열에 추가한다.
- addArrangedSubview method arranges its subviews based on its .axis, .alignment, .distribution and .spacing properties, as well as its frame.
- 그러므로 addSubview 메서드를 사용하면 새로 추가된 뷰를 화면에 업데이트 하지 않아 보이지 않는다.

## 🍎 ArrangedSubview와 removeFromSuperview의 차이점

removeArrangedSubview

- view Hierarchy에서는 삭제가 안되고 arrangedSubviews 배열에서만 삭제가 된다.
- 나중에 해당 뷰를 사용하려면 arrangedSubviews 프로퍼티에는 없지만 view hierarchy에는 남아있어서 새로 생성할 필요가 없다.

removeFromSuperview

- view Hierarchy와 arrangedSubviews 프로퍼티 둘 모두 삭제 → 메모리와 스크린 둘 다에서 삭제.


---


# 📖 직면한 문제 및 해결 과정
1. verticalStackView에 검정색 view를 스택에 추가할 때, 해당 view의 높이를 나타내는 label을 view의 중간에 넣으려고 label을 생성했다. 처음에 시도한 방법은 UILabel을 생성할 때 view.frame위치에 넣어주었다. 하지만 예상과 달리 첫번째로 추가되는 view에만 label이 보이고 두번째부터 추가되는 view에는 label이 보이지 않았다. 문제를 찾다 UILabel의 위치를 설정해주는 곳에서 잘못된 점을 찾았다.

    - 먼저 Frame과 Bounds의 차이를 알아보았다.
        - Bounds → 자신의 위치 기준.
            - 값을 준다면 해당 위치에서 다시 그림

        - Frame → SuperView를 기준
            - 값을 준다면 자신의 SuperView를 기준으로 다시 그림.

    - 처음에 작성한 코드, view의 부모뷰인 verticalStackView에서의 위치를 나타내고 있다. 즉, verticalStackView내 view의 위치에 label을 생성하겠다는 의미
    ```swift
    let label = UILabel(frame: view.frame)
    ```
    - 수정한 코드, 나의 위치와 나의 크기를 나타낸다. -> 나한테 필요했던것!
    ```swift
    let label = UILabel(frame: view.bounds)
    ```
    

    |( L ) view.frame / ( R ) view.bounds|
    |:-:|
    |![frame과bounds의 차이](https://user-images.githubusercontent.com/40224884/182875892-19d2e63f-84b2-4ccf-8330-c6ae73a4fa13.gif)|
    
    

    
2. completion 클로져에서 실행되는 코드는 REMOVE 버튼을 눌러 가장 마지막의 view를 삭제할 때, 천천히 누르면 삭제가 잘 되지만 빠르게 누른다면 viewSize도 버튼을 누른만큼 줄이지 못하는 문제를 발견했다.
    ```swift
    @IBAction func removeView(_ sender: UIButton) {
            guard let last = verticalView.arrangedSubviews.last else { return }
            UIView.animate(withDuration: 0.3) {
                last.isHidden = true
            } completion: { (_) in
                self.verticalView.removeArrangedSubview(last)
                self.viewSize = self.viewSize - 5
            }   
        }
    ```
    |삭제할 때 에러가 있는 화면|
    |:-:|
    |![REMOVEWITHERROR](https://user-images.githubusercontent.com/40224884/182873390-a7efb16d-d269-403f-865e-30fc2268ad5b.gif)|

    
    remove 버튼을 빠르게 눌렀을때 무엇 때문에 정상적(빠르게 눌러도 누른만큼 삭제되고 viewSize도 줄어드는 논리)으로 삭제되지 않는지 아직 해결하지 못했다.
        - UIView.animate 메서드의 0.3초동안 작업을 수행하는것 때문이라고 짐작하고 있다.
    
    ### 🍎 다만 시도 해본것이 있다면..
    
    ```swift
    @objc func removeBlackView() {
        guard let last = verticalStackView.arrangedSubviews.last else { return }
        self.viewSize = self.viewSize - 5
        self.verticalStackView.removeArrangedSubview(last)
        last.isHidden = true
    }
    ```
    위와같이 completion 클로져에 있던 코드를 완전히 빼서 last가 존재한다면 바로 실행할 수 있게 해주었다.
    |삭제할 때 정상적인 화면|
    |:-:|
    |![REMOVEWITHNOERROR](https://user-images.githubusercontent.com/40224884/182873061-6cc0ef0c-cf48-46d1-88ba-2b268d4a6d50.gif)|
    
    위와 같이 정상적으로 작동 하는것을 확인할 수 있다.
