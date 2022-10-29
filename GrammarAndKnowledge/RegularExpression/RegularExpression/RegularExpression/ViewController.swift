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
        print(validateThroughNSRegularExpression("asdjfklasdj"))
        print(validateThroughNSRegularExpression("dkseont123@gmail.com"))
        
        print(validateThroughNSPredicate("asdjfklasdj"))
        print(validateThroughNSPredicate("dkseotn123@gmail.com"))
        
        print("12312312".validateThroughNSPredicate2())
        print("Aa1!123".validateThroughNSPredicate2())
    }

    // MARK: - NSRegularExpression을 통한 정규식
    private func validateThroughNSRegularExpression(_ email: String) -> Bool {
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
    private func validateThroughNSPredicate(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\.[A-Za-z]{2,4}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}

extension String {
    // MARK: - 대문자, 소문자, 특수문자, 숫자 8자 이상
    // ?=.*[A-Z] -> 대문자가
    func validateThroughNSPredicate2() -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$!*%?&])[A-Za-z0-9$@!%*?&]{8,}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}

