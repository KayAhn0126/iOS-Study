# 화면 전환 방법 정리

## 🍎 1. 뷰 컨트롤러 직접 호출에 의한 화면 전환 (프레젠테이션 방식)
### 새로운 화면 띄우기
- 모든 뷰 컨트롤러는 UIViewController 클래스를 상속받는다. 즉, 이 클래스에서 정의된 present(_: animated:) 메서드를 사용하면 화면을 전환 할 수 있다.
- 기본 형태
    - present(<새로운 뷰 컨트롤러 인스턴스>, animated:<애니메이션 여부>)
- 화면 전환이 완료되는 시점에 무언가를 실행해 주어야 하는 경우 (화면 전환은 비동기 방식)
    - present(_: animated: completion:)

### 기존 화면으로 돌아가기
- 화면 전환할 때 present 메서드를 이용한것처럼 이전 화면으로 복귀할 때
    - dismiss(animated:) 메서드를 사용해 복귀.
- 마찬가지로 기존 화면으로 돌아간 시점에 무언가를 실행해 주어야 하는 경우
    - dismiss(animated: completion:) 메서드를 사용.

### 내비게이션 컨트롤러와 비교했을때
- 다른점1 : 프레젠테이션 방식은 뒤로가기 버튼을 직접 만들어 주어야 한다.
- 다른점2 : 프레젠테이션 방식은 아래의 코드처럼 기존 뷰 컨트롤러가 다음 뷰 컨트롤러를 호출하고, 돌아가는것도 마찬가지로 기존 뷰 컨트롤러가 해제하는 방식. 즉, 기준이 original ViewController이다.
    - **프레젠테이션 방식 (다음 VC로 전환)**
    ```swift
    @IBAction func moveNext(_ sender: UIButton) {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "secondViewController")
        nextVC.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(nextVC, animated: true)
    }
    ```
    - **프레젠테이션 방식 (이전 VC로 전환)**
    ```swift
    @IBAction func movePrevious(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    ```
    - presentingViewController -> 현재 VC를 띄우고 있는 VC
    - presentedViewController -> 현재 띄워진 VC


## 🍎 2. 내비게이션 컨트롤러를 이용한 화면 전환 
- 항상 콘텐츠 계층 구조의 시작점 역할을 하는 뷰 컨트롤러와 함께 다니는데 이를 root view controller라고 한다.
### 네비게이션 컨트롤러를 추가하는 방법은 크게 두 가지
1. 라이브러리를 통해 Navigation Controller를 추가하는 방법.
    - 네비게이션 컨트롤러만 추가해 주었는데 tableview가 자동으로 따라온다.
    ![](https://i.imgur.com/VxZqsXx.png)
2. 기존이 있던 뷰 컨트롤러에 Embed In 기능을 사용해서 Navigation View Controller 삽입하기.
    ![](https://i.imgur.com/Rpc0LJD.png)
### 내비게이션 컨트롤러 객체의 메서드를 사용하면 스택의 정보를 수정할 수 있다
- 스택의 최상위에 뷰 컨트롤러를 추가할 떄는 pushViewController(_: animated:) 메서드 사용
- 스택의 최상위 뷰 컨트롤러를 제거할 때는 popViewController(animated:) 메서드 사용

### 프레젠테이션 방식과 다른점
- 다른점1 : 뒤로가기 버튼을 직접 만들어주지 않아도 된다.
- 다른점2 : navigation Controller의 스택이 기준이 되어 더하고 빼는 방식
    - **내비게이션 방식 (다음 VC로 전환)**
    ```swift
    @IBAction func moveNext(_ sender: UIBarButtonItem) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") else {
            return
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
        // pushViewController는 호출하는 대상이 내비게이션 컨트롤러.
        // self.navigationController는 현재의 뷰 컨트롤러에 연결된 내비게이션 컨트롤러를 가리키는 것으로, 만약 뷰 컨트롤러에 내비게이션 컨트롤러가 연결되어 있지 않을 경우 nil 반환.
    }
    ```
    - **내비게이션 방식 (이전 VC로 전환) -> 뒤로가기 버튼 기본 제공으로 인해 코드 없음**
    ![](https://i.imgur.com/W5MsVcJ.gif)

    
## 🍎 Embed In 기능
- 기존 요소들 앞에 갑자기 툭 꽂아 넣는다는 점에서 낙하산이라고 생각하면 된다.
- 이 기능은 내비게이션 컨트롤러 뿐만 아니라 탭바 컨트롤러도 추가가 가능하고 선택된 대상에 따라 뷰나 스크롤 뷰 등의 객체도 삽입 가능.

## 🍎 화면 전환 애니메이션 설정 하기

```swift
// 화면 전환 애니메이션 설정
guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "secondViewControllerID") as? SecondViewController else { return }
// 화면 전환 애니메이션 설정
secondViewController.modalTransitionStyle = .coverVertical
// 전환된 화면이 보여지는 방법 설정 (fullScreen)
secondViewController.modalPresentationStyle = .fullScreen
self.present(secondViewController, animated: true, completion: nil)
```

## 🍎 네비게이션 바 백버튼 커스텀
- 네이게이션 컨트롤러를 사용하면 '< Back' <- 자동으로 이렇게 생긴 이전화면으로 돌아가는 파란색의 back 버튼을 제공한다.
- '< Back' 에서 "Back"라는 글자를 지우고 '<'만 남기고, 색상은 그레이로 바꾸고 싶었다.
- bar button item을 커스터마이징해서 navigation item의 backBarButtonItem 자리에 넣어주면 된다.
```swift
let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
backBarButtonItem.tintColor = .gray
self.navigationItem.backBarButtonItem = backBarButtonItem
navigationController?.pushViewController(signUpViewController, animated: true)
```
- 이렇게 만들어 줬더니 런타임에는 잘보이지만 스토리보드에서는 보이지 않아 버튼이 눌렸을때 기존 화면으로 돌아가는 기능을 어떻게 제공해 줘야 하는지 찾아보았다.
- 아래와 같이 UIBarButtonItem을 생성할 때, action argument에 버튼이 눌렸을때 실행될 메서드를 집어넣으면 된다.
```swift
let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backToOriginal(_:)))
backBarButtonItem.tintColor = .gray
self.navigationItem.backBarButtonItem = backBarButtonItem
navigationController?.pushViewController(signUpViewController, animated: true)

@objc func backToOriginal(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
}
```



