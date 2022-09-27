# Associated Types

## 🍎 타입을 제한하는 경우
```swift
protocol Appendable {
    func append(_ item: String)
}

class CustomArray: Appendable {
    private var collection = [String]()
    
    func append(_ item: String) {
        collection.append(item)
    }
}
```
- 위와 같은 경우, append 함수는 String 타입만 받을수 있다. 아래의 코드를 보자.

## 🍎 함수 사용 시점에 타입을 결정해 범용성 높이기.
```swift
protocol Appendable {
    associatedtype Item
    
    var collection: [Item] { get set }
    
    func append(_ item: Item)
}

class CustomArray: Appendable {
    typealias Item = String 
    // Appendable 프로토콜을 채택하면 Appendable 프로토콜을 준수하라며 빨간 에러가 생긴다. 그럼 먼저 typealias를 설정한다. 
    // typealias를 설정하게 되면 자동으로 collection의 타입과 func append의 파라미터 타입은 typealias의 값으로 설정된다.
    
    var collection: [String] = []
    
    func append(_ item: String) {
        collection.append(item)    
    }
}
```
