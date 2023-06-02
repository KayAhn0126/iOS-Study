# DispatchQueue
```swift
DispatchQueue.main.sync // 메인 스레드에서 동기로 작업을 처리해라
DispatchQueue.main.async // 메인 스레드에서 비동기로 작업을 처리해라
DispatchQueue.global().sync // 다른 스레드에서 동기로 작업을 처리해라
DispatchQueue.global().async // 다른 스레드에서 비동기로 작업을 처리해라
```
- 간단하게 설명하면 main은 main 쓰레드에서 실행되고, global()은 main 쓰레드가 아닌 쓰레드에서 실행된다는 이야기
- 더 자세히는 DispatchQueue.main은 DispatchQueue 클래스의 타입 프로퍼티 main을 사용해서 main쓰레드를 사용하는것이고,
- DispatchQueue.global()은 DispatchQueue 클래스의 타입 메서드 global(qos: DispatchQoS.QoSClass) -> DispatchQueue를 사용해서 남는자원으로 주어진 작업을 실행하는 가장 좋은 방법(예: main 스레드가 아닌 다른 쓰레드를 사용하는것)을 결정한다.
    - 만약 남는 쓰레드마저 포화가 된다면 main 쓰레드도 가져다 사용할 수 있지만, 그럴일은 없기 때문에 보통 global()을 통해 작업을 하게 된다면 main이 아닌 다른 쓰레드에서 처리한다고 생각하는것이다.

## 🍎 sync와 async의 공통점과 차이점
- 공통점:
    - 위의 메서드들은 타겟 thread Queue에 Task를 추가만 한다
    - 예를 들어 DispatchQueue.main.sync(block:) 는 main thread 큐에 동기적으로 Task를 추가합니다.
    - DispatchQueue.global().async(block:) 는 global thread queue 에 비동기적으로 Task를 추가합니다.
    - Task를 쓰레드에 배정하여 실행시키는 것은 GCD의 역할입니다.
 
- 차이점:
    - 반환 시점과 완료 시점
    - async로 Task를 추가할 경우, 비동기 방식이기 때문에 Task를 타겟 큐에 추가만 해놓고 바로 반환된다.
    - 이후 추가된 task는 GCD가 알아서 쓰레드에 배정한다. -> 정확한 실행 시점을 알 수 없다.

## 🍎 복습
- DispatchQueue(label:)로 큐를 만들면 global() 큐다.
    - main thread에서 실행되지 않는것을 확인
- DispatchQueue(label: "myQueue", attributes: .concurrent)처럼 커스텀으로 큐를 만들 수 있다.
- 커스텀으로 큐를 만들면 선택할 수 있는 옵션이 생기는데 큐를 직렬, 병렬 큐다.
    - 이 옵션은 DispatchQueue.main이나 DispatchQueue.global()로는 만들수 없다.
    - Serial 큐 -> 큐 안에 내용물을 무조건 순서대로 처리 -> 직렬 큐
    - Concurrent 큐 -> 큐 안에 내용물을 병렬로 처리, 이때 하나의 작업 마저도 병렬로 처리한다.

## 🍎 테스트
### 📖 직렬 큐 + sync
```swift
let que = DispatchQueue(label: "myQueue")
que.sync {
    print("Task 1 Started")
    print("Task 1 Ended")
}

que.sync {
    print("Task 2 Started")
    print("Task 2 Ended")
}
```
- 위의 코드는 que에서 동기로 Task 1 Started와 Task 1 Ended를 실행하고 끝나면 바로 동기로 Task 2 Started와 Task 2 Ended가 실행된다.
- 수행 결과
    - Task 1 Started
    - Task 1 Ended
    - Task 2 Started
    - Task 2 Ended

### 📖 직렬 큐 + async
```swift
let que = DispatchQueue(label: "myQueue")
que.async {
    print("Task 1 Started")
    print("Task 1 Ended")
}

que.async {
    print("Task 2 Started")
    print("Task 2 Ended")
}

sleep(1)
```
- 위의 코드는 que에서 비동기로 Task 1 Started와 Task 1 Ended를 실행하라고 넣어주고 바로 반환된다.
- 또,  Task 2 Started와 Task 2 Ended 출력 작업을 que에 넣어주고 바로 반환된다.
- 이 코드를 실행해보면 아무것도 출력되지 않고 바로 종료가 되는데, 실행이 안되는것이 아니라 프로그램 종료가 async 처리보다 더 먼저 실행되기 때문에 출력이 안되는것처럼 보인다. 출력을 확인하기 위해서 sleep(1)을 추가해 1초를 기다렸다 프로그램이 종료되도록 만들었다.
- 수행 결과
    - Task 1 Started
    - Task 1 Ended
    - Task 2 Started
    - Task 2 Ended

### 📖 병렬 큐 + sync
```swift
let que = DispatchQueue(label: "myQueue", attributes: .concurrent)

que.sync {
    print("Task 1 Started")
    print("Task 1 Ended")
}
que.sync {
    print("Task 2 Started")
    print("Task 2 Ended")
}

sleep(1)
```
- 병렬 큐라도 동기로 작업을 진행한다면 해당 task를 실행하는동안 thread를 block 상태로 만들어 다른 작업을 실행 시킬수 없으므로, 위의 코드는 순차적으로 출력된다.

### 📖 병렬 큐 + async
```swift
let que = DispatchQueue(label: "myQueue", attributes: .concurrent)

que.async {
    print("Task 1 Started")
    print("Task 1 Ended")
}
que.async {
    print("Task 2 Started")
    print("Task 2 Ended")
}

sleep(1)
```
- 위의 코드는 que에서 비동기로 Task 1 Started와 Task 1 Ended를 실행하라고 넣어주고 바로 반환된다.
- 또,  Task 2 Started와 Task 2 Ended 출력 작업을 que에 넣어주고 바로 반환된다.
- 이 코드를 실행해보면 아무것도 출력되지 않고 바로 종료가 되는데, 실행이 안되는것이 아니라 프로그램 종료가 async 처리보다 더 먼저 실행되기 때문에 출력이 안되는것처럼 보인다. 출력을 확인하기 위해서 sleep(1)을 추가해 1초를 기다렸다 프로그램이 종료되도록 만들었다.
- 예상했던 결과는 아래와 같았는데..
    - Task 1 Started
    - Task 2 Started
    - Task 1 Ended
    - Task 2 Ended
- 실제로 나온 결과는 아래와 같다
    - Task 1 Started
    - Task 1 Ended
    - Task 2 Started
    - Task 2 Ended
- 이렇게 나온 이유를 생각해보면, 아마도 병렬로 처리할 틈도 없을만큼 작업의 규모가 작기 때문이 아닐까 생각한다.
