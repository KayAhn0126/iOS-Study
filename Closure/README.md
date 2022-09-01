# 클로저 정리
- 헷갈리고 어려운것은 피하지말고 정복하자!

## parameter와 return 둘다 없는 클로저
```swift
let closure = { () -> () in
    print("Closure")
}
```
- 아래와 같이 parameter와 return type 생략 가능

```swift
let closure = {
    print("closure")
}
```

## parameter는 없지만 return이 있는 클로저
```swift
let closure = { () -> String in
    return "Hello World"
}
```
- 아래와 같이 parameter와 return type 생략가능
```swift
let closure = {
    return "Hello World"
}

```


## parameter는 있지만 return이 없는 클로저
```swift
let closure = { (name: String) -> () in
    print("\(name)")              
}
```
- 기본 함수에서는 name은 parameter name이자 argument label 이지만, 클로저에선 오직 parameter name이다.
- 그래서 호출시엔
```swift
closure("Kay!")
```
- 위와 같이 호출.
- 아래와 같이 return type 생략 가능
```swift
let closure = { (name: String) in
    print("\(name)")
}
```



## parameter와 return type 둘 다 있는 클로저
```swift
let closure = { (name: String) -> String in
    return "\(name)"              
}
```

- 아래와 같이 return type 생략 가능
```swift
let closure = { (name: String) in
    return "\(name)"              
}
```
## 기본 클로저 요약
- parameter는 비어있을때만, return type은 언제든지 지워도 됨
---


# 약간 복잡한 클로저

## 함수의 파라미터로 들어오는 클로저
```swift
func someFunc(closure: () -> ()) {
    closure()
}
```
- 클로저를 파라미터로 받는 함수가 정의 되어있다.
- 아래와 같이 함수를 호출 할 수 있다.
```swift
someFunc(closure: { () -> () in
    print("Hello!!!")
})
```
- 비어있는 파라미터와 리턴은 지워도 되니...
```swift
someFunc(closure: {
    print("Hello!!!")
})
```

## 위의 과정을 자세하게 풀어 보기
```swift
func someFunc(closure: () -> ()) {
    closure()
}
```
- 위와 같은 함수가 정의되어 있었고 파라미터 안에는 클로저가 들어가야 한다. 파라미터에 넣을 클로저를 만들어 보자.

```swift
let someOtherFunc = { () -> () in
    print("Hello!!!")
}
```

- 이제 someFunc을 호출해보자!
```swift
someFunc(closure: someOtherFunc)
```
- 위와 같이 호출해 사용할 수 있다. 하지만, 꼭 someOtherFunc이 필요한가?
- 필요없다면 위처럼 바로 호출.
---

## 함수의 반환 타입으로 사용하는 클로저
```swift
func doSomething() -> () -> () {
    return { () -> () in
        print("Hello!!!!!")
    }
}
```
- 이런 이상한 함수가 있다고 해보자.
- 호출
```swift
let closure = doSomething()
closure()
```

- 위에 doSomething 함수를 클로져 형식으로 만들어보자!
- 클로저에서 비어있는 파라미터는 생략가능, 또, return type은 원래 생략가능.. 그럼 아래와 같이 만들 수 있다.

```swift
let doSomething = {
    return {
        print("Hello!!!!!")
    }
}
```
- 호출하는 방식은 똑같다!
```swift
let closure = doSomething()
closure()
```

# 극한 클로져 살펴보기

## 클로저 직접 실행
- 클로저를 소괄호로 감싸고 마지막에 호출 구문인 ()를 추가해주기.
```swift
({ () -> () in
    print("I Love Closure!")
})()
```
