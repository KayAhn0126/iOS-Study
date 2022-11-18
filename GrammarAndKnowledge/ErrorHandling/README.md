# 에러 처리
- [애플 공식 문서](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)참고

## 🍎 enum + Error
- 스위프트의 enumerations는 관련있는 에러 조건들을 모델링하기 좋다.
- 아래의 에러 열거형을 보자
```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```

- 에러를 던진다는것은 예상지 못한 상황이 발생해, 일반적인 실행이 더 이상 불가능 함을 알려준다.
- **throw** 키워드를 사용해 에러를 던져야한다.
- 아래는 자판기가 5개의 코인을 더 필요로 한다는 코드이다.
```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

## 🍎 에러 처리하기
- 스위프트에는 4가지의 에러 처리 방법이 있다.
    - 함수에서 발생한 에러를 해당 함수를 호출한 곳으로 전달하기
    - do-catch 문을 사용해 처리하기
    - 에러를 옵셔널 값으로 처리하기
    - 에러가 발생하지 않음을 보장해 에러 발생 시키지 않기


## 🍎 함수에서 발생한 에러를 해당 함수를 호출한 곳으로 전달하기
- 함수 선언부 파라미터 뒤, 반환 타입 전에,throws 키워드를 붙임으로써 에러가 발생할 수 있는 함수가 된다.
- 이 함수를 throwing 함수라고 한다.
```swift
func canThrowErrors() throws -> String // throwing 함수

func cannotThrowErrors() -> String // non - throwing 함수
```
- **throwing 함수는 내부에서 throw된 에러를 해당 함수를 호출한 곳으로 전달한다.**
- **오직 throwing 함수만 에러를 해당 함수를 호출한 곳으로 전달이 가능하다. non-throwing 함수라면 모든 오류는 함수 내에서 처리해야 한다.**
- 아래는 VendingMachine 클래스 내 vend(itemNamed:) 메서드에서 조건에 맞지 않을때 에러를 발생 시키는 코드.

```swift
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}
```
- vend(itemNamed:) 메서드 구현에서 요구에 맞지 않는 경우 early exit하기 위해 guard문 사용.
- vend(itemNamed:)에서 에러가 발생하고 메서드를 호출한 곳에 에러를 전달하면 그곳(vend 메서드를 호출한 곳)에서는 do-catch문, try?/try! 또는 다시 에러를 상위로 전달하는 방법으로 에러를 처리 해야한다.
- 아래의 buyFavoriteSnack(person: vendingMachine:) 메서드는 throwing function이다.
```swift
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
```
- vend(itemNamed:) 메서드가 에러를 던질수 있는 'throwing function'이기 때문에 함수 호출 시 try 키워드를 앞에 붙인다.
- **참고만 하자!** throwing function 처럼 throwing initializer 또한 같은 방식으로 작동한다.
```swift
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
```

## 🍎 do-catch문 사용
- do 구문에서 에러가 발생하면 catch 구문에서 매치되는 에러를 찾아 처리.
- 기본 형태
```swift
do {
    try expression // 'throwing function'이 들어와야겠죠?
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
```
- 만약 catch 구문에 pattern이 없다면 아래의 코드와 같이 모든 에러를 받고 에러를 error라는 로컬 상수에 바인딩한다.

```swift
catch {
    print("catched an \(error)") // 즉 위의 catch문들에서 걸러지지 못한 에러를 로컬 상수 error에 바인딩 해줘,
                                 // 개발자가 놓친 에러를 잡아줄 수 있게 도와준다.
}
```

- 아래의 코드는 VendingMachineError 열거형의 모든 케이스와 매치되는 코드.
```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."
```
- 위 코드에서 buyFavoriteSnack(person: vendingMachine:) 메서드는 에러를 던질수 있는 'throwing function'라서 try 키워드를 사용해 호출했다.
- 아래와 같은 방식으로 에러 catch 가능
```swift
func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}
```

## 🍎 에러를 Optional value로
- try?를 사용하는 도중 error가 던져진다면 해당 값은 nil이 된다.
```swift
func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
```
- 만약 someThrowingFunction이 에러를 던진다면 x와 y의 값은 nil이된다. 반대로 에러를 던지지 않는다면 someThrowingFunction이 리턴하는 값이 x와 y의 값이 된다.

```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```
- 위와 같은 방법으로도 사용 할 수 있다.

## 🍎 에러가 던져질 일이 없다면
- try! 키워드를 사용해 에러가 상위로 던져지는것을 막을수 있다.

## 🍎 Citation
[애플 공식 문서](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)
