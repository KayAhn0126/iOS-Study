# 화면간 데이터 전달 방법

## 🍎 설명을 위한 전제 조건
- VC1(preVC)에는 프로퍼티로 myEmail과 myAddress를 가지고 있다.
- VC2(nextVC)에는 프로퍼티로 email과 address를 가지고 있다.


## 🍎 다음 화면으로 값 전달하기 (A -> B) 
- 다음 화면을 생성과 동시에 생성하는 ViewController가 가지고 있는 프로퍼티에 값을 저장하는 방법.
```swift
guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as ? NextViewController else {
    return
}

nextVC.email = self.myEmail.text
nextVC.address = self.myAddress.text

// 프레젠테이션 방식으로 새로운 화면 호출 후 전환
self.present(nextVC, animated: true)
or
// navigation stack에 push하는 방식으로 전환
self.navigationController?.pushViewController(nextVC, animated: true)
```


## 🍎 이전 화면으로 값 전달하기 (B -> A)
```swift
in nextVC...

let preVC = self.presentingViewController
guard let vc = preVC as ? ViewController else {
    return
}

// preVC의 프로퍼티로 값 전달하기
vc.myEmail = self.email.text
vc.myAddress = self.address.text

// 프레젠테이션 방식으로 현재 VC를 생성 후 호출 했었다면...
self.presentingViewController?.dismiss(animated: true)

// navigation stack에서 pop하는 방식으로 돌아가기
self.navigationController?.popViewController(animated: true)
```
