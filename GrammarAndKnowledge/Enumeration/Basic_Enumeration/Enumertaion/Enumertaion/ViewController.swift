//
//  ViewController.swift
//  Enumertaion
//
//  Created by Kay on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myIphoneDetail = AppleProductEnum.iPhone(model: .twelve_pro_max, storage: .two_fifty_six, color: .gold)
        checkPhone(myIphoneDetail: myIphoneDetail)
    }
    
    func checkPhone(myIphoneDetail: AppleProductEnum) {
        switch myIphoneDetail {
        case .iPhone(.thirteen_pro_max, .five_twelve, .skyblue) :
            print("minsson's iphone")
            break
        case .iPhone(.twelve_pro_max, .two_fifty_six, .gold):
            print("kay's iphone")
            break
        case .iPhone(_, .two_fifty_six, _):
            print("256!")
            break
        case .iPhone(_,_,.gold) :
            print("gold!")
            break
        case .iPhone:
            print("iPhone")
            break
        default :
            print("default")
            break
        }
    }
}


