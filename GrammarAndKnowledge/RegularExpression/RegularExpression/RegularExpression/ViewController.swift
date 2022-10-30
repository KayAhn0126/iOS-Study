//
//  ViewController.swift
//  RegularExpression
//
//  Created by Kay on 2022/10/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(emailValidateThroughNSRegularExpression("dkseotn123@gmail.com")) // OK
        print(emailValidateThroughNSRegularExpression("dkseont123@gmail.comaa")) // X ( . 이후에는 2~4글자 사이여야한다)
        print(emailValidateThroughNSRegularExpression("dkseotn123@gmail.com1")) // X (. 이후에는 오직 영어만 가능)
        
        print(emailValidateThroughNSPredicate("asdjfklasdj"))
        print(emailValidateThroughNSPredicate("dkseotn123@gmail.comjh"))
        
        print("12312312".validateThroughNSPredicate2())
        print("Aa1112311!".validateThroughNSPredicate2())
        print("AS@asd.9293".customCheck())
        print("@ASasd.9239".customCheck())
    }

    // MARK: - NSRegularExpression을 통한 정규식
    private func emailValidateThroughNSRegularExpression(_ email: String) -> Bool {
        // "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}$" <-- 기존 정규식
        //                                     ^
        //                                     |
        //                                     |
        //                     전체 정규식을 '#'으로 감싸면 화살표 부분을 아래와 같이 사용할 수 있다.
        // #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"# <-- '#'으로 감싼 정규식
        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"#
        let regex = try? NSRegularExpression(pattern: emailPattern)
        let range = NSRange(location: 0, length: email.count)
        if regex?.firstMatch(in: email, range: range) != nil {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - NSPredicate를 통한 정규식
    private func emailValidateThroughNSPredicate(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}

extension String {
    // "Hello world".validateThroughNSPredicate2()  <-- 이렇게 사용하기 위해 extension으로 뺌.
    // MARK: - 대문자, 소문자, 특수문자, 숫자 각각 1자씩 꼭 들어가야한다 + 8자 이상
    func validateThroughNSPredicate2() -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!*%?&]).{8,}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
    // (?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!*%?&]) -> 대문자 1개, 소문자 1개, 숫자 1개, 특수문자 1개 를 충족해야 한다.
    // .{8,} -> 길이는 최소 8이상이 되야한다.
    // (?=.*[A-Z].*[A-Z]) -> 대문자가 2자 이상 있어야 한다.
    // (?=.*[a-z].*[a-z].*[a-z]) -> 소문자가 3자 이상 있어야 한다.
    
    func customCheck() -> Bool {
        let regularExpression = "^[A-Z]{2}+@[a-z]{3}+\\.[0-9]{4}$"
        let validation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return validation.evaluate(with: self)
    }
}

