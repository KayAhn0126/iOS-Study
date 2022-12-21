# 저장소를 사용해 값 저장 및 호출

## 🍎 시작하기전 알아둘것
- 아래 내용에서는 AppDelegate 객체, UserDefaults 객체라고 표현하는데 사실 이는 각각 AppDelegate 클래스의 객체, UserDefaults 클래스의 객체라고 표현 하는것이 맞다. 하지만 AppDelegate, UserDefaults 두 클래스 모두 고유의 인스턴스는 하나씩 가지고 있기 때문에 아래에서는 '클래스 + 객체'로 사용했다.

## 🍎 생명주기로 알아보는 저장소들
- AppDelegate 객체 -> 앱이 종료되면 저장 정보도 휘발
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
- 즉, AppDelegate 클래스를 통해 객체를 만들면 email, address, age를 프로퍼티로 갖는다.
- 하지만, AppDelegate 클래스의 인스턴스는 우리가 일반적으로 객체를 생성하는 것 처럼 직접 생성할 수 없다.

```swift
// 저장하려는 ViewController에서..
import UIKit
class UpdatePurposeViewController: UIViewController {
    
    // ... (중략) ...
    
    @IBAction func saveItToAppDelegate(_ sender: Any) {
        let ad = UIApplication.shared.delegate as? AppDelegate
        // 코드처럼 UIApplication.shared.delegate(UIApplicationDelegate? 타입)을 AppDelegate 타입으로 다운캐스팅해서 사용 해야한다.
        // UIApplication 클래스 -> 앱의 제어권을 가지고 있는 가장 중심이 되는 클래스
        // UIApplication.shared -> 클래스의 타입 프로퍼티 접근
        // UIApplication.shared.delegate -> 여기서 .delegate는 UIApplication의 위임 객체.
        // UIApplication.shared.delegate는 UIApplicationDelegate? 타입이다.

        
        // 값 저장
        ad?.email = self.email.text
        ad?.address = self.address.text
        ad?.age = self.age
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true)
    }
}
```

- UIApplication.shared.delegate에서 delegate가 어디서 나왔고 무슨 역할인지 정의부에 가서 확인 해보았다.
- "Every app must have an app delegate object to respond to app-related messages."
- 모든 앱에는 앱 관련 메세지에 응답하기 위해 위임 객체가 있어야 한다

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


## 🍎 UserDefaults 객체를 사용해 값 저장하기
- 런타임 환경에서 동작하는 객체
- 싱글턴 (동시성 문제를 블로킹 알고리즘으로 방지해 Thread safe)
- 내부적으로 plist 파일을 이용해 값을 저장하는 UserDefaults 객체
    - 본래 NSData, NSString, NSNumber, NSDate, NSArray, NSDictionary 타입의 값만 저장할 수 있었다.
    - 즉, 다른 클래스 타입의 객체를 저장하려면 직렬화 과정을 거쳐야 했다.
    - 하지만 스위프트 언어가 코코아 터치 프레임워크에 반영되면서 스위프트에서 제공하는 기본 자료형까지 UserDefaults 객체에서 그대로 저장할 수 있게 됨.

- UserDefaults에 저장하는 코드
    - 일반, 객체, 배열의 저장 방식을 알아보자
```swift
import UIKit
class UpdatePurposeViewController: UIViewController {
    
    // ... (중략)...
    
    @IBAction func saveItToUserDefaults(_ sender: Any) {
        // UserDefault 객체의 인스턴스 가져오기
        let ud = UserDefaults.standard
        
        // 일반 타입의 값 저장하기
        ud.set(self.email.text, forKey: "email")
        ud.set(self.address.text, forKey: "address")
        ud.set(self.age, forKey: "age")
        
        // 객체 저장하기
        UserDefaults.standard.set(try? PropertyListEncoder().encode(객체), forKey:"객체")

        // 배열 저장하기
        UserDefaults.standard.set(try? PropertyListEncoder().encode(배열), forKey:"배열")
        
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

## 🍎 UserDefaults에 저장된 값을 사용하기
```swift
import UIKit
class MainViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        // UserDefault 객체의 인스턴스 가져오기
        let ud = UserDefaults.standard
        
        // 일반적인 타입의 값 추출하기
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        // 객체의 값 추출하기
        if let data = UserDefaults.standard.value(forKey:"genre") as? Data {
            let genre = try? PropertyListDecoder().decode(Genre.self, from: data)
        }

        // 배열 추출하기
        if let data = UserDefaults.standard.value(forKey:"genres") as? Data {
            let genres = try? PropertyListDecoder().decode([Genre].self, from: data)
        }
    }
}
```

## 🍎 computed property와 UserDefaults를 같이 사용하기
- Computed Property를 활용하여 UserDefaults에 데이터를 더 쉽에 읽고 쓸 수 있다.
- get에서는 UserDefaults에 저장되어있는 데이터를 가져와 디코딩한후 반환하고 데이터가 없거나 디코딩이 실패하면 **예제**처럼 빈배열을 반환하거나 입맛에 맞게 nil을 반환하면 된다.
- set에서는 newValue를 인코딩하여 UserDefaults에 저장합니다.
```swift
static var movieGenres: [Genre] {
    get {
        var genres: [Genre]?
        if let data = UserDefaults.standard.value(forKey:"genres") as? Data {
            genres = try? PropertyListDecoder().decode([Genre].self, from: data)
        }
        return genres ?? []
    }
    set {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"genres")
    }
}
```
- computed property 내용은 이 [블로그](https://kyungmosung.github.io/2020/08/17/swift-userdefaults-customobject/)를 참고.
