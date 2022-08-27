# 🍎 스토리보드 없이 프로젝트 시작하기
1. 프로젝트 네비게이터에서 Main.storyboard 삭제
2. 프로젝트 클릭 -> General -> Development Info -> Main Interface를 "Main"에서 빈칸으로 수정.
3. Info.plist -> Application Scene Manifest -> Scene Configuration -> Application Session Role -> Item 0 -> Storyboard Name 속성을 삭제.
4. SceneDelegate.swift파일을 아래와 같이 수정
```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController(nibName: nil, bundle: nil) // 루트 뷰컨트롤러 생성
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
```
