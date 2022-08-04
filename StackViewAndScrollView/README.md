# ScrollView / StackView (README)

## 📖 직면한 문제 및 해결 과정
1. verticalStackView에 검정색 view를 스택에 추가할 때, 해당 view의 높이를 나타내는 label을 view의 중간에 넣으려고 label을 생성했다. 처음에 시도한 방법은 UILabel을 생성할 때 view.frame위치에 넣어주었다. 하지만 예상과 달리 첫번째로 추가되는 view에만 label이 보이고 두번째부터 추가되는 view에는 label이 보이지 않았다. 문제를 찾다 UILabel의 위치를 설정해주는 곳에서 잘못된 점을 찾았다.

    - 처음에 작성한 코드, view의 부모뷰인 verticalStackView에서의 위치를 나타내고 있다.
    ```swift
    let label = UILabel(frame: view.frame)
    ```
    - 수정한 코드, 나의 위치와 나의 크기를 나타낸다. -> 나한테 필요했던것!
    ```swift
    let label = UILabel(frame: view.bounds)
    ```
    
2. completion 클로져에서 실행되는 코드는 REMOVE 버튼을 눌러 가장 마지막의 view를 삭제할 때, 천천히 누르면 삭제가 잘 되지만 빠르게 누른다면 viewSize도 버튼을 누른만큼 줄이지 못하는 문제를 발견했다. 정확히 어떤
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
    ![REMOVEWITHERROR](https://user-images.githubusercontent.com/40224884/182873390-a7efb16d-d269-403f-865e-30fc2268ad5b.gif)
    
    아직 정확하게 빠르게 눌렀을때 무엇 때문에 정상적(빠르게 눌러도 누른만큼 삭제되고 viewSize도 줄어드는 논리)으로 삭제되지 않는지 해결하지 못했다. 
    
    ### 다만 시도 해본것이 있다면..
    
    ```swift
    @objc func removeBlackView() {
        guard let last = verticalStackView.arrangedSubviews.last else { return }
        self.viewSize = self.viewSize - 5
        self.verticalStackView.removeArrangedSubview(last)
        last.isHidden = true
    }
    ```
    위와같이 completion 클로져에 있던 코드를 완전히 빼서 last가 존재한다면 바로 실행할 수 있게 해주었다.
    
    ![REMOVEWITHNOERROR](https://user-images.githubusercontent.com/40224884/182873061-6cc0ef0c-cf48-46d1-88ba-2b268d4a6d50.gif)
    
    위와 같이 정상적으로 작동 하는것을 확인할 수 있다.
