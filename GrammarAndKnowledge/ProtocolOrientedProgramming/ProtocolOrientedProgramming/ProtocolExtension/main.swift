//
//  main.swift
//  ProtocolExtension
//
//  Created by Kay on 2023/06/15.
//

import Foundation

//MARK: 1. 프로토콜에서 아주 기본적인 속성이나 행동은 extension으로 미리 지정해주자!

 protocol Telephone {
    var phoneNo: String { get set }
    func call()
    func hangup()
}

// 아래와 같이 Cellphone, LandlinePhone 클래스를 선언하고 Telephone 프로토콜을 채택하면 Telephone 프로토콜의 프로퍼티와 메소드를 정의해주어야 한다.

class Cellphone: Telephone {
    var phoneNo: String
    
    init() {
        self.phoneNo = "010-1234-5678"
    }
    
    func call() {
        // call
    }
    
    func hangup() {
        // hangup
    }
}

class LandlinePhone: Telephone {
    var phoneNo: String
    
    init() {
        self.phoneNo = "010-1234-5678"
    }
    
    func call() {
        // call
    }
    
    func hangup() {
        // hangup
    }
}

// 위와 같은 경우 call()과 hangup()이 중복되는것을 볼 수 있다. 어차피 call()과 hangup()의 기능은 똑같으니 초기에 정의하면 어떨까?
// 아래와 같이 많이 쓰이는 메서드들은 extension으로 빼주자!
extension Telephone {
    func call() {
        
    }
    
    func hangup() {
        
    }
}

// protocol 채택시 준수해야 하는 func들은 extension에서 준수(구현) 해주었으니, 다른 클래스를 만들어 func을 따로 준수(구현)해야하는지 테스트 해보자!
class ButtonPhone: Telephone {
    // extension에서 메서드들은 정의 되어 있지만 phoneNo은 정의되어 있지 않음으로 프로토콜 내 프로퍼티를 준수해주어야 한다.
    var phoneNo: String
    
    init(_ number: String) {
        self.phoneNo = number
    }
}

//MARK: 결과 -> extension에서 준수 해주었으니 클래스에서 프로토콜 채택 후 따로 준수하지 않아도 된다. 위의 경우 phoneNo는 준수하지 않았으니 준수 해줘야 한다.
