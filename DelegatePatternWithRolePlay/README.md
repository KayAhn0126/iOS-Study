# Delegate Pattern With Role Play
- 이번 프로젝트를 해보면서 느낀것.
- 델리게이트 패턴을 구현할 때는 해야할일(프로토콜)부터 작성 후 Boss -> Assistant 순으로 작성.
- 다른 사람이 구현한 코드를 읽을때는 해야할일(프로토콜) 파악 후 Assistant -> Boss 순으로 파악. 

## 🍎 앱 설명 및 작동 화면 :

- 비서(Assistant)가 보스(Boss)에게 어디로 갈건지 묻고 보스가 대답을 하면 비서가 보스를 대신해 목적지까지 운전하는 앱.
- 보스가 운전해야 하지만 비서에게 운전을 위임하는 논리.

| 작동 화면 |
|:-:|
|  ![](https://i.imgur.com/sIyDXI0.gif)|



## 🍎 앱의 흐름
![](https://i.imgur.com/KDYy3Zi.png)

- 비서가 보스에게 "제가 당신이 해야할 일(운전)을 하겠습니다" -> bossVC.handOver = self
- 

## 🍎 코드 설명
- 기본적으로 이미 설정 되어있는 1번, 3번은 설명 제외.
---
### 비서 - AssistantVC
```swift
import UIKit

class AssistantViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func askBossButtonTapped(_ sender: UIButton) {
        if let bossVC = storyboard?.instantiateViewController(withIdentifier: "BossViewController") as? BossViewController {
            bossVC.handOver = self
            present(bossVC, animated: true, completion: nil)
        }
    }
}

extension AssistantViewController: WhatAssistantNeedsToDo {
    func drive(to: String) {
        answerLabel.text = "Boss said \(to)"
    }
}
```

- 스토리보드에서 해당 identifier가 있다면 BossViewController로 다운 캐스팅해서 bossVC로 만들고 present 메서드로 화면 띄우기.
- 여기서 **bossVC.handOver = self**는 bossVC에있는 handOver 프로퍼티를 현재 VC에서 담당하겠다는 이야기이다.
    - handOver의 타입을 채택하고 준수(프로토콜에 있는 func 구현) 해주어야 한다.
    
    
---
### 보스 - BossVC
```swift
import UIKit

protocol WhatAssistantNeedsToDo {
    func drive(to: String)
}

class BossViewController: UIViewController {

    var handOver: WhatAssistantNeedsToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedHomeButton(_ sender: UIButton) {
        handOver?.drive(to: "Home")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedWorkButton(_ sender: UIButton) {
        handOver?.drive(to: "Work")
        dismiss(animated: true, completion: nil)
    }
}
```
- WhatAssistantNeedsToDo 이름처럼 비서가 해야할 일을 프로토콜로 만들었다.
- var handOver: WhatAssistantNeedsToDo? <- 보스가 비서에게 줄 의무 또는 책임.
- 하단 두개의 @IBAction 메서드가 실행되면,
    - handOver?.drive(to: "~") -> 책임이 있는 사람(비서)에게 drive를 시키는것.
    - dismiss( ~~~~ ) -> modal로 띄워진 화면을 해산시킴(dismiss)
