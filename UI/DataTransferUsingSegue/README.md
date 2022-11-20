# Segue를 통한 Navigation Controller 사용
- segue를 이용해 Navigation 방식으로 다음VC(SettingVC)를 띄우고 띄워진 VC에서 설정한 값을 기존 VC(DisplayVC)로 가져와 세팅하는 과정 정리 + 설정한 값 유지하기

## 🍎 기존에 코드를 통해 사용한 Navigation Controller 및 데이터 전달
- Storyboard에 있는 view controller를 Navigation 방식으로 띄울때 아래와 같은 방법을 사용했다.
```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let vc = storyboard.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
vc.delegate = self
self.navigationController?.pushViewController(vc, animated: true)
```

## 🍎 segue를 사용해 구현한 Navigation Controller
![](https://i.imgur.com/zGpN0En.png)
- 이렇게 segue를 다음 화면에 'show'로 연결해주면 Navigation 방식으로 띄워진다.
- 띄우는건 문제가 없지만 값을 전달 해야할때 위코드를 통해 다음 vc의 프로퍼티에 값을 넣어줄때는 아래와 같은 방식으로 설정해주었지만, segue를 통한 화면 전환 및 데이터 주입 방식은 비슷하지만 조금 다르다.
```swift
vc.delegate = self
```
- prepare(for: sender:) 메서드를 사용해 다음 VC 내 프로퍼티에 값 저장하기 하는것인데,
- prepare(for: sender:) 메서드는 연결된 segue를 실행하기전 작동하는 메서드이다.
- 즉, 다음 VC가 띄워지기전 다음 VC의 내용을 채워줄 수 있는 곳이라고 생각하면 된다.
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let settingViewController = segue.destination as? SettingViewController {
        settingViewController.delegate = self // 현재 VC("DisplayViewController가 settingViewController의 delegate 프로퍼티에 할당 되겠다." 라는 의미)
    }
}
```

## 🍎 설정한 값 유지하기
- 다시 SettingVC를 띄우는 경우, 이전 데이터가 남아있지 않는다 이러한 경우를 위해, 다음 VC가 띄워지기 전 현재 화면의 값을 다음 화면의 프로퍼티에 세팅 해주면 값이 유지되는 것처럼 보인다!
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let settingViewController = segue.destination as? SettingViewController {
        settingViewController.delegate = self
        settingViewController.textFromPreviousVC = customLabel.text
        settingViewController.textColor = customLabel.textColor
        settingViewController.backGroundColor = backGroundView.backgroundColor!
    }
}
```
- 약간의 눈속임처럼 보이는데, 이것이 최상의 방법인지 생각해보자!

## 🍎 Citation
- [애플 공식 문서](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621490-prepare)
- [prepare segue 데이터 전달, NavigationController segue](https://baechukim.tistory.com/12)
- [prepare 메소드란?](https://jiyeonlab.tistory.com/9)
