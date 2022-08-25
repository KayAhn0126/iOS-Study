//
//  ViewController.swift
//  DelegatePatternWithNavigationController
//
//  Created by Kay on 2022/08/25.
//

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

