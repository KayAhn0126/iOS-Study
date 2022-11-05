# main이 아닌 스토리보드에서 시작하기

## 🍎 절차
- 먼저 시작하고 싶은 스토리보드의 View Controller를 제외하고 모두 'is Initial View Controller'를 제거한다.
- 아래와 같은 SceneDelegate내 메서드를 찾는다.
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let _ = (scene as? UIWindowScene) else { return }
}
```
- 이곳에 아래와 같은 내용을 넣는다.
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let storyboard = UIStoryboard(name: "CatstagramTabBar", bundle: nil)
    let intialVC = storyboard.instantiateInitialViewController()
    self.window?.rootViewController = intialVC
    guard let _ = (scene as? UIWindowScene) else { return }
}
```
- 프로젝트 -> Targets -> Info -> Main storyboard file base name를 시작하고자하는 View Controller가 있는 스토리보드의 이름으로 바꿔준다.
![](https://i.imgur.com/ozi3wHJ.png)

## 🍎 Citation
[참고 했던 stackoverflow](https://stackoverflow.com/questions/44364264/how-to-set-a-different-entry-point-on-first-app-launch)
