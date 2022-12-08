# Delegate Protocol with Low Coupling

## 🍎 ViewController간 데이터를 옮기는 방식

### 📖 VC간 결합도가 높은 방식
```swift
class HomeViewController: UIViewController {
    ...
    var receivedData: [FeedModel] = []
    ...
    
    override func viewDidLoad() {
        ...
        ...
        ...
        let input = FeedAPIInput(limit: 100, page: 10)
        let dataManager = FeedDataManager(self)
        dataManager.feedDataManager(input)
    }
    
    func sendData(_ dataFromServer: [FeedModel]) {
        self.receivedData = dataFromServer
        tableView.reloadData()
    }
}

class FeedDataManager {
    var dataDelegate: HomeViewController?
    
    init(_ dataDelegate: HomeViewController? = nil) {
        self.dataDelegate = dataDelegate
    }
    deinit {
        print("deinit")
    }
    
    func feedDataManager(_ parameters: FeedAPIInput) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result {
            case .success(let data):
                self.dataDelegate?.sendData(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
```
- 위와 같이 VC간 결합도가 높은 경우에는 만약 FeedDataManager 클래스로 인스턴스를 생성하면 프로퍼티는 항상 HomeViewController 타입만을 받아야 한다. **즉, 갈아끼우기가 힘들다.**
- protocol을 사용해 높은 결합도를 낮춰 보았다.

### 📖 VC간 결합도가 낮은 방식
```swift
// 프로토콜
protocol DataTransferDelegate {
    func sendData(_ dataFromServer: [FeedModel])
}

// 프로토콜 채택 및 준수
class HomeViewController: UIViewController, DataTransferDelegate {
    ...
    var receivedData: [FeedModel] = []
    ...
    
    override func viewDidLoad() {
        ...
        ...
        ...
        let input = FeedAPIInput(limit: 100, page: 10)
        let dataManager = FeedDataManager(self)
        dataManager.feedDataManager(input)
    }
    
    func sendData(_ dataFromServer: [FeedModel]) {
        self.receivedData = dataFromServer
        tableView.reloadData()
    }
}

// 위임하는 VC를 DataTransferDelegate타입으로!
class FeedDataManager {
    var dataDelegate: DataTransferDelegate?
    
    init(_ dataDelegate: DataTransferDelegate? = nil) {
        self.dataDelegate = dataDelegate
    }
    deinit {
        print("deinit")
    }
    
    func feedDataManager(_ parameters: FeedAPIInput) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result {
            case .success(let data):
                self.dataDelegate?.sendData(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
```
- 이제는 DataTransferDelegate 프로토콜을 채택 및 준수하는 모든 VC는 네트워크로 받아온 데이터를 사용할 수 있다.
