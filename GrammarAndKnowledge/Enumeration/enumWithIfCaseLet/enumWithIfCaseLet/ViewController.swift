//
//  ViewController.swift
//  enumWithIfCaseLet
//
//  Created by Kay on 2022/12/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myFood = Bunsik.kimbob
        checkMyFood(myFood: myFood)
        
        let ddoekboki = Bunsik.ddeokboki(riceCake: 30.0, fishCake: 70.0)
        checkDdoekbokiRate(food: ddoekboki)
    }
    
    func checkMyFood(myFood: Bunsik) {
        switch myFood {
        case .kimbob:
            print("kimbob")
        case .ddeokboki:
            print("ddokboki")
        }
    }
    
    // if case let을 사용해 보일러 플레이트 코드를 줄여보자
    func checkDdoekbokiRate(food: Bunsik) {
        // 기존 코드 -> 떡볶이의 비율을 알아보는데에도 어쩔수 없이 모든 케이스를 적어줘야 했다.
        /*
        switch food {
        case .kimbob:
            print("this is not Ddoekboki!!")
            break
        case .ddeokboki(let riceCake, let fishCake):
            print("riceCake percent is: \(riceCake) and fishCake percent is \(fishCake)")
            break
        }
        */
        
        
        
        // 하나의 케이스를 처리하고 아직도 'Switch must be exhaustive'라는 에러가 발생하기 때문에 default 구문도 작성 해줘야 한다.
        /*
        switch food {
        case .ddeokboki(let riceCake, let fishCake):
            print("riceCake percent is: \(riceCake) and fishCake percent is \(fishCake)")
        default:
            print("this function is for checking rate of Ddoekboki!")
            break
        }
        */
        
        // if case let 사용으로 보일러 플레이트 코드를 줄여보자
        // 모든 케이스에 대해 처리할 필요도 없고 또는 하나의 케이스 + default 구문이 필요없이 간단하게 한줄로 처리 가능하다.
        if case let .ddeokboki(riceCake, fishCake) = food {
            print("이 떡볶이는 \(riceCake)퍼센트 만큼의 떡과 \(fishCake)퍼센트 만큼의 오뎅이 들어가있네요!")
        }
    }
}

