# Delegate Pattern

## 🍎 델리게이트 패턴 연습 코드
- 다른분의 [블로그](https://velog.io/@zooneon/Delegate-%ED%8C%A8%ED%84%B4%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%BC%EA%B9%8C)를 보고 너무 좋은 설명이라고 생각해 직접 타입해보고 이해하기로 했다.
- 설명 :
    - 파티 디렉터가 너무 바빠 해야할 일을 대리자에 위임하는 내용
- 흐름 :
    1. 대리자가 해야 할 일을 프로토콜에 정의했다.
    2. 위임자 클래스에서 위의 프로토콜을 타입으로 하는 프로퍼티를 가지고있다.
    3. 대리자 클래스에서 위임자로부터 위임을 받는다.
    4. 위임자가 오더하면 대리자가 일을 한다.
- 그림 : 
    ![DelegatePatternPractice](https://user-images.githubusercontent.com/40224884/186410123-ebc994c4-bc24-4910-939c-9420bdb37b42.png)

## 🍎 코드를 부분 부분 살펴보기

### 📖 대리자가 해야할일을 정의하는 프로토콜
```swift
protocol PrepareParty: AnyObject {
    func prepareFood()
    func prepareSong()
}
```

- class만 프로토콜을 채택하고 준수할수 있도록 만들고 싶었지만 아래 사진과 같이 deprecated 되었다고 해서 AnyObject로 변경했다.
![](https://i.imgur.com/APSOrzg.png)

### 📖 파티 디렉터 (위임자) 클래스
```swift
class PartyDirector {
    var delegate: PrepareParty?
    
    func order() {
        self.delegate?.prepareFood()
        self.delegate?.prepareSong()
    }
}
```
- delegate 프로퍼티가 옵셔널이 아니면 이니셜라이저를 작성해주어야 해서 옵셔널로 주었다.
- order() 메서드를 호출하면 위임한 대리자의 메서드가 호출된다.


### 📖 파티 워커 (대리자) 클래스
```swift
class FirstPartyWorker: PrepareParty {
    init(director: PartyDirector) {
        director.delegate = self
    }
    func prepareFood() {
        print("first worker is preparing food!")
    }
    func prepareSong() {
        print("first worker will sing a song!")
    }
}


class SecondPartyWorker: PrepareParty {
    init(director: PartyDirector) {
        director.delegate = self
    }
    func prepareFood() {
        print("second worker is preparing food!")
    }
    func prepareSong() {
        print("second worker will sing a song!")
    }
}
```
- 두 클래스 모두 PrepareParty(대리자가 해야할일) 프로토콜을 채택하고 있기 때문에 필수 구현 메서드를 구현해주어야 한다.

### 📖 실제 명령 클래스
```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let Kay = PartyDirector()
        let worker1 = FirstPartyWorker(director: Kay)
        Kay.order()
        let worker2 = SecondPartyWorker(director: Kay)
        Kay.order()
    }
}
```

- Kay가 파티 디렉터이고 worker1과 worker2가 Kay를 매개변수로 삼아 initialize 되었다.
- Kay.order()를 하게되면 PartyDirector클래스의 order()가 호출되고 위임이 되어있는 대리자가 자신의 메서드들을 호출한다.

## 🍎 실험
- 아래와 같이 코드를 작성하고 실행해도 동일한 결과가 나올거라 생각했다.
```swift
let Kay = PartyDirector()
let worker1 = FirstPartyWorker(director: Kay)
let worker2 = SecondPartyWorker(director: Kay)
Kay.order()
```

- 기존 코드 결과
    - first worker is preparing food!
    - first worker will sing a song!
    - second worker is preparing food!
    - second worker will sing a song!
- 실험 코드 결과
    - second worker is preparing food!
    - second worker will sing a song!

- delegate는 1:1이기 때문에 디렉터가 마지막으로 할당된 worker2의 메서드만 실행 되었다.

## 🍎 실험을 통해 배운점
1. delegate / protocol은 1 : 1
2. notification / observer 1 : many
