# 저장소를 사용해 값 주고 받기

## 🍎 생명주기로 알아보는 저장소들
- AppDelegate 클래스 -> 앱이 종료되면 저장 정보도 휘발
- UserDefaults 객체 -> 앱이 삭제될 때 까지 저장 가능
    - 보통 간단한 데이터를 저장하는 용도로 사용.
    - 코코아 터치 프레임워크에서 제공
- Core Data 객체 -> 앱이 삭제될 때 까지 저장 가능
    - 보통 소규모 데이터베이스 처럼 다소 복잡한 형태의 데이터를 저장하는데 사용
    - 코코아 터치 프레임워크에서 제공




## 🍎 AppDelegate 객체를 사용해 값 주고 받기

### 천천히 알아보기
- 가장 쉽게 사용할 수 있는 객체로 AppDelegate.swift 파일에 정의된 AppDelegate 클래스.
- 엄밀히 말하면 저장소의 역할이 아니다. 
    - 원래의 목적은 UIApplication 객체로부터 생명 주기 관리를 위임 받아 커스텀 코드를 처리하는 역할.
- 임시 저장소처럼 사용할 수 있는 이유
    - 이 객체는 앱 전체를 통틀어 단 하나만 존재.
    - 모든 뷰 컨트롤러에서 접근 가능.
    - 앱의 생성과 소멸을 함께함 (앱이 종료 될때까지 유지됨, 종료되면 휘발)

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    /* 값을 저장할 변수 정의 */
    var email: String?
    var address: String?
    var age: Int?
}
```


```swift
// 저장하려는 ViewController에서..
import UIKit
class UpdatePurposeViewController: UIViewController {
    
    // ... (중략) ...
    
    @IBAction func saveItToAppDelegate(_ sender: Any) {
        // AppDelegate 객체의 인스턴스를 가져온다.
        let ad = UIApplication.shared.delegate as? AppDelegate
        // AppDelegate의 인스턴스를 가져오는 코드
        // AppDelegate는 앱 전체를 통틀어 하나의 인스턴스만 존재하도록 iOS 시스템에 의해 보장.
        // 이런 특성으로 인해 AppDelegate 클래스의 인스턴스는 직접 생성할 수 없고,
        // UIApplication.shared.delegate 구문을 통해 현재 생성되어 있는 인스턴스를 참조해야 한다.
        // UIApplication.shared.delegate 구문으로 읽어온 앱 델리게이트 객체는 UIApplicationDelegate타입이므로, 우리가 추가한 프로퍼티를 사용하려면 AppDelegate 클래스 타입으로 다운캐스팅 해야한다.
        
        // 값 저장
        ad?.email = self.email.text
        ad?.address = self.address.text
        ad?.age = self.age
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
}
```

```swift
// AppDelegate 객체의 값을 원하는 ViewController의 프로퍼티에 넣는 코드
import UIKit
class MainViewController: UIViewController {
    
    // ... (중략) ...
    
    override func viewWillAppear(_ animated: Bool) {
        // AppDelegate 객체의 인스턴스를 가져온다.
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let email = ad?.email {
            result.email = email
        }
        ...
        ...
        ...
    }
}
```

### 경우에 따라서 AppDelegate 클래스를 대신하는 다른 클래스를 만들어 역할 대체 가능
1. UIResponse 클래스를 상속받아야 한다.
2. UIApplicationDelegate 프로토콜 채택 및 준수.
3. @UIApplicationMain 어노테이션 붙이기. 여기서는 @main
    - @UIApplicationMain 어노테이션을 붙이는건 해당 클래스를 앱 델리게이트로 선언하겠다는 뜻.
    - 따라서 하나의 앱에 @UIApplicationMain 어노테이션은 한번만 사용 해야함.


## 🍎 UserDefaults 객체를 사용해 값 주고 받기
- 내부적으로 plist 파일을 이용해 값을 저장하는 UserDefaults 객체
    - 본래 NSData, NSString, NSNumber, NSDate, NSArray, NSDictionary 타입의 값만 저장할 수 있었다.
    - 즉, 다른 클래스 타입의 객체를 저장하려면 직렬화 과정을 거쳐야 했다.
    - 하지만 스위프트 언어가 코코아 터치 프레임워크에 반영되면서 스위프트에서 제공하는 기본 자료형까지 UserDefaults 객체에서 그대로 저장할 수 있게 됨.

- UserDefaults에 저장하는 코드
```swift
import UIKit
class UpdatePurposeViewController: UIViewController {
    
    // ... (중략)...
    
    @IBAction func saveItToUserDefaults(_ sender: Any) {
        // UserDefault 객체의 인스턴스 가져오기
        let ud = UserDefaults.standard
        
        // 값 저장하기
        ud.set(self.email.text, forKey: "email")
        ud.set(self.address.text, forKey: "address")
        ud.set(self.age, forKey: "age")
        
        // 이전 화면으로 돌아가기
        self.presentingViewController?.dismiss(animated: true)
    }
}
```
- UserDefaults는 시스템에서 자동으로 생성하여 제공하는 단일 객체.
- UserDefaults.standard는 클래스 프로퍼티이므로 인스턴스를 생성하지 않고 사용.
### 위의 코드 설명
- UserDefaults.standard 프로퍼티를 통해 얻어온 UserDefaults 객체의 인스턴스를 ud 상수에 저장.
    - set(_: forKey:) 메서드를 사용해 값을 저장.
    - UserDefaults에 저장한 객체는 함께 저장된 키를 통해 구분된다.

### UserDefaults에 저장된 값을 꺼내는 코드
```swift
import UIKit
class MainViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        // UserDefault 객체의 인스턴스 가져오기
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
    }
}
```

### UserDefaults에 대해 알아둘 점.
- UserDefaults 객체는 인메모리 캐싱(In - memory Caching) 메커니즘을 사용한다.
- 인메모리 캐싱 정의
    - 실제 저장된 위치에서 데이터를 매번 새로 읽어 들이는 것이 아닌 한번 읽은 데이터를 메모리에 저장해 두고 재사용하는 것
- 인메모리 캐싱 장단점
    - 장점: 한번 읽은 데이터를 메모리에 저장해 두고 재사용해 성능 향상
    - 단점: 기본 저장소와 메모리에 있는 데이터가 일치하지 않을 가능성 있음.
- 데이터 통일을 위해 UserDefaults에 데이터를 저장한 후, 캐싱된 데이터를 갱신하여 양쪽 데이터를 일치시켜 주어야 한다.
- 이를 동기화 처리 또는 싱크 처리라고 한다.
- synchronize()메서드 사용.
```swift
let ud = UserDefaults.standard

ud.set("Kay", forKey: "name")
ud.set(30, forKey: "age") // forKey의 타입은 항상 String.
ud.synchronize() // 싱크처리
```

