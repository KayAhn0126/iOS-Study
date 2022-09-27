# 클로저 정리
- 헷갈리고 어려운것은 피하지말고 정복하자!


## 🍎 parameter와 return 둘다 없는 클로저
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

## 🍎 parameter는 없지만 return이 있는 클로저
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


## 🍎 parameter는 있지만 return이 없는 클로저
```swift
let closure = { (name: String) -> () in
    print("\(name)")              
}
```
- 기본 함수에서는 name은 parameter name이자 argument label 이지만, 클로저내에선 오직 parameter name이다.
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



## 🍎 parameter와 return type 둘 다 있는 클로저
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
## 🍎 기본 클로저 요약
- parameter는 비어있을때만, return type은 언제든지 지워도 됨
---


# 약간 복잡한 클로저

## 🍎 함수의 파라미터로 들어오는 클로저
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

## 🍎 위의 과정을 자세하게 풀어 보기
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

## 🍎 함수의 반환 타입으로 사용하는 클로저
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

# 일회성 클로져 살펴보기

## 🍎 클로저 직접 실행
- 클로저를 소괄호로 감싸고 마지막에 호출 구문인 ()를 추가해주기.
```swift
({ () -> () in
    print("I Love Closure!")
})()
```


# 트레일링 
```swift
func doSomething(closure: () -> ()) {
    closure()
}
```

- 위의 함수를 호출하려면
```swift
doSomething(closure: { () -> () in
    print("Hello!")
})
```


- 트레일링 클로저
    - 함수의 마지막 파라미터가 클로저일 때, 이를 파라미터 값 형식이 아닌 함수 뒤에 붙여 작성하는 문법 이때, Argument Label은 생략된다.
```swift
func doSomething(closure: () -> ()){
    closure()
}

func someOther() -> () {
    print("hello1")
}
```
```swift 
doSomething(closure: someOther) // 기본 호출 방법.

doSomething(closure: { () -> () in // someOther이란 메서드를 만들지 않고 doSomething메서드를 사용하는방법
    print("hello2")
})                                // }) 이부분이 해석하기 쉽지 않으니 아래처럼 없애버리자!

// 호출하려는 함수의 옆에 ()를 붙이면 된다.
// 트레일링 클로저는 마지막 argument label 삭제 가능
doSomething() { () -> () in
    print("hello3")
}

// 만약 파라미터가 클로저 하나라면? () 소괄호도 없앨수 있다! -> 아래의 형태처럼 변화함

doSomething { () -> () in
    print("hello4")
}

// 비어있는 파라미터와 리턴 타입은 생략 가능

doSomething {
    print("hello5")
}
```
