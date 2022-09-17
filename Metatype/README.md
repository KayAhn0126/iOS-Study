# Metatype

```swift
struct Game {
    static let coin = 100
}

let gameInstance: Game = Game.init() // game이라는 타입으로 찍어낸 인스턴스

let gameType: Game.Type = Game.self // game이라는 타입을 타입으로하는 상수. 클래스를 담고있다고 생각하자! -> 클래스 자체만 받는 통에 클래스 자체를 넣는다고 생각하기.

print(gameType) // game
// someClass.self는 someClass의 인스턴스를 리턴하는게 아니라, someClass라는 것 자체를 리턴한다.
```

## 🍎 왜 Game이 아니라 Game.self일까?

- Game은 타입 네임이지, 타입 오브젝트가 아니다.
- 컴파일러가 예외적으로 멤버에 접근할 때 .(dot Syntax)를 이용해 접근가능

```swift
print(Game.coin) // 컴파일러가 타입 네임을 통해 멤버에 접근하도록 허용
print(Game.self.coin) // 타입 오브젝트를 통해 멤버에 접근하고 있음.
```

## 참고자료
- https://velog.io/@budlebee/Swift-5-%EB%A9%94%ED%83%80%ED%83%80%EC%9E%85-%ED%83%80%EC%9E%85Metatype-Type
- https://woozzang.tistory.com/160
