# Metatype
```swift
struct Game {
    static let coin = 100
}

let gameInstance: Game = Game.init() // Game이라는 타입으로 찍어낸 인스턴스

let gameType: Game.Type = Game.self // Game이라는 타입을 타입으로하는 상수. -> 클래스 자체만 받는 통에 클래스 자체를 넣는다고 생각하기.

print(gameType) // Game
// someClass.self는 someClass의 인스턴스를 리턴하는게 아니라, someClass라는 것 자체를 리턴한다.
```

## 🍎 왜 Game이 아니라 Game.self일까?
- 위의 코드에서 조금 알쏭달쏭(?)한 부분을 볼 수 있다.
```swift
let gameType: Game.Type = Game.self
```
- 이 부분인데 상식적으로 생각하면...
```swift
let gameType: Game.Type = Game
```
- 이렇게 되어야 하지 않나 싶지만, Game은 타입 네임이지, 타입 오브젝트가 아니다.
```swift
let gameType: Game.Type = Game.self
```
- 이렇게 Game 뒤에 .self를 붙여 메타타입 자체를 오브젝트화 후 넘긴다.
- 즉, Game은 타입 네임, Game.self는 타입 오브젝트이다.
- 컴파일러가 예외적으로 타입네임으로 멤버에 접근할 때 .(dot Syntax)를 이용해 접근이 가능하도록 해줌.

```swift
print(Game.coin) // 컴파일러가 타입 네임을 통해 멤버에 접근하도록 허용
print(Game.self.coin) // 타입 오브젝트를 통해 멤버에 접근하고 있음.
```
## 🍎 metatype 사용법
- 메타타입도 타입이므로 아래와 같이 함수를 만들수 있다.
```swift
func doSomething(with type: String.Type) {
    //...
}
```
- 위와 같은 경우에는 컴파일 시점에 어떤 메타타입 인스턴스가 사용될지 알지만, 프로그램이 실행되는 runtime에 얻어지는 오브젝트의 메타타입을 알려면 type(of:) 메서드를 사용하면 된다.


## 🍎 Citation
- https://velog.io/@budlebee/Swift-5-%EB%A9%94%ED%83%80%ED%83%80%EC%9E%85-%ED%83%80%EC%9E%85Metatype-Type
- https://woozzang.tistory.com/160
- [정리하기](https://medium.com/swiftcraft/introduction-to-swift-metatypes-21949842d7a)
