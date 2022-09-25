# @Sendable 키워드

## 🍎 @Sendable이 왜 궁금했을까?
- URLSession의 dataTask(...)메서드 정의부에 가면 아래와 같이 정의되어 있다.
```swift
open func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
```
- 여기서 @escaping 키워드는 무엇인지 알았으나 @Sendable 키워드가 어떤 역할을 하는지 궁금했다.
- 먼저 아래의 내용을 공식문서에서 찾을 수 있었다.

![](https://i.imgur.com/eKCe1iF.png)
- **function과 closure가 캡쳐하는 모든 값들은 sendable 해야한다. sendable 클로저는 값으로만 캡처된 것만 사용해야 하며 캡처된 값은 보낼 수 있는 유형이어야 한다.** 라고 나와있다.
```
"sendable 클로저는 값으로만 캡처된 것만 사용해야 하며 캡처된 값은 보낼 수 있는 유형이어야 한다"
```
- 이 문장은 사실 무슨 뜻인지 잘 모르겠다. 
```
function과 closure가 캡쳐하는 모든 값들은 sendable 해야한다
```
- 하지만 이 문장이 무엇을 뜻하고 코드에서 어떤 역할을 하는지 알것 같아 기록한다.
- 나중에 이것을 물어볼 수 있는 사람을 만나면 내가 생각했던게 맞는지 물어보기!

## 🍎 생각 정리 시작
- [Error 열거형 선언 / 데이터 수신 여부에 따른 프로세스(escaping)](https://github.com/KayAhn0126/Network/blob/main/Network%20in%20iOS.playground/Pages/Fetch%20Method.xcplaygroundpage/Contents.swift)내 NetworkService 클래스의 fetchProfile 메서드를 보자.

```swift
func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(userName)")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
                                                
            // data -> GithubProfile
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error as NSError {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
```

- fecthProfile 메서드를 호출하는 곳도 살펴보자
```swift
let network = NetworkService(configuration: .default)
network.fetchProfile(userName: "kayahn0126") { result in
    switch result {
    case .success(let profile):
        print("Received: \(profile)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```
- 먼저 1번 라인에서 network 객체가 생성되고 해당 객체로 fetchProfile을 호출한다. 
- 2번 라인 끝에있는 클로져는 fetchProfile 메서드의 내부가 모두 실행되고 받아온 값(result)으로 switch 분기를 실행하고있다.
- 여기서 fetchProfile 메서드의 내부가 모두 실행되고 받아온 값(result)은 어떻게 받아왔을까?
    - 누군가가 보냈으니 받을수 있다. -> "받는다"라는건 누군가 "보낸다"라는 의미.
    - 누가 뭘 보냈을까? 다시 dataTask의 정의부를 보자
```swift
open func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
```
- @Sendable 뒤 클로져가 있고, 위에서 이야기 했듯이
```
function과 closure가 캡쳐하는 모든 값들은 sendable 해야한다.
```
- 즉 (Data?, URLResponse?, Error?) -> Void 클로져 실행 도출된 결과값은 sendable하다는 이야기이다.
- 현재 코드에서 (Data?, URLResponse?, Error?) -> Void 클로져가 실행되고 남은 결과값은 아래와 같다.
```swift
.failure(NetworkError.transportError(error)) // error 발생시
                    or
.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)) // statusCode의 범위가 200이상 300미만이 아닐때
                    or
.failure(NetworkError.noData) // 데이터가 없을때
                    or
.success(profile)    // GithubProfile 형태로 decode가 잘되었을 때
                    or
.failure(NetworkError.decodingError(error)) // GithubProfile 형태로 decode에 실패 했을때
```
- 결과값을 fetchProfile 메서드의 escaping closure인 completion: (Result<GithubProfile, Error>) -> Void 클로져의 Result<GithubProfile,Error> 자리에 보내면 fetchProfile을 호출하는 곳의 클로져에서 result로 받을것이다.
