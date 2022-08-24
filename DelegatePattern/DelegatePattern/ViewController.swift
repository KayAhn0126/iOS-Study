//
//  ViewController.swift
//  DelegatePattern
//
//  Created by Kay on 2022/08/24.
//

import UIKit

protocol PrepareParty: AnyObject {
    func prepareFood()
    func prepareSong()
}

class PartyDirector {
    var delegate: PrepareParty?
    
    func order() {
        self.delegate?.prepareFood() // 내가 위임한 사람(대리자)의 prepareFood()를 실행해라
        self.delegate?.prepareSong()
    }
}

class FirstPartyWorker: PrepareParty {
    init(director: PartyDirector) {
        director.delegate = self
    }
    func prepareFood() {
        print("first worker is preparing food!")
    }
    func prepareSong() {
        print("first worker will sing a song!")
    }
}


class SecondPartyWorker: PrepareParty {
    init(director: PartyDirector) {
        director.delegate = self
    }
    func prepareFood() {
        print("second worker is preparing food!")
    }
    func prepareSong() {
        print("second worker will sing a song!")
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let Kay = PartyDirector()
        let worker1 = FirstPartyWorker(director: Kay)
        Kay.order()
        let worker2 = SecondPartyWorker(director: Kay)
        Kay.order()
    }
}
