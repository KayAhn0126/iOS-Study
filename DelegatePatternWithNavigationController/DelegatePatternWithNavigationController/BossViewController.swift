//
//  SecondViewController.swift
//  DelegatePatternWithNavigationController
//
//  Created by Kay on 2022/08/25.
//

import UIKit

protocol WhatAssistantNeedsToDo {
    func drive(to: String)
}

class BossViewController: UIViewController {

    var bossCommand: WhatAssistantNeedsToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedHomeButton(_ sender: UIButton) {
        bossCommand?.drive(to: "Home")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedWorkButton(_ sender: UIButton) {
        bossCommand?.drive(to: "Work")
        dismiss(animated: true, completion: nil)
    }
}
