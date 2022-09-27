# Notification Center

## 🍎 Definition :

- A notification dispatch mechanism that enables the broadcast of information to registered observers.

## 🍎 When to use?

1. 앱 내에서 공식적인 연결이 없는 두 개 이상의 컴포넌트들이 상호작용이 필요할 때
2. 상호작용이 반복적으로 그리고 지속적으로 이뤄져야 할 때
3. 일대다 또는 다대다 통신을 사용하는 경우

## 🍎 Procedure:

1. 구독자가 구독한다 → addObserver한다!
2. 유튜버가 방송을 한다 → POST 한다!
3. Notification이 오면 addObserver때 입력한 함수를 실행한다! 

---

위에 설명은 블로그에서 뻔히 보이는 절차. 조금 색다르게 해보자!

### 스토리:

신혼부부 집에 아기가 있다. 당연하게도 부부는 아기에게 온 신경이 집중 되어있다. 

아기가 어떠한 이유 때문에 울면 부부가 아기가 보낸 메세지를 통해 아기를 위해 무언가를 한다.

- 부부가 아기에게 신경 쓰는것을 addObserver라고 생각하자.
    - addObserver의 selector 매개변수 값은 아기가 울 때 부부가 할 행동이다
- 아기가 우는 행동을 post라고 생각하자.
    - 아기는 자신이 왜 우는지 메세지를 보낸다.
- 아기가 보낸 메세지에 따라 부부 내외가 하는 행동을 careBaby()라고 생각하자.
    - 아기가 보낸 메세지에 따라 부부가 특정 행동을 한다.

### 📖 addObserver 매개변수 설명

- self → 실행한 객체
- selector → 실행할 함수
    - 실행할 함수는 아래의 코드 처럼 Notification타입의 매개변수를 받아야 한다!
    
    ```swift
    careBaby(_ CryingInfo: Notification)
    ```
    
- name → notification의 이름.
- object → 지정하면 특정 sender로부터만 notification을 받는다 → 선택적.

```swift
func addObserverForBady() {
    NotificationCenter.default.addObserver(self,
                                                                                 selector: #selector(careBaby(_:)),
                                                                                 name: Notification.Name("Crying"),
                                                                                 object: nil)
}
```

### 📖 addObserver 함수의 역할

- 등록해둔 이름(name)으로 notification이 오면 selector에 등록되어 있는 함수(careBaby) 실행.
- 즉, 아기가 울면 실행되는 함수!

---

### 📖 post 매개변수 설명

- name → notification의 이름.
- object → 전달하고자 하는 데이터 또는 객체, 없으면 nil
- userInfo → notification과 관련된 값, 없으면 nil
    - [AnyHashable : **Any**]? = **nil 형식으로 보내면 된다.**
    - 아래의 코드에서 userInfo에 있는 데이터는 addObserver의 실행 함수(careBaby)에서 쓰인다.

```swift
func babyStartCrying() {
    NotificationCenter.default.post(name: Notification.Name("Crying"),
                                                                    object: nil,
                                                                    userInfo: [CryingSound.type : "Hungry"])
}
```

### post 함수의 역할

- Notification.Name("Crying")을 등록한 모든 옵져버에게 notification을 보낸다.
    - 아기가 “나 울어요~” 신호 보낸다!
- notification을 받은 옵져버들에게 전달할 데이터를 userInfo에 같이 보낸다.
    - 아기가 “나 무슨무슨 이유 때문에 울어요~” 라고 이유도 같이 보낸다.

---

### 📖 이제 post 까지 되었다면...

- 처음에 addObserver에 등록해두었던 함수가 실행된다.

```swift
@objc func careBaby(_ CryingInfo: Notification) {
    guard let reason = CryingInfo.userInfo?[CryingSound.type] as? String
    switch reason {
    // reason에 따라 처리할 수 있다.
    case "Hungry" :
        feed()
    case "Sleepy" :
        playMusic()
    ...
    ...
    ...
    }
}
```
