# 화면간 데이터 전달 방법

## 🍎 각각의 VC내 프로퍼티를 이용한 데이터 전달
### 📖 설명을 위한 전제 조건
- VC1(preVC)에는 프로퍼티로 myEmail과 myAddress를 가지고 있다.
- VC2(nextVC)에는 프로퍼티로 email과 address를 가지고 있다.

### 📖 다음 화면으로 값 전달하기 (A -> B) 
- 다음 화면을 생성과 동시에 생성하는 ViewController가 가지고 있는 프로퍼티에 값을 저장하는 방법.
```swift
guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as ? NextViewController else {
    return
}

nextVC.email = self.myEmail.text
nextVC.address = self.myAddress.text

// 프레젠테이션 방식으로 새로운 화면 호출 후 전환
self.present(nextVC, animated: true)
or
// navigation stack에 push하는 방식으로 전환
self.navigationController?.pushViewController(nextVC, animated: true)
```


### 📖 이전 화면으로 값 전달하기 (B -> A)
```swift
in nextVC...

let preVC = self.presentingViewController
guard let vc = preVC as ? ViewController else {
    return
}

// preVC의 프로퍼티로 값 전달하기
vc.myEmail = self.email.text
vc.myAddress = self.address.text

// 프레젠테이션 방식으로 현재 VC를 생성 후 호출 했었다면...
self.presentingViewController?.dismiss(animated: true)

// navigation stack에서 pop하는 방식으로 돌아가기
self.navigationController?.popViewController(animated: true)
```

## 🍎 VC를 이용한 데이터 전달 (VC간 결합도 높음)
- GreenVC에서 BlueVC의 프로퍼티(greenVC)에 자신을 넘겨주고, BlueVC에서는 greenVC 프로퍼티를 통해 GreenVC에 있는 메서드 실행.
- 즉, GreenVC -> BlueVC -> GreenVC 메서드 호출
- **GreenVC**
```swift
import UIKit

class GreenViewController: UIViewController{

    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendData(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "BlueViewController") as? BlueViewController else {
            return
        }
        
        vc.data = "hello blue"
        vc.greenVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkRespose(str : String) -> Void {
        print("잘 받았나? :\(str)")
    }
}
```

- **BlueVC**
```swift
import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    var data : String = ""
    var greenVC : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataLabel.text = data
        
        guard let vc = self.greenVC as? GreenViewController else {
            return
        }
        vc.checkRespose(str: "recieve success")
    }
}
```

## 🍎 Delegate 이용 (VC간 결합도 낮음 + Retain Cycle 예방)
- 먼저 결합도를 낮추기 위해 프로토콜 생성
```swift
protocol ReceiveDataDelegate: AnyObject {
    func receiveData(response : String) -> Void
}
```
- GreeenVC는 SendDataDelegate를 채택, receiveData를 GreenVC내 정의.
- 이후 BlueVC로 이동 전 BlueVC의 SendDataDelegate프로퍼티를 자신(GreenVC)로 지정.
- **GreenVC**
```swift
class GreenViewController: UIViewController, ReceiveDataDelegate {

    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popBlueVC(_ sender: Any) {
        guard let blueVC = self.storyboard?.instantiateViewController(identifier: "BlueViewController") as? BlueViewController else { return }
        
        blueVC.workDelegate = self
        self.navigationController?.pushViewController(blueVC, animated: true)
    }

    func receiveData(response: String) {
        print("response : \(response)")
    }
}
```
- BlueVC
```swift
import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    var data : String = ""
    weak var workDelegate : ReceiveDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataLabel.text = data
        
        workDelegate?.receiveData(response: "delegate works well~")
        self.navigationController?.popViewController(animated: true)
    }
}
```
- VC를 이용해 데이터를 전달하면 직접적으로 서로를 참조하고 있지만 프로토콜을 이용하면 두 VC가 프로토콜을 사이에 두고 연결된다.

## 🍎 클로져를 이용해 데이터 전달
- GreenVC
```swift
import UIKit

class GreenViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    var messageFromBlueVC: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendData(_ sender: Any) {
        guard let blueVC = self.storyboard?.instantiateViewController(identifier: "BlueViewController") as? BlueViewController else { return }
        
        blueVC.completioHandler = { [unowned self] msg in
            self.messageFromBlueVC = msg
            print(self.messageFromBlueVC)
        }
        
        self.navigationController?.pushViewController(blueVC, animated: true)
    }

}
```
- GreenVC에서 BlueVC의 completionHandler를 구현, 작동되는 시점은 BlueVC에서 호출할 때 작동.
```swift
import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet weak var responseButton: UIButton!

    var completioHandler : ((String) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func responseToGreen(_ sender: Any) {
        completioHandler?("hello green~")
        self.navigationController?.popViewController(animated: true)
    }
}
```
- 클로져로 데이터를 전달하면 delegate처럼 프로토콜, 메서드 없이 바로 처리 가능하다.

## 🍎 NotificationCenter를 이용한 데이터 전달
- VC들이 서로 독립적이고 연관이 없는 경우 사용
- GreenVC
```swift
import UIKit

class GreenViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(printMessage), name: Notification.Name(rawValue: "SendMessage"), object: nil)
    }
    
    @IBAction func popBlueVC(_ sender: Any) {
        guard let blueVC = self.storyboard?.instantiateViewController(identifier: "BlueViewController") as? BlueViewController else { return }
        
        self.navigationController?.pushViewController(blueVC, animated: true)
    }
    
    @objc func printMessage(_ notification : Notification) {
        let msg = notification.object as? String
        print("message : \(msg!)")
        
    }
}
```
- BlueVC
```swift
import UIKit

class BlueViewController: UIViewController {
    
    @IBOutlet weak var responseButton: UIButton!
    
    var data : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func responseToGreen(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SendMessage"), object: "hello green")
        self.navigationController?.popViewController(animated: true)
    }
}
```

## 🍎 Citation
[nnnyeong](https://velog.io/@nnnyeong/iOS-VC-%EA%B0%84-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EC%A0%84%EB%8B%AC-%EB%B0%A9%EB%B2%95)
