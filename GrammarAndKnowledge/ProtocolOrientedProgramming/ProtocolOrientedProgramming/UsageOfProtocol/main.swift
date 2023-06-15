//
//  main.swift
//  UsageOfProtocol
//
//  Created by Kay on 2023/06/15.
//

/*
 간단한 hands - on 프로젝트로 프로토콜의 사용법을 알아보자.
 Plan
 - RotaryPhone: Landline Telephone, Rotaryable
 - PushButtonPhone: Landline Telephone, PushButtonable
 - NonSmartPhone: Cellular Telephone, PushButtonable
 - SmartPhone: Cellular Telephone, Touchable
 */

import Foundation

protocol Telephone {
    var phoneNo: String { get set }
    func call()
    func hangup()
}

extension Telephone {
    func call() {
        // call
    }
    
    func hangup() {
        // hangup
    }
}

protocol Landline: Telephone {
    
}

protocol Cellular: Telephone {
    func sendSMS()
}

protocol Rotaryable {
    func rotaryInput()
}

protocol PushButtonable {
    func buttonInput()
}

protocol Touchable {
    func touchInput()
}

class RotaryPhone: Landline, Rotaryable {
    func rotaryInput() {
        // rotaryInput implementation goes here
    }
    
    var phoneNo: String
    
    init(_ number: String) {
        self.phoneNo = number
    }
}

class PushButtonPhone: Landline, PushButtonable {
    func buttonInput() {
        // buttonInput implementation goes here
    }
    
    var phoneNo: String
    
    init(_ number: String) {
        self.phoneNo = number
    }
}

class NonSmartPhone: Cellular, PushButtonable {
    func sendSMS() {
        // from Cellular protocol
    }
    
    func buttonInput() {
        // from PushButtonable protocol
    }
    
    var phoneNo: String
    
    init(_ number: String) {
        self.phoneNo = number
    }
}

class SmartPhone: Cellular, Touchable {
    func sendSMS() {
        // from Cellular protocol
    }
    
    func touchInput() {
        // from Touchable protocol
    }
    
    var phoneNo: String
    
    init(_ number: String) {
        self.phoneNo = number
    }
}
