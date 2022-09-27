//
//  ViewController.swift
//  NotificationCenterPractice
//
//  Created by Kay on 2022/06/28.
//

import UIKit

// 울음 열거형
enum Crying: String {
    case Cry
}

// 이유 열거형
enum Reason: String {
    case Hungry
    case Sleepy
    case Sick
    case Noreason
    
    var reason: String {
        switch self {
        case .Hungry :
            return "Hungry"
        case .Sleepy :
            return "Sleepy"
        case .Sick :
            return "Sick"
        case .Noreason :
            return "NoReason"
        }
    }
    
    var treatMessage: String {  // 이유에 따라 대응 메세지 전달
        switch self {
        case .Hungry :
            return "okay babe, i will bring some!"
        case .Sleepy :
            return "let's listen to classical music!"
        case .Sick :
            return "Oh! you are getting sweaty!"
        case .Noreason:
            return "babe, why are you crying?"
        }
    }
}

// 알림 이름
extension Notification.Name {
    static let identifier = Notification.Name("Crying")
}

// 아기가 울면 왜 우는지 메세지를 같이 전달하는 코드이다.

// 부모가 아기에게 신경을 쓴다 -> (옵져버 추가)
// 아기는 자신이 왜 우는지 이유를 담아 알린다 -> (Post)
// 옵져버를 추가했을때 매개변수로 넣어준 #selector(@objc func)을 실행 시켜준다.

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForBaby()
    }
    // 부모가 아기에게 신경을 쓰기 시작한다.
    private func addObserverForBaby() {
        NotificationCenter.default.addObserver(self, selector: #selector(careBady(_:)), name: Notification.Name.identifier, object: nil)
    }
    
    // 아기가 울면 부모에게 신호를 보낸다
    // userInfo에 우는 이유를 담아 보낸다. userInfo는 [AnyHashable : Any] 형태 <- 중요!
    @IBAction private func startCrying(buttonTitle: UIButton) {
        var userInfo: [AnyHashable : Any]? = [:]                    // 빈 딕셔너리를 만들어주고
        
        guard let title = buttonTitle.titleLabel else { return }    // 누르는 버튼에 따라 타이틀이 달라진다!
        
        switch title.text {
        case Reason.Hungry.reason:
            userInfo = [Crying.Cry: Reason.Hungry.reason]
        case Reason.Sleepy.reason:
            userInfo = [Crying.Cry: Reason.Sleepy.reason]
        case Reason.Sick.reason:
            userInfo = [Crying.Cry: Reason.Sick.reason]
        default:
            userInfo = [Crying.Cry: Reason.Noreason.reason]
        }
        
        NotificationCenter.default.post(name: Notification.Name.identifier, object: nil,  userInfo: userInfo)
    }
    
    // 아기가 어떤 특정한 이유로 울게되면 부부는 이유에 따라 케어를 한다.
    @objc func careBady(_ CryingInfo: Notification) {
        guard let reason = CryingInfo.userInfo?[Crying.Cry] as? String else { return }
        switch reason {
        case Reason.Hungry.reason :
            let alert = UIAlertController(title: "Your Title", message: "Your Message", preferredStyle: UIAlertController.Style.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
                print(Reason.Hungry.treatMessage)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            
            
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            present(alert, animated: false)
        case Reason.Sleepy.reason :
            print(Reason.Sleepy.treatMessage)
        case Reason.Sick.reason :
            print(Reason.Sick.treatMessage)
        default :
            print(Reason.Noreason.treatMessage)
        }
    }
}
